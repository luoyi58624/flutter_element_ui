part of 'index.dart';

/// onTapUp 延迟触发时间，设置一定的延迟时间可以让点击效果更加明显
const int _tapUpDelay = 100;

class _ElEventState extends State<ElEvent> {
  late _Prop _prop;
  bool bubbleFlag = true; // 冒泡标识，如果此标识变成 false，意味着后代组件阻止了事件冒泡
  GlobalKey childKey = GlobalKey();
  Size childSize = Size.zero; // 子组件的尺寸
  int pointType = kPrimaryButton; // 指针按下时的类型，例如：鼠标左键 = 1，右键 = 2
  Offset tapDownOffset = Offset.zero; // 指针按下位置（全局坐标系）
  int? tapDownTime; // 记录当前的按下时间
  bool isPrimaryPoint = false; // 鼠标按下的是否是主指针
  bool isCancel = false; // 是否触发了取消事件
  bool isActiveDoubleTap = false; // 是否激活了双击
  bool isActiveLongPress = false; // 是否激活了长按

  final _isHover = Obs(false); // 悬停状态响应式变量，此属性会注入到 InheritedWidget 小部件
  final _isTap = Obs(false); // 点击状态响应式变量，此属性会注入到 InheritedWidget 小部件
  bool hasHoverDepend = false; // 是否存在悬停状态依赖
  bool hasTapDepend = false; // 是否存在点击状态依赖

  // 拖拽事件，当用户注册了 onMoveEnd、onVerticalMoveEnd、onHorizontalMoveEnd 时将会初始化，
  // 这个类主要就是计算用户停止触摸时的力度，通过这个力度值可以执行惯性滚动动画
  _DragEvent? _drag;
  late bool hasMoveEvent;
  late bool hasMoveEndEvent;

  Timer? _tapUpTimer; // 指针抬起延迟释放计时器

  bool get isHover => _isHover.value;

  set isHover(bool value) {
    if (hasHoverDepend) _isHover.value = value;
  }

  bool get isTap => _isTap.value;

  set isTap(bool value) {
    if (hasTapDepend) _isTap.value = value;
  }

  void setHoverDepend(bool value) {
    hasHoverDepend = value;
  }

  void setTapDepend(bool value) {
    hasTapDepend = value;
  }

  /// 鼠标进入目标区域事件
  void onEnter(PointerEnterEvent e) {
    isHover = true;
    _prop.onEnter?.call(e);
  }

  /// 鼠标离开目标区域事件
  void onExit(PointerExitEvent e) {
    isHover = false;
    _prop.onExit?.call(e);
  }

  /// 指针按下事件
  void onPointerDown(PointerDownEvent e) async {
    if (!bubbleFlag) return;
    stopPropagationByWidget();
    pointType = e.buttons;
    isPrimaryPoint = pointType == kPrimaryButton;
    tapDownOffset = e.position;
    tapDownTime = currentMilliseconds;
    isCancel = false;
    isTap = true;

    if (isPrimaryPoint) {
      _prop.onPointerDown?.call(e);
      _drag?.onStart(e);

      // 尝试注册长按事件计时器，需要限制鼠标指针，只能长按鼠标左键
      if (_prop.onLongPress != null) longPressHandler();
    }

    // 在 web 平台上，如果设置了 prevent 属性，鼠标右键按下时将阻止浏览器默认菜单
    if (kIsWeb) {
      if (_prop.prevent && pointType == kSecondaryButton) {
        await BrowserContextMenu.disableContextMenu();
      }
    }

    // 取消指针抬起延迟计时器
    if (_tapUpTimer != null) {
      _tapUpTimer!.cancel();
      _tapUpTimer = null;
    }
  }

  /// 指针抬起事件
  void onPointerUp(PointerUpEvent e) {
    resetBubbleBuilderWidget();
    if (!bubbleFlag) {
      bubbleFlag = true;
      return;
    }
    if (hasMoveEndEvent && isPrimaryPoint) _drag!.onEnd(e);
    if (isCancel == false) {
      if (isPrimaryPoint) {
        if (_prop.onDoubleTap != null) {
          doubleTapHandler();
        }
        tapHandler();
        isActiveDoubleTap = false;
        isActiveLongPress = false;
      } else if (pointType == kSecondaryButton) {
        contextMenuHandler();
      }
    }
    int delay = _tapUpDelay;
    if (tapDownTime != null) {
      delay = max(delay - (currentMilliseconds - tapDownTime!), 0);
    }
    _tapUpTimer = setTimeout(() {
      _tapUpTimer = null;
      tapDownTime = null;
      if (mounted) {
        _prop.onPointerUp?.call(e);
        isTap = false;
      }
    }, delay);
  }

