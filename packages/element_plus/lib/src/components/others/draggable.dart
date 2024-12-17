import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
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
    this.triggerOffset,
    super.allowedButtonsFilter,
    super.hitTestBehavior,
    super.rootOverlay,
  });

  /// 触发拖拽偏移值，如果不为空，则使用 [TriggerOffsetMultiDragGestureRecognizer] 手势，
  /// 否则使用默认的长按触发拖拽手势
  final double? triggerOffset;

  @override
  DelayedMultiDragGestureRecognizer createRecognizer(
      GestureMultiDragStartCallback onStart) {
    if (triggerOffset != null) {
      return TriggerOffsetMultiDragGestureRecognizer(
          triggerOffset: triggerOffset!,
          allowedButtonsFilter: allowedButtonsFilter)
        ..onStart = (Offset position) {
          final Drag? result = onStart(position);
          if (result != null && hapticFeedbackOnStart) {
            HapticFeedback.selectionClick();
          }
          return result;
        };
    } else {
      return super.createRecognizer(onStart);
    }
  }
}

/// 当拖拽偏移大于指定值时，将触发拖拽
class TriggerOffsetMultiDragGestureRecognizer
    extends DelayedMultiDragGestureRecognizer {
  TriggerOffsetMultiDragGestureRecognizer({
    this.triggerOffset = 10,
    super.debugOwner,
    super.supportedDevices,
    super.allowedButtonsFilter,
  });

  final double triggerOffset;

  @override
  MultiDragPointerState createNewPointerState(PointerDownEvent event) {
    return _ElPointerState(
      event.position,
      event.kind,
      gestureSettings,
      triggerOffset,
    );
  }

  @override
  String get debugDescription => 'TriggerOffsetMultiDragGestureRecognizer';
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
