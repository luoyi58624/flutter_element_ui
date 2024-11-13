part of 'index.dart';

class _ElEventState extends State<ElEvent> {
  late _Prop _prop;
  bool bubbleFlag = true; // 冒泡标识，如果此标识变成 false，意味着后代组件阻止了事件冒泡
  GlobalKey childKey = GlobalKey();
  Size childSize = Size.zero; // 子组件的尺寸
  int pointType = kPrimaryButton; // 指针按下时的类型，例如：鼠标左键 = 1，右键 = 2
  Offset tapDownOffset = Offset.zero; // 指针按下位置（全局坐标系）
  int? tapDownTime; // 记录当前的按下时间
  bool isCancel = false; // 是否触发了取消事件
  bool isActiveDoubleTap = false; // 是否激活了双击
  bool isActiveLongPress = false; // 是否激活了长按

  final _isHover = Obs(false); // 悬停状态响应式变量，此属性会注入到 InheritedWidget 小部件
  final _isTap = Obs(false); // 点击状态响应式变量，此属性会注入到 InheritedWidget 小部件
  bool hasHoverDepend = false; // 是否存在悬停状态依赖
  bool hasTapDepend = false; // 是否存在点击状态依赖

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
  void onPointDown(PointerDownEvent e) {
    if (!bubbleFlag) return;
    checkBubbleWidget();
    _prop.onTapDown?.call(e);
    pointType = e.buttons;
    tapDownOffset = e.position;
    tapDownTime = currentMilliseconds;
    isCancel = false;

    // 取消指针抬起延迟计时器
    if (_tapUpTimer != null) {
      _tapUpTimer!.cancel();
      _tapUpTimer = null;
    }

    // 尝试注册长按事件计时器，需要限制鼠标指针，只能长按鼠标左键
    if (_prop.onLongPress != null && pointType == kPrimaryButton) {
      longPressHandler();
    }

    isTap = true;
  }

  /// 指针抬起事件
  void onPointUp(PointerUpEvent e) {
    if (!bubbleFlag) return;
    if (isCancel == false) {
      if (pointType == kPrimaryButton) {
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
    int delay = _prop.tapUpDelay;
    if (tapDownTime != null) {
      delay = max(delay - (currentMilliseconds - tapDownTime!), 0);
    }
    _tapUpTimer = setTimeout(() {
      _tapUpTimer = null;
      tapDownTime = null;
      if (mounted) {
        _prop.onTapUp?.call(e);
        isTap = false;
      }
    }, delay);
  }

  /// 指针取消事件
  void onTapCancel() {
    if (!bubbleFlag) return;
    if (isCancel) return;
    isCancel = true;
    _cancelLongPressTimer();
    _tapUpTimer = setTimeout(() {
      _tapUpTimer = null;
      tapDownTime = null;
      if (mounted) {
        _prop.onTapCancel?.call();
        isTap = false;
      }
    }, _prop.tapUpDelay);
  }

  /// 指针移动事件
  void onPointMove(PointerMoveEvent e) {
    if (!bubbleFlag) return;
    if (isCancel == false && isActiveLongPress == false) {
      // 如果指针离开元素，则立即取消
      if (!childSize.contains(e.localPosition)) {
        onTapCancel();
      }
      // 如果指针移动偏移大于预定值，则取消
      else if ((e.position - tapDownOffset).distance > _prop.cancelScope) {
        onTapCancel();
      }
    }
  }

  /// 单击事件处理，此函数会在 [onPointUp] 指针抬起时执行
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

  /// 双击事件处理，此函数会在 [onPointUp] 指针抬起时执行
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

  /// 长按事件处理，此函数会在 [onPointDown] 指针按下时执行
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

  Timer? _preventTimer;

  /// 右键处理，此函数会在 [onPointUp] 指针抬起时执行
  void contextMenuHandler() {
    if (_prop.prevent) {
      if (kIsWeb) {
        if (_preventTimer != null) {
          _preventTimer!.cancel();
          _preventTimer = null;
        }
        BrowserContextMenu.disableContextMenu();
        _preventTimer = setTimeout(() {
          _preventTimer = null;
          BrowserContextMenu.enableContextMenu();
        }, 500);
      }
    }
    _prop.onContextMenu?.call();
  }

  /// 阻止事件冒泡，此函数会从当前 Element Tree 的位置开始，一层一层向上查找所有 [ElEvent] 实例，
  /// 将它们的 [bubbleFlag] 冒泡标识设置为 false。
  ///
  /// 提示：无需担心性能问题，因为它是通过 [InheritedWidget] 进行查找，它的查找性能为 O(1)，
  /// 同时，修改 [bubbleFlag] 标识不会触发 UI 重建，因为本质上嵌套的 [ElEvent] 事件依然全部触发，
  /// 只不过由于 [bubbleFlag] 变成了 false 阻止了后续逻辑的执行。
  void stopPropagation() {
    if (bubbleFlag) {
      bubbleFlag = false;
      _ElEventInheritedWidget._stopPropagation(context);
    }
  }

  /// 检查当前上下文是否存在阻止事件冒泡小部件，即：[ElStopPropagation]，如果有，
  /// 那么以 [ElStopPropagation] 小部件所在 Element Tree 的位置执行阻止冒泡函数
  void checkBubbleWidget() {
    final result =
        context.getElementForInheritedWidgetOfExactType<ElStopPropagation>();
    if (result != null) result.stopPropagation();
  }

  @override
  Widget build(BuildContext context) {
    _prop = _Prop.create(context, widget);

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
      onPointerDown: _prop.disabled ? null : onPointDown,
      onPointerUp: _prop.disabled ? null : onPointUp,
      onPointerCancel: _prop.disabled ? null : (e) => onTapCancel(),
      onPointerMove: _prop.disabled ? null : onPointMove,
      child: result,
    );
  }
}
