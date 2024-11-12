part of 'index.dart';

class _ElEventState extends State<ElEvent> {
  GlobalKey childKey = GlobalKey();
  Size childSize = Size.zero; // 子组件的尺寸
  int pointType = kPrimaryButton; // 指针按下时的类型，例如：鼠标左键 = 1，右键 = 2
  Offset tapDownOffset = Offset.zero; // 指针按下位置（全局坐标系）
  int? tapDownTime; // 记录当前的按下时间
  late bool disabled; // 是否禁用
  bool isCancel = false; // 当指针在当前小部件按下时，如果指针移动超出小部件的范围，则触发取消事件
  bool isActiveDoubleTap = false; // 是否激活了双击
  bool isActiveLongPress = false; // 是否激活了长按

  final _isHover = Obs(false); // 悬停状态，此属性会注入到 InheritedWidget 小部件
  final _isTap = Obs(false); // 点击状态，此属性会注入到 InheritedWidget 小部件
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
    widget.onEnter?.call(e);
  }

  /// 鼠标离开目标区域事件
  void onExit(PointerExitEvent e) {
    isHover = false;
    widget.onExit?.call(e);
  }

  /// 指针按下事件
  void onPointDown(PointerDownEvent e) {
    pointType = e.buttons;
    tapDownOffset = e.position;
    tapDownTime = currentMilliseconds;
    isCancel = false;
    if (widget.onLongPress != null && pointType == kPrimaryButton) {
      longPressHandler();
    }
    if (_tapUpTimer != null) {
      _tapUpTimer!.cancel();
      _tapUpTimer = null;
    }
    widget.onTapDown?.call(e);
    isTap = true;
  }

  /// 指针抬起事件
  void onPointUp(PointerUpEvent e) {
    if (isCancel == false) {
      if (pointType == kPrimaryButton) {
        if (widget.onDoubleTap != null) {
          doubleTapHandler();
        }
        tapHandler();
        isActiveDoubleTap = false;
        isActiveLongPress = false;
      } else if (pointType == kSecondaryButton) {
        contextMenuHandler();
      }
    }
    int delay = widget.tapUpDelay;
    if (tapDownTime != null) {
      delay = max(delay - (currentMilliseconds - tapDownTime!), 0);
    }
    _tapUpTimer = setTimeout(() {
      _tapUpTimer = null;
      tapDownTime = null;
      if (mounted) {
        widget.onTapUp?.call(e);
        isTap = false;
      }
    }, delay);
  }

  /// 指针取消事件
  void onTapCancel() {
    if (isCancel) return;
    isCancel = true;
    _cancelLongPressTimer();
    _tapUpTimer = setTimeout(() {
      _tapUpTimer = null;
      tapDownTime = null;
      if (mounted) {
        widget.onTapCancel?.call();
        isTap = false;
      }
    }, widget.tapUpDelay);
  }

  /// 指针移动事件
  void onPointMove(PointerMoveEvent e) {
    if (isCancel == false) {
      // 如果指针离开元素，则立即取消
      if (!childSize.contains(e.localPosition)) {
        onTapCancel();
      }
      // 如果指针移动偏移大于预定值，则取消
      else if ((e.position - tapDownOffset).distance > widget.cancelScope) {
        onTapCancel();
      }
    }
  }

  /// 单击事件处理
  void tapHandler() {
    // 如果设置了等待双击延迟，并且双击计时器开始计时，那么直接返回
    if (widget.delayTapForDouble &&
        (_doubleTapTimer != null || isActiveDoubleTap)) return;
    if (widget.onLongPress == null) {
      widget.onTap?.call();
    } else {
      // 如果长按没有激活，那么依旧触发点击事件，同时还需要取消长按计时器
      if (isActiveLongPress == false) {
        widget.onTap?.call();
        _cancelLongPressTimer();
      }
    }
  }

  Timer? _doubleTapTimer;

  /// 双击事件处理
  void doubleTapHandler() {
    // 若触发了长按则直接返回
    if (isActiveLongPress) return;
    if (_doubleTapTimer != null) {
      _doubleTapTimer!.cancel();
      _doubleTapTimer = null;
      isActiveDoubleTap = true;
      widget.onDoubleTap!();
    } else {
      _doubleTapTimer = setTimeout(() {
        _doubleTapTimer = null;
        // 双击计时器到了销毁时间，如果设置了等待双击延迟，那么触发点击事件
        if (widget.delayTapForDouble) {
          widget.onTap?.call();
        }
      }, widget.doubleTapTimeout);
    }
  }

  Timer? _longPressTimer;

  /// 长按事件处理
  void longPressHandler() {
    _longPressTimer = setTimeout(() {
      _longPressTimer = null;
      isActiveLongPress = true;
      if (widget.feedback) HapticFeedback.mediumImpact();
      widget.onLongPress!();
    }, widget.longPressTimeout);
  }

  void _cancelLongPressTimer() {
    if (_longPressTimer != null) {
      _longPressTimer!.cancel();
      _longPressTimer = null;
    }
  }

  Timer? _preventTimer;

  /// 右键处理
  void contextMenuHandler() {
    if (widget.prevent) {
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
    widget.onContextMenu?.call();
  }

  @override
  Widget build(BuildContext context) {
    disabled = widget.disabled;

    nextTick(() {
      childSize = childKey.currentContext?.size ?? Size.zero;
    });

    Widget result = ObsBuilder(
      key: childKey,
      builder: (context) {
        return _ElEventInheritedWidget(
          isHover: isHover,
          setHoverDepend: setHoverDepend,
          isTap: isTap,
          setTapDepend: setTapDepend,
          child: widget.child,
        );
      },
    );

    // 只有在桌面端才渲染鼠标悬停小部件
    if (PlatformUtil.isDesktop) {
      if (disabled) isHover = false;
      result = MouseRegion(
        cursor: widget.cursor ?? MouseCursor.defer,
        hitTestBehavior: widget.hitTestBehavior,
        onHover: disabled ? null : widget.onHover,
        onEnter: disabled ? null : onEnter,
        onExit: disabled ? null : onExit,
        child: result,
      );
    }

    return Listener(
      behavior: widget.hitTestBehavior,
      onPointerDown: disabled ? null : onPointDown,
      onPointerUp: disabled ? null : onPointUp,
      onPointerCancel: disabled ? null : (e) => onTapCancel(),
      onPointerMove: disabled ? null : onPointMove,
      child: result,
    );
  }
}
