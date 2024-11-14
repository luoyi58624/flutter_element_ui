part of 'index.dart';

class _DragEvent {
  _DragEvent(this._prop);

  final _Prop _prop;

  /// 指针速度追踪器，如果监听了滑动结束事件，那么当指针按下时会初始化它，
  /// 然后每当指针移动会添加数据，最后在结束移动时计算出最终的滑动速度
  VelocityTracker? velocityTracker;

  /// 触发惯性滚动的最小力度，当滑动力度小于该值，其返回的速度将为 0
  double minVelocity = kMinFlingVelocity;

  /// 惯性滚动的最大力度
  double maxVelocity = kMaxFlingVelocity;

  /// 指针开始触摸，初始化速度追踪器
  void onStart(PointerDownEvent e) {
    velocityTracker = VelocityTracker.withKind(e.kind);
  }

  /// 指针移动处理
  void onMove(PointerMoveEvent e) {
    // 添加触摸的数据，当触摸结束后会计算最终的速度
    velocityTracker?.addPosition(e.timeStamp, e.position);
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
        delta: Offset(0, e.delta.dy),
      ));
    } else if (_prop.onHorizontalMove != null) {
      _prop.onHorizontalMove!(DragUpdateDetails(
        sourceTimeStamp: e.timeStamp,
        globalPosition: e.position,
        localPosition: e.localPosition,
        delta: Offset(e.delta.dx, 0),
      ));
    }
  }

  /// 指针结束移动处理
  void onEnd(PointerUpEvent e) {
    final VelocityEstimate? estimate = velocityTracker?.getVelocityEstimate();
    Velocity velocity = Velocity.zero;
    if (estimate != null) {
      if (isFlingGesture(estimate, e.kind)) {
        if (_prop.onMoveEnd != null) {
          velocity = Velocity(pixelsPerSecond: estimate.pixelsPerSecond)
              .clampMagnitude(minVelocity, maxVelocity);
        } else if (_prop.onVerticalMoveEnd != null) {
          velocity = Velocity(
            pixelsPerSecond: Offset(
              0,
              clampDouble(
                estimate.pixelsPerSecond.dy,
                -maxVelocity,
                maxVelocity,
              ),
            ),
          );
        } else if (_prop.onHorizontalMoveEnd != null) {
          velocity = Velocity(
            pixelsPerSecond: Offset(
              clampDouble(
                estimate.pixelsPerSecond.dx,
                -maxVelocity,
                maxVelocity,
              ),
              0,
            ),
          );
        }
      }
    }

    final detail = DragEndDetails(
      velocity: velocity,
      globalPosition: e.position,
      localPosition: e.localPosition,
    );
    if (_prop.onMoveEnd != null) {
      _prop.onMoveEnd!(detail);
    } else if (_prop.onVerticalMoveEnd != null) {
      _prop.onVerticalMoveEnd!(detail);
    } else if (_prop.onHorizontalMoveEnd != null) {
      _prop.onHorizontalMoveEnd!(detail);
    }
  }

  /// 判断指针滑动力度，如果力度小于 [minFlingVelocity]，那么它将返回 false
  bool isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind) {
    final double minDistance = computeHitSlop(kind, null);
    return estimate.pixelsPerSecond.distanceSquared >
            minVelocity * minVelocity &&
        estimate.offset.distanceSquared > minDistance * minDistance;
  }
}
