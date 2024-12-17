import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class TriggerOffsetDraggable<T extends Object> extends Draggable<T> {
  const TriggerOffsetDraggable({
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
    this.hapticFeedbackOnStart = true,
    super.ignoringFeedbackSemantics,
    super.ignoringFeedbackPointer,
    this.triggerOffset = 10,
    super.allowedButtonsFilter,
    super.hitTestBehavior,
    super.rootOverlay,
  });

  final bool hapticFeedbackOnStart;

  final double triggerOffset;

  @override
  MultiDragGestureRecognizer createRecognizer(
      GestureMultiDragStartCallback onStart) {
    return TriggerOffsetMultiDragGestureRecognizer(
        triggerOffset: triggerOffset,
        allowedButtonsFilter: allowedButtonsFilter)
      ..onStart = (Offset position) {
        final Drag? result = onStart(position);
        if (result != null && hapticFeedbackOnStart) {
          HapticFeedback.selectionClick();
        }
        return result;
      };
  }
}

/// 当拖拽偏移大于指定值时，将触发拖拽
class TriggerOffsetMultiDragGestureRecognizer
    extends MultiDragGestureRecognizer {
  TriggerOffsetMultiDragGestureRecognizer({
    this.triggerOffset = 10,
    super.debugOwner,
    super.supportedDevices,
    super.allowedButtonsFilter,
  });

  final double triggerOffset;

  @override
  MultiDragPointerState createNewPointerState(PointerDownEvent event) {
    return _TriggerOffsetPointerState(
      event.position,
      event.kind,
      gestureSettings,
      triggerOffset,
    );
  }

  @override
  String get debugDescription => 'TriggerOffsetMultiDragGestureRecognizer';
}

class _TriggerOffsetPointerState extends MultiDragPointerState {
  _TriggerOffsetPointerState(
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
