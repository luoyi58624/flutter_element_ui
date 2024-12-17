part of 'event.dart';

class _Prop {
  final bool disabled;
  final bool autofocus;
  final bool canRequestFocus;
  final int cancelScope;
  final bool prevent;
  final int tapUpDelay;
  final int doubleTapTimeout;
  final bool delayTapForDouble;
  final int longPressTimeout;
  final bool feedback;
  final HitTestBehavior behavior;
  final MouseCursor cursor;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;
  final PointerHoverEventListener? onHover;
  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCallback? onSecondaryTap;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final PointerDownEventListener? onPointerDown;
  final PointerUpEventListener? onPointerUp;
  final PointerMoveEventListener? onPointerMove;
  final PointerPanZoomStartEventListener? onPointerPanZoomStart;
  final PointerPanZoomUpdateEventListener? onPointerPanZoomUpdate;
  final PointerPanZoomEndEventListener? onPointerPanZoomEnd;
  final PointerSignalEventListener? onPointerSignal;
  final VoidCallback? onCancel;

  _Prop(
    this.disabled,
    this.autofocus,
    this.canRequestFocus,
    this.cancelScope,
    this.prevent,
    this.tapUpDelay,
    this.doubleTapTimeout,
    this.delayTapForDouble,
    this.longPressTimeout,
    this.feedback,
    this.behavior,
    this.cursor,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onSecondaryTap,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onDoubleTap,
    this.onLongPress,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerMove,
    this.onPointerPanZoomStart,
    this.onPointerPanZoomUpdate,
    this.onPointerPanZoomEnd,
    this.onPointerSignal,
    this.onCancel,
  );

  factory _Prop.create(BuildContext context, ElEvent widget) {
    final $data = ElEventTheme.of(context);
    final $disabled = widget.disabled ?? $data.disabled ?? false;
    final $canRequestFocus =
        widget.canRequestFocus ?? $data.canRequestFocus ?? true;

    return _Prop(
      $disabled,
      widget.autofocus ?? $data.autofocus ?? false,
      $canRequestFocus,
      widget.cancelScope ?? $data.cancelScope ?? 20,
      widget.prevent ?? $data.prevent ?? true,
      widget.tapUpDelay ?? $data.tapUpDelay ?? 100,
      widget.doubleTapTimeout ?? $data.doubleTapTimeout ?? 300,
      widget.delayTapForDouble ?? $data.delayTapForDouble ?? false,
      widget.longPressTimeout ?? $data.longPressTimeout ?? 500,
      widget.feedback ?? $data.feedback ?? true,
      widget.behavior ?? $data.behavior ?? HitTestBehavior.deferToChild,
      widget.cursor ?? $data.cursor ?? MouseCursor.defer,
      widget.onEnter ?? $data.onEnter,
      widget.onExit ?? $data.onExit,
      widget.onHover ?? $data.onHover,
      widget.onTap ?? $data.onTap,
      widget.onTapDown ?? $data.onTapDown,
      widget.onTapUp ?? $data.onTapUp,
      widget.onSecondaryTap ?? $data.onSecondaryTap,
      widget.onSecondaryTapDown ?? $data.onSecondaryTapDown,
      widget.onSecondaryTapUp ?? $data.onSecondaryTapUp,
      widget.onDoubleTap ?? $data.onDoubleTap,
      widget.onLongPress ?? $data.onLongPress,
      widget.onPointerDown ?? $data.onPointerDown,
      widget.onPointerUp ?? $data.onPointerUp,
      widget.onPointerMove ?? $data.onPointerMove,
      widget.onPointerPanZoomStart ?? $data.onPointerPanZoomStart,
      widget.onPointerPanZoomUpdate ?? $data.onPointerPanZoomUpdate,
      widget.onPointerPanZoomEnd ?? $data.onPointerPanZoomEnd,
      widget.onPointerSignal ?? $data.onPointerSignal,
      widget.onCancel ?? $data.onCancel,
    );
  }
}
