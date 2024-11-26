part of 'index.dart';

class _ElEventState extends State<ElEvent>
    with
        _CommonMixin,
        _HoverMixin,
        _TapMixin,
        _DoubleTapMixin,
        _LongPressMixin,
        _DragMixin {
  /// 指针按下事件
  void onPointerDown(PointerDownEvent e) async {
    if (!bubbleFlag) return;
    stopPropagationByWidget();

    // 设置指针按下时的一些通用属性
    childSize = childKey.currentContext?.size ?? Size.zero;
    pointType = e.buttons;
    tapDownOffset = e.position;
    tapDownTime = currentMilliseconds;
    isCancel = false;

    // 指针按下时立即设置选中的焦点，这里只做预选中，当触发点击事件时将请求焦点
    if (disabledSetFocusNode == false) {
      if (_focusScopeWidget != null) {
        _focusScopeWidget!.setPointerDownFocusNode(focusNode);
        if (focusScopeNode!.hasFocus) {
          focusNode!.requestFocus();
        }
      }
    }

    prop.onPointerDown?.call(e);

    if (pointType == kPrimaryButton) {
      tapDownHandler(e);
      longPressStartHandler(e);
      dragStartHandler(e);
    } else if (pointType == kSecondaryButton) {
      prop.onSecondaryTapDown?.call(e.toDetails);
    } else if (pointType == kTertiaryButton) {
      prop.onTertiaryTapDown?.call(e.toDetails);
    }
  }

  /// 指针抬起事件
  void onPointerUp(PointerUpEvent e) {
    resetBubbleBuilderWidget();
    if (!bubbleFlag) {
      bubbleFlag = true;
      return;
    }

    prop.onPointerUp?.call(e);
    if (pointType == kPrimaryButton) {
      doubleTapHandler(e); // doubleTap 要放 tap 前面，因为需要注册计时器
      tapUpHandler(e);
      dragEndHandler(e);
    } else if (pointType == kSecondaryButton) {
      prop.onSecondaryTapUp?.call(e.toDetails);
      if (isCancel == false) prop.onSecondaryTap?.call();
    } else if (pointType == kTertiaryButton) {
      prop.onTertiaryTapUp?.call(e.toDetails);
      if (isCancel == false) prop.onTertiaryTap?.call();
    }

    if (isCancel == false) {
      isActiveDoubleTap = false;
      isActiveLongPress = false;
    }
  }

  /// 指针取消事件，有三个触发点：
  /// 1. 当 [Listener] 的 onPointerCancel 触发
  /// 2. 指针移动到元素外部
  /// 3. 指针在元素内部移动偏移幅度太大
  void onPointerCancel() {
    resetBubbleBuilderWidget();
    if (!bubbleFlag) {
      bubbleFlag = true;
      return;
    }
    if (isCancel) return;
    isCancel = true;
    isTap = false;
    isActiveDoubleTap = false;
    isActiveLongPress = false;
    cancelLongPressTimer();
    prop.onCancel?.call();
  }

  /// 指针移动事件
  void onPointerMove(PointerMoveEvent e) {
    if (!bubbleFlag) return;
    prop.onPointerMove?.call(e);
    if (pointType == kPrimaryButton) dragUpdateHandler(e);
    if (isCancel == false &&
        isActiveLongPress == false &&
        hasMoveEvent == false) {
      // 如果指针离开元素，则立即取消
      if (!childSize.contains(e.localPosition)) {
        onPointerCancel();
      }
      // 如果指针移动偏移大于预定值，则取消
      else if ((e.position - tapDownOffset).distance > prop.cancelScope) {
        onPointerCancel();
      }
    }
  }

  /// 指针平移缩放开始事件
  void onPointerPanZoomStart(PointerPanZoomStartEvent e) {
    if (!bubbleFlag) return;
    prop.onPointerPanZoomStart?.call(e);
  }

  /// 指针平移缩放更新事件
  void onPointerPanZoomUpdate(PointerPanZoomUpdateEvent e) {
    if (!bubbleFlag) return;
    prop.onPointerPanZoomUpdate?.call(e);
  }

  /// 指针平移缩放结束事件
  void onPointerPanZoomEnd(PointerPanZoomEndEvent e) {
    if (!bubbleFlag) return;
    prop.onPointerPanZoomEnd?.call(e);
  }

  /// 指针信号事件，例如：鼠标滚动滚动
  void onPointerSignal(PointerSignalEvent e) {
    if (!bubbleFlag) return;
    prop.onPointerSignal?.call(e);
  }

  /// 阻止事件冒泡，它会一层一层向上不断执行，直到最顶层的 [ElEvent]，
  /// 逻辑很简单，就是将 [bubbleFlag] 冒泡标识设置为 false，阻止事件的执行。
  void stopPropagation() {
    if (bubbleFlag) {
      bubbleFlag = false;
      _EventInheritedWidget.stopPropagation(context);
    }
  }

  /// 重置事件冒泡
  void resetPropagation() {
    bubbleFlag = true;
    _EventInheritedWidget.resetPropagation(context);
  }

  /// 根据 [ElStopPropagation] 尝试阻止事件冒泡，此方法会以 [ElStopPropagation]
  /// 所在 Element Tree 的位置开始，向上查找 [ElEvent] 小部件并执行阻止冒泡函数
  void stopPropagationByWidget() {
    final result = context.getInheritedWidgetOfExactType<ElStopPropagation>();
    if (result != null && result.enabled == true) {
      context
          .getElementForInheritedWidgetOfExactType<ElStopPropagation>()
          ?.stopPropagation();
    }
  }

  /// 重置 [ElBubbleBuilder] 小部件的状态，当 [onPointerUp]、[onPointerCancel] 时触发
  void resetBubbleBuilderWidget() {
    if (_BubbleInheritedWidget.triggerFlag) {
      _BubbleInheritedWidget.triggerFlag = false;
      _BubbleInheritedWidget._updateBubbleFlag(context, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    prop = _Prop.create(context, widget);
    focusScopeWidget =
        context.getInheritedWidgetOfExactType<_FocusScopeInheritedWidget>();

    buildDragEvent();
    Widget result = ObsBuilder(
      builder: (context) {
        return _EventInheritedWidget(
          isHover,
          setHoverDepend,
          isTap,
          setTapDepend,
          stopPropagation,
          resetPropagation,
          child: Builder(
            key: childKey,
            builder: (context) {
              return widget.child ?? widget.builder!(context);
            },
          ),
        );
      },
    );

    // 只有在桌面端才渲染鼠标悬停小部件，移动端不存在悬停事件
    if (PlatformUtil.isDesktop) {
      if (prop.disabled) isHover = false;
      result = MouseRegion(
        cursor: prop.cursor,
        hitTestBehavior: prop.behavior,
        onHover: prop.disabled ? null : prop.onHover,
        onEnter: prop.disabled ? null : onEnter,
        onExit: prop.disabled ? null : onExit,
        child: result,
      );
    }

    result = Listener(
      behavior: prop.behavior,
      onPointerDown: prop.disabled ? null : onPointerDown,
      onPointerUp: prop.disabled ? null : onPointerUp,
      onPointerCancel: prop.disabled ? null : (e) => onPointerCancel(),
      onPointerMove: prop.disabled ? null : onPointerMove,
      onPointerPanZoomStart: prop.disabled ? null : onPointerPanZoomStart,
      onPointerPanZoomUpdate: prop.disabled ? null : onPointerPanZoomUpdate,
      onPointerPanZoomEnd: prop.disabled ? null : onPointerPanZoomEnd,
      onPointerSignal: prop.disabled ? null : onPointerSignal,
      child: result,
    );

    return Focus(
      autofocus: prop.autofocus,
      canRequestFocus: prop.canRequestFocus,
      child: Builder(builder: (context) {
        focusNode = Focus.maybeOf(context, createDependency: false);
        return result;
      }),
    );
  }
}