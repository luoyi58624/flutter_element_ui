part of '../index.dart';

mixin _DragMixin<T extends ElEvent> on _CommonMixin<T> {
  late bool hasMoveEvent;
  late bool hasMoveEndEvent;

  /// 是否触发了开始拖拽，当指针按下时，移动偏移范围大于设定的 triggerDragScope 值，
  /// 此选项将变为 true，最后当指针抬起后重置为 false
  bool isStartDrag = false;

  /// 计算指针拖动结束时的速度，只有当监听了滑动结束事件才会初始化它
  VelocityTracker? velocityTracker;

  /// 是否存在点击状态依赖
  bool hasDragDepend = false;

  final _isDrag = BaseObs(false);

  /// 拖拽状态响应式变量，此属性会注入到 InheritedWidget 小部件
  bool get isDrag => _isDrag.value;

  set isDrag(bool value) {
    if (hasDragDepend) _isDrag.value = value;
  }

  void setDragDepend() {
    hasDragDepend = true;
  }

  /// 每当 build 时，会校验、并初始化拖拽相关的内容
  void buildDragEvent() {
    assert(
      DartUtil.listOnlyOne([
        prop.onDragUpdate,
        prop.onVerticalDragUpdate,
        prop.onHorizontalDragUpdate,
      ]),
      'onDragUpdate、onVerticalDragUpdate、onHorizontalDragUpdate 最多只能存在一个',
    );
    assert(
      DartUtil.listOnlyOne(
          [prop.onDragEnd, prop.onVerticalDragEnd, prop.onHorizontalDragEnd]),
      'onDragEnd、onVerticalDragEnd、onHorizontalDragEnd 最多只能存在一个',
    );

    hasMoveEndEvent = prop.onDragEnd != null ||
        prop.onVerticalDragEnd != null ||
        prop.onHorizontalDragEnd != null;

    hasMoveEvent = prop.onDragStart != null ||
        prop.onVerticalDragStart != null ||
        prop.onHorizontalDragStart != null ||
        prop.onDragUpdate != null ||
        prop.onVerticalDragUpdate != null ||
        prop.onHorizontalDragUpdate != null ||
        hasMoveEndEvent;
  }

  /// 拖拽开始处理
  void dragStartHandler(PointerDownEvent e) async {
    if (hasMoveEndEvent) {
      velocityTracker = VelocityTracker.withKind(e.kind);
    }
  }

  /// 拖拽更新处理
  void dragUpdateHandler(PointerMoveEvent e) {
    if (hasMoveEvent == false) return;

    // 当拖拽开始时，计算指针移动距离指针按下时已经偏移的位置
    Offset triggerDragOffset = Offset.zero;

    if (isStartDrag == false) {
      // 如果指针偏移大于设置的阈值，那么将开始触发拖拽
      if ((e.position - tapDownOffset).distance > prop.triggerDragScope) {
        isStartDrag = true;
        triggerDragOffset = e.position - tapDownOffset;
        final details = DragStartDetails(
          sourceTimeStamp: e.timeStamp,
          globalPosition: e.position,
          localPosition: e.localPosition,
          kind: e.kind,
        );
        if (prop.onDragStart != null) {
          prop.onDragStart!(details);
        } else if (prop.onVerticalDragStart != null) {
          prop.onVerticalDragStart!(details);
        } else if (prop.onHorizontalDragStart != null) {
          prop.onHorizontalDragStart!(details);
        }
      } else {
        return;
      }
    }

    // 添加触摸的数据，当触摸结束后会计算最终的速度
    velocityTracker?.addPosition(e.timeStamp, e.position);

    if (prop.onDragUpdate != null) {
      prop.onDragUpdate!(DragUpdateDetails(
        sourceTimeStamp: e.timeStamp,
        globalPosition: e.position,
        localPosition: e.localPosition,
        delta: e.delta + triggerDragOffset,
      ));
    } else if (prop.onVerticalDragUpdate != null) {
      prop.onVerticalDragUpdate!(DragUpdateDetails(
        sourceTimeStamp: e.timeStamp,
        globalPosition: e.position,
        localPosition: e.localPosition,
        delta: Offset(0, e.delta.dy) + Offset(0, triggerDragOffset.dy),
      ));
    } else if (prop.onHorizontalDragUpdate != null) {
      prop.onHorizontalDragUpdate!(DragUpdateDetails(
        sourceTimeStamp: e.timeStamp,
        globalPosition: e.position,
        localPosition: e.localPosition,
        delta: Offset(e.delta.dx, 0) + Offset(triggerDragOffset.dx, 0),
      ));
    }
  }

  /// 指针结束移动处理
  void dragEndHandler(PointerUpEvent e) {
    isStartDrag = false;
    if (hasMoveEndEvent == false || pointType != kPrimaryButton) {
      return;
    }
    final VelocityEstimate? estimate = velocityTracker?.getVelocityEstimate();
    Velocity velocity = Velocity.zero;
    if (estimate != null) {
      if (_isFlingGesture(estimate, e.kind)) {
        if (prop.onDragEnd != null) {
          velocity = Velocity(pixelsPerSecond: estimate.pixelsPerSecond)
              .clampMagnitude(prop.minVelocity, prop.maxVelocity);
        } else if (prop.onVerticalDragEnd != null) {
          velocity = Velocity(
            pixelsPerSecond: Offset(
              0,
              clampDouble(
                estimate.pixelsPerSecond.dy,
                -prop.maxVelocity,
                prop.maxVelocity,
              ),
            ),
          );
        } else if (prop.onHorizontalDragEnd != null) {
          velocity = Velocity(
            pixelsPerSecond: Offset(
              clampDouble(
                estimate.pixelsPerSecond.dx,
                -prop.maxVelocity,
                prop.maxVelocity,
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
    if (prop.onDragEnd != null) {
      prop.onDragEnd!(detail);
    } else if (prop.onVerticalDragEnd != null) {
      prop.onVerticalDragEnd!(detail);
    } else if (prop.onHorizontalDragEnd != null) {
      prop.onHorizontalDragEnd!(detail);
    }
  }

  /// 判断指针滑动力度，如果力度小于 [minFlingVelocity]，那么它将返回 false
  bool _isFlingGesture(VelocityEstimate estimate, PointerDeviceKind kind) {
    final double minDistance = computeHitSlop(kind, null);
    return estimate.pixelsPerSecond.distanceSquared >
            prop.minVelocity * prop.minVelocity &&
        estimate.offset.distanceSquared > minDistance * minDistance;
  }
}