  /// 指针取消事件
  void onPointerCancel() {
    resetBubbleBuilderWidget();
    if (!bubbleFlag) {
      bubbleFlag = true;
      return;
    }
    if (isCancel) return;
    isCancel = true;
    _cancelLongPressTimer();
    _tapUpTimer = setTimeout(() {
      _tapUpTimer = null;
      tapDownTime = null;
      if (mounted) {
        _prop.onPointerCancel?.call();
        isTap = false;
      }
    }, _tapUpDelay);
  }

  /// 指针移动事件
  void onPointerMove(PointerMoveEvent e) {
    if (!bubbleFlag) return;
    if (isPrimaryPoint) _drag?.onMove(e);
    if (isCancel == false &&
        isActiveLongPress == false &&
        hasMoveEvent == false) {
      // 如果指针离开元素，则立即取消
      if (!childSize.contains(e.localPosition)) {
        onPointerCancel();
      }
      // 如果指针移动偏移大于预定值，则取消
      else if ((e.position - tapDownOffset).distance > _prop.cancelScope) {
        onPointerCancel();
      }
    }
  }

  /// 指针信号事件
  void onPointerSignal(PointerSignalEvent e) {
    if (!bubbleFlag) return;
    _prop.onPointerSignal?.call(e);
  }

  /// 单击事件处理，此函数会在 [onPointerUp] 指针抬起时执行
  void tapHandler() {
    // 如果设置了等待双击延迟，需要判断双击计时器是否开始、或者是否已经触发了双击，若为 true 那么禁止执行单击事件
    if (_prop.delayTapForDouble &&
        (_doubleTapTimer != null || isActiveDoubleTap)) return;
    // 如果没有注册长按事件，那么直接触发单击事件
    if (_prop.onLongPress == null) {
      _prop.onTap?.call();
    } else {
      // 如果指针抬起时没有达到长按阈值时间，那么也将触发点击事件，同时还需要取消长按计时器
      if (isActiveLongPress == false) {
        _prop.onTap?.call();
        _cancelLongPressTimer();
      }
    }
  }

  Timer? _doubleTapTimer;

  /// 双击事件处理，此函数会在 [onPointerUp] 指针抬起时执行
  void doubleTapHandler() {
    // 若触发了长按则直接返回
    if (isActiveLongPress) return;
    if (_doubleTapTimer != null) {
      _doubleTapTimer!.cancel();
      _doubleTapTimer = null;
      isActiveDoubleTap = true;
      _prop.onDoubleTap!();
    } else {
      _doubleTapTimer = setTimeout(() {
        _doubleTapTimer = null;
        // 双击计时器到了销毁时间，如果设置了等待双击延迟，那么触发点击事件
        if (_prop.delayTapForDouble) {
          _prop.onTap?.call();
        }
      }, _prop.doubleTapTimeout);
    }
  }

  Timer? _longPressTimer;

  /// 长按事件处理，此函数会在 [onPointerDown] 指针按下时执行
  void longPressHandler() {
    _longPressTimer = setTimeout(() {
      _longPressTimer = null;
      isActiveLongPress = true;
      if (_prop.feedback) HapticFeedback.mediumImpact();
      _prop.onLongPress!();
    }, _prop.longPressTimeout);
  }

  void _cancelLongPressTimer() {
    if (_longPressTimer != null) {
      _longPressTimer!.cancel();
      _longPressTimer = null;
    }
  }

  /// 右键处理，此函数会在 [onPointerUp] 指针抬起时执行
  void contextMenuHandler() async {
    if (kIsWeb) {
      if (_prop.prevent) {
        await BrowserContextMenu.enableContextMenu();
      }
    }
    _prop.onContextMenu?.call();
  }

  /// 阻止事件冒泡，此函数会从当前 Element Tree 的位置开始，一层一层向上查找所有 [ElEvent] 实例，
  /// 将它们的 [bubbleFlag] 冒泡标识设置为 false。
  ///
  /// 提示：修改 [bubbleFlag] 标识不会触发 UI 重建，而且向上查找时间复杂度为 O(1)，
  /// 所以无需担心性能问题。
  void stopPropagation() {
    if (bubbleFlag) {
      bubbleFlag = false;
      _ElEventInheritedWidget._stopPropagation(context);
    }
  }

