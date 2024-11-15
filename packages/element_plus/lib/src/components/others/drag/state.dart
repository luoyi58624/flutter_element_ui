part of 'index.dart';

class _ElDragState extends State<ElDrag> {
  /// 惯性移动动画控制器
  late final AnimationController controller =
      AnimationController.unbounded(vsync: vsync)..addListener(animateListener);

  /// 显示的浮层位置
  final feedbackPosition = Obs(Offset.zero);
  Offset widgetPosition = Offset.zero; // 当前小部件的全局位置坐标点
  Offset downPosition = Offset.zero; // 指针按下的全局坐标点
  Offset downLocalPosition = Offset.zero; // 指针按下的局部坐标点

  Offset dragOffset = Offset.zero; // 以指针按下的坐标点为基点，计算指针移动的整体偏差值
  Offset oldDragOffset = Offset.zero; // 上一次的拖拽偏移值，用于计算 delta 变量

  late OverlayState _overlay; // 遮罩层实例
  late Offset _overlayOffset; // 遮罩层偏移位置
  OverlayEntry? _entry; // 拖拽浮层实例对象

  bool isActiveDrag = false; // 是否开始拖拽

  double endDirection = 0.0; // 拖拽结束时的方向
  double? oldAnimateValue; // 记录旧的动画值，用于计算惯性移动的偏移值

  bool get _isTriggerOffset {
    return dragOffset.dx < -widget.triggerOffset.dx ||
        dragOffset.dx > widget.triggerOffset.dx ||
        dragOffset.dy < -widget.triggerOffset.dy ||
        dragOffset.dy > widget.triggerOffset.dy;
  }

  /// 计算拖拽偏移值，应用 Axis 方向限制
  void _calcDragOffset(Offset offset) {
    dragOffset = switch (widget.axis) {
      Axis.horizontal => Offset(offset.dx, 0),
      Axis.vertical => Offset(0, offset.dy),
      null => offset,
    };
  }

  /// 计算浮层位置
  void _calcFeedbackPosition() {
    feedbackPosition.value =
        downPosition - downLocalPosition - _overlayOffset + dragOffset;
  }

  void animateListener() {
    late double details;
    if (oldAnimateValue == null) {
      oldAnimateValue = controller.value;
      details = controller.value;
    } else {
      details = controller.value - oldAnimateValue!;
      oldAnimateValue = controller.value;
    }
    var offsetDetails = Offset.fromDirection(endDirection, details);
    dragOffset += offsetDetails;
    widget.onChanged?.call(ElDragChangedData(
      dragOffset: dragOffset,
      details: offsetDetails,
    ));
  }

  void _onDragDown(PointerDownEvent e) {
    if (widget.enabledAnimate &&
        controller.status != AnimationStatus.completed) {
      controller.stop();
    }
    oldAnimateValue = null;
    downPosition = e.position;
    downLocalPosition = e.localPosition;
    widget.onDragDown?.call(DragDownDetails(
      globalPosition: e.position,
      localPosition: e.localPosition,
    ));
  }

  void _onDragDown2(DragDownDetails e) {
    if (widget.enabledAnimate &&
        controller.status != AnimationStatus.completed) {
      controller.stop();
    }
    oldAnimateValue = null;
    downPosition = e.globalPosition;
    downLocalPosition = e.localPosition;
    widget.onDragDown?.call(DragDownDetails(
      globalPosition: e.globalPosition,
      localPosition: e.localPosition,
    ));
  }

  void _onDragMove(DragUpdateDetails e) {
    _calcDragOffset(e.globalPosition - downPosition);
    if (isActiveDrag || _isTriggerOffset) {
      widget.onDragUpdate?.call(e);
      _calcFeedbackPosition();
      widget.onChanged?.call(ElDragChangedData(
        dragOffset: dragOffset,
        details: dragOffset - oldDragOffset,
      ));
      oldDragOffset = dragOffset;
      if (isActiveDrag == false) {
        isActiveDrag = true;
        if (widget.feedback != null) {
          _entry = OverlayEntry(
            builder: (context) => ObsBuilder(builder: (context) {
              return Positioned(
                left: feedbackPosition.value.dx,
                top: feedbackPosition.value.dy,
                child: IgnorePointer(
                  child: UnconstrainedBox(child: widget.feedback),
                ),
              );
            }),
          );
          _overlay.insert(_entry!);
        }
      }
    }
  }

  void _onDragUp(DragEndDetails e) {
    _dragEnd();
    widget.onDragEnd?.call(e);
    if (widget.enabledAnimate) {
      endDirection = e.velocity.pixelsPerSecond.direction;
      FrictionSimulation frictionSim = FrictionSimulation(
        1.0 - widget.damping,
        0.0,
        e.velocity.pixelsPerSecond.distance,
      );
      controller.animateWith(frictionSim);
    }
  }

  void _onDragCancel() {
    _dragEnd();
    widget.onDragCancel?.call();
  }

  void _dragEnd() {
    if (_entry != null) {
      _entry!.remove();
      _entry = null;
    }
    isActiveDrag = false;
    downPosition = Offset.zero;
    downLocalPosition = Offset.zero;
    dragOffset = Offset.zero;
    oldDragOffset = Offset.zero;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nextTick(() {
      widgetPosition = context.getPosition();
      _overlayOffset = _overlay.context.getPosition();
    });
    _overlay = Overlay.of(context, rootOverlay: widget.rootOverlay);

    return ElEvent(
      onPointerDown: _onDragDown,
      onDragUpdate: _onDragMove,
      onDragEnd: _onDragUp,
      onPointerCancel: _onDragCancel,
      child: widget.child,
    );

    // final Map<Type, GestureRecognizerFactory> gestures =
    //     <Type, GestureRecognizerFactory>{};
    // gestures[PanGestureRecognizer] =
    //     GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
    //   () => PanGestureRecognizer(debugOwner: this),
    //   (PanGestureRecognizer instance) {
    //     instance
    //       ..onDown = _onDragDown2
    //       ..onStart = widget.onDragStarted
    //       ..onUpdate = _onDragMove
    //       ..onEnd = _onDragUp
    //       ..onCancel = _onDragCancel
    //       ..dragStartBehavior = DragStartBehavior.down;
    //   },
    // );
    //
    // gestures[EagerGestureRecognizer] =
    //     GestureRecognizerFactoryWithHandlers<EagerGestureRecognizer>(
    //   () => EagerGestureRecognizer(),
    //   (EagerGestureRecognizer instance) {},
    // );

    // return RawGestureDetector(
    //   gestures: gestures,
    //   child: widget.child,
    // );
  }
}
