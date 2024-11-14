part of 'index.dart';

class _DragEvent {
  final _Prop _prop;

  _DragEvent(this._prop);

  PanGestureRecognizer gestureRecognizer = PanGestureRecognizer();

  /// 指针速度追踪器，如果监听了滑动结束事件，那么当指针按下时会初始化它，
  /// 然后每当指针移动会添加数据，最后在结束移动时计算出最终的滑动速度
  late VelocityTracker velocityTracker;

  /// 触发惯性滚动的最小力度，当滑动力度小于该值，其返回的速度将为 0
  double minVelocity = kMinFlingVelocity;

  /// 惯性滚动的最大力度
  double maxVelocity = kMaxFlingVelocity;

  void onStart(PointerDownEvent e) {
    velocityTracker = VelocityTracker.withKind(e.kind);
  }

  /// 指针移动处理
  void onMove(PointerMoveEvent e) {
    velocityTracker.addPosition(e.timeStamp, e.position);
    if (_prop.onMove != null) {
      _prop.onMove!(DragUpdateDetails(
        sourceTimeStamp: e.timeStamp,
        globalPosition: e.position,
        localPosition: e.localPosition,
        delta: e.delta,
      ));
    } else if (_prop.onVerticalMove != null) {
      _prop.onVerticalMove!(DragUpdateDetails(
        sourceTimeStamp: e.timeStamp,
        globalPosition: e.position,
        localPosition: e.localPosition,
        delta: e.delta,
      ));
    } else if (_prop.onHorizontalMove != null) {
      _prop.onHorizontalMove!(DragUpdateDetails(
        sourceTimeStamp: e.timeStamp,
        globalPosition: e.position,
        localPosition: e.localPosition,
        delta: e.delta,
      ));
    }
  }

  /// 指针结束移动处理
  void onEnd(PointerUpEvent e) {
    DragEndDetails? details;
    final VelocityEstimate? estimate = velocityTracker.getVelocityEstimate();
    if (estimate != null) {
      if (isFlingGesture(estimate, e.kind)) {
        late Velocity velocity;
        if (_prop.onMoveEnd != null) {
          velocity = Velocity(pixelsPerSecond: estimate.pixelsPerSecond)
              .clampMagnitude(minVelocity, maxVelocity);
        } else if (_prop.onVerticalMoveEnd != null) {
          velocity = Velocity(
              pixelsPerSecond: Offset(
            0,
            clampDouble(estimate.pixelsPerSecond.dy, -maxVelocity, maxVelocity),
          ));
        } else if (_prop.onHorizontalMoveEnd != null) {
          velocity = Velocity(
              pixelsPerSecond: Offset(
            clampDouble(estimate.pixelsPerSecond.dx, -maxVelocity, maxVelocity),
            0,
          ));
        } else {
          throw ElAssert.elementError('ElEvent velocity 未初始化');
        }
        details = DragEndDetails(
          velocity: velocity,
          globalPosition: e.position,
          localPosition: e.localPosition,
        );
      }
    }

    details ??= DragEndDetails(
      primaryVelocity: 0.0,
      globalPosition: e.position,
      localPosition: e.localPosition,
    );

    _prop.onVerticalMoveEnd?.call(details);
  }

  /// 判断指针滑动力度，如果力度小于 [minFlingVelocity]，那么它将返回 false
  bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind) {
    final double minDistance = computeHitSlop(kind, null);
    return estimate.pixelsPerSecond.distanceSquared >
            minVelocity * minVelocity &&
        estimate.offset.distanceSquared > minDistance * minDistance;
  }
}