  /// 根据 [ElStopPropagation] 尝试阻止事件冒泡，此方法会以 [ElStopPropagation]
  /// 所在 Element Tree 的位置开始，向上查找 [ElEvent] 小部件并执行阻止冒泡函数
  void stopPropagationByWidget() {
    context
        .getElementForInheritedWidgetOfExactType<ElStopPropagation>()
        ?.stopPropagation();
  }

  /// 重置 [ElBubbleBuilder] 小部件的状态
  void resetBubbleBuilderWidget() {
    if (_ElBubbleInheritedWidget.triggerFlag) {
      _ElBubbleInheritedWidget.triggerFlag = false;
      _ElBubbleInheritedWidget._updateBubbleFlag(context, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    _prop = _Prop.create(context, widget);

    assert(
      DartUtil.listOnlyOne([
        _prop.onMove,
        _prop.onVerticalMove,
        _prop.onHorizontalMove,
      ]),
      'onMove、onVerticalMove、onHorizontalMove 只能存在一个',
    );
    assert(
      DartUtil.listOnlyOne([
        _prop.onMoveEnd,
        _prop.onVerticalMoveEnd,
        _prop.onHorizontalMoveEnd
      ]),
      'onMoveEnd、onVerticalMoveEnd、onHorizontalMoveEnd 只能存在一个',
    );

    hasMoveEndEvent = _prop.onMoveEnd != null ||
        _prop.onVerticalMoveEnd != null ||
        _prop.onHorizontalMoveEnd != null;

    hasMoveEvent = _prop.onMove != null ||
        _prop.onVerticalMove != null ||
        _prop.onHorizontalMove != null ||
        hasMoveEndEvent;

    // 注册拖拽事件
    if (hasMoveEvent) {
      _drag ??= _DragEvent(_prop);
    } else {
      if (_drag != null) _drag = null;
    }

    nextTick(() {
      childSize = childKey.currentContext?.size ?? Size.zero;
    });

    Widget result = ObsBuilder(
      builder: (context) {
        return _ElEventInheritedWidget(
          isHover: isHover,
          setHoverDepend: setHoverDepend,
          isTap: isTap,
          setTapDepend: setTapDepend,
          stopPropagation: stopPropagation,
          child: Builder(
            key: childKey,
            builder: (context) {
              return widget.child ?? widget.builder!(context);
            },
          ),
        );
      },
    );

    // 只有在桌面端才渲染鼠标悬停小部件
    if (PlatformUtil.isDesktop) {
      if (_prop.disabled) isHover = false;
      result = MouseRegion(
        cursor: _prop.cursor,
        hitTestBehavior: _prop.hitTestBehavior,
        onHover: _prop.disabled ? null : _prop.onHover,
        onEnter: _prop.disabled ? null : onEnter,
        onExit: _prop.disabled ? null : onExit,
        child: result,
      );
    }

    return Listener(
      behavior: _prop.hitTestBehavior,
      onPointerDown: _prop.disabled ? null : onPointerDown,
      onPointerUp: _prop.disabled ? null : onPointerUp,
      onPointerCancel: _prop.disabled ? null : (e) => onPointerCancel(),
      onPointerMove: _prop.disabled ? null : onPointerMove,
      onPointerSignal: _prop.disabled ? null : onPointerSignal,
      child: result,
    );
  }
}

class _ElEventInheritedWidget extends InheritedWidget {
  const _ElEventInheritedWidget({
    required super.child,
    required this.isHover,
    required this.setHoverDepend,
    required this.isTap,
    required this.setTapDepend,
    required this.stopPropagation,
  });

  final bool isHover;
  final ElBoolVoidCallback setHoverDepend;
  final bool isTap;
  final ElBoolVoidCallback setTapDepend;
  final VoidCallback stopPropagation;

  static _ElEventInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElEventInheritedWidget>();

  static bool getHoverStatus(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) result.setHoverDepend(true);
    return result?.isHover ?? false;
  }

  static bool getTapStatus(BuildContext context) {
    final result = maybeOf(context);
    if (result != null) result.setTapDepend(true);
    return result?.isTap ?? false;
  }

  static void _stopPropagation(BuildContext context) {
    context
        .getInheritedWidgetOfExactType<_ElEventInheritedWidget>()
        ?.stopPropagation();
  }

  @override
  bool updateShouldNotify(_ElEventInheritedWidget oldWidget) {
    return isHover != oldWidget.isHover || isTap != oldWidget.isTap;
  }
}
