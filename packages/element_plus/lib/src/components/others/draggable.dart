import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// 在长按拖拽的基础上新增一个 triggerOffset 属性，支持根据拖拽偏移来触发拖拽
class ElDraggable<T extends Object> extends LongPressDraggable<T> {
  const ElDraggable({
    super.key,
    required super.child,
    required super.feedback,
    super.data,
    super.axis,
    super.childWhenDragging,
    super.feedbackOffset,
    super.dragAnchorStrategy,
    super.maxSimultaneousDrags,
    super.onDragStarted,
    super.onDragUpdate,
    super.onDraggableCanceled,
    super.onDragEnd,
    super.onDragCompleted,
    super.hapticFeedbackOnStart = true,
    super.ignoringFeedbackSemantics,
    super.ignoringFeedbackPointer,
    super.delay,
    super.allowedButtonsFilter,
    super.hitTestBehavior,
    super.rootOverlay,
    this.triggerOffset = 10,
  });

  /// 触发拖拽偏移值，设置一定的偏移可以避免误触
  final double triggerOffset;

  /// 此方法在 initState 中执行，所以你更新外部属性默认情况下不会生效，
  /// 如果你要动态更新 [triggerOffset] 那么请添加 [UniqueKey]。
  ///
  /// 对于拖拽元素，在大部分情况下只会在桌面端设置拖拽偏移、而移动端则使用长按触发拖拽。
  @override
  DelayedMultiDragGestureRecognizer createRecognizer(
      GestureMultiDragStartCallback onStart) {
    if (PlatformUtil.isDesktop) {
      return ElMultiDragGestureRecognizer(
        triggerOffset: triggerOffset,
        allowedButtonsFilter: allowedButtonsFilter,
      )..onStart = onStart;
    } else {
      return super.createRecognizer(onStart);
    }
  }
}

/// 扩展延迟触发拖拽，新增拖拽触发偏移，此属性对桌面端更加友好
class ElMultiDragGestureRecognizer extends DelayedMultiDragGestureRecognizer {
  ElMultiDragGestureRecognizer({
    this.triggerOffset = 10,
    super.delay,
    super.debugOwner,
    super.supportedDevices,
    super.allowedButtonsFilter,
  });

  final double triggerOffset;

  @override
  MultiDragPointerState createNewPointerState(PointerDownEvent event) {
    if (PlatformUtil.isDesktop) {
      return _ElPointerState(
        event.position,
        event.kind,
        gestureSettings,
        triggerOffset,
      );
    } else {
      return super.createNewPointerState(event);
    }
  }

  @override
  String get debugDescription => 'ElMultiDragGestureRecognizer';
}

class _ElPointerState extends MultiDragPointerState {
  _ElPointerState(
    super.initialPosition,
    super.kind,
    super.gestureSettings,
    this.triggerOffset,
  );

  final double triggerOffset;
  GestureMultiDragStartCallback? _starter;

  @override
  void checkForResolutionAfterMove() {
    assert(pendingDelta != null);
    if (pendingDelta!.dx.abs() > triggerOffset ||
        pendingDelta!.dy.abs() > triggerOffset) {
      resolve(GestureDisposition.accepted);
      _starter!(initialPosition);
    }
  }

  @override
  void accepted(GestureMultiDragStartCallback starter) {
    _starter = starter;
  }
}
