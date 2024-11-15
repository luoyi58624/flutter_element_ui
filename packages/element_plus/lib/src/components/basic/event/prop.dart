part of 'index.dart';

class _Prop {
  final bool disabled;
  final HitTestBehavior hitTestBehavior;
  final MouseCursor cursor;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;
  final PointerHoverEventListener? onHover;
  final PointerDownEventListener? onPointerDown;
  final PointerUpEventListener? onPointerUp;
  final VoidCallback? onPointerCancel;
  final int cancelScope;
  final VoidCallback? onTap;
  final VoidCallback? onContextMenu;
  final bool prevent;
  final VoidCallback? onDoubleTap;
  final int doubleTapTimeout;
  final bool delayTapForDouble;
  final VoidCallback? onLongPress;
  final int longPressTimeout;
  final bool feedback;
  final int triggerDragScope;
  final GestureDragStartCallback? onDragStart;
  final GestureDragUpdateCallback? onDragUpdate;
  final GestureDragEndCallback? onDragEnd;
  final GestureDragStartCallback? onVerticalDragStart;
  final GestureDragUpdateCallback? onVerticalDragUpdate;
  final GestureDragEndCallback? onVerticalDragEnd;
  final GestureDragStartCallback? onHorizontalDragStart;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final PointerSignalEventListener? onPointerSignal;

  _Prop(
    this.disabled,
    this.hitTestBehavior,
    this.cursor,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerCancel,
    this.cancelScope,
    this.onTap,
    this.onContextMenu,
    this.prevent,
    this.onDoubleTap,
    this.doubleTapTimeout,
    this.delayTapForDouble,
    this.onLongPress,
    this.longPressTimeout,
    this.feedback,
    this.triggerDragScope,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onPointerSignal,
  );

  factory _Prop.create(BuildContext context, ElEvent widget) {
    final $data = ElEventTheme.of(context);

    return _Prop(
      widget.disabled ?? $data.disabled ?? false,
      widget.hitTestBehavior ??
          $data.hitTestBehavior ??
          HitTestBehavior.deferToChild,
      widget.cursor ?? $data.cursor ?? MouseCursor.defer,
      widget.onEnter ?? $data.onEnter,
      widget.onExit ?? $data.onExit,
      widget.onHover ?? $data.onHover,
      widget.onPointerDown ?? $data.onPointerDown,
      widget.onPointerUp ?? $data.onPointerUp,
      widget.onPointerCancel ?? $data.onPointerCancel,
      widget.cancelScope ?? $data.cancelScope ?? 10,
      widget.onTap ?? $data.onTap,
      widget.onContextMenu ?? $data.onContextMenu,
      widget.prevent ?? $data.prevent ?? true,
      widget.onDoubleTap ?? $data.onDoubleTap,
      widget.doubleTapTimeout ?? $data.doubleTapTimeout ?? 300,
      widget.delayTapForDouble ?? $data.delayTapForDouble ?? false,
      widget.onLongPress ?? $data.onLongPress,
      widget.longPressTimeout ?? $data.longPressTimeout ?? 500,
      widget.feedback ?? $data.feedback ?? true,
      widget.triggerDragScope ?? $data.triggerDragScope ?? 0,
      widget.onDragStart ?? $data.onDragStart,
      widget.onDragUpdate ?? $data.onDragUpdate,
      widget.onDragEnd ?? $data.onDragEnd,
      widget.onVerticalDragStart ?? $data.onVerticalDragStart,
      widget.onVerticalDragUpdate ?? $data.onVerticalDragUpdate,
      widget.onVerticalDragEnd ?? $data.onVerticalDragEnd,
      widget.onHorizontalDragStart ?? $data.onHorizontalDragStart,
      widget.onHorizontalDragUpdate ?? $data.onHorizontalDragUpdate,
      widget.onHorizontalDragEnd ?? $data.onHorizontalDragEnd,
      widget.onPointerSignal ?? $data.onPointerSignal,
    );
  }
}
