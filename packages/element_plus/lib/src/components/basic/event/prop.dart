import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'index.dart';

class EventProp {
  final bool disabled;
  final int cancelScope;
  final bool prevent;
  final int tapUpDelay;
  final int doubleTapTimeout;
  final bool delayTapForDouble;
  final int longPressTimeout;
  final bool feedback;
  final int triggerDragScope;
  final double minVelocity;
  final double maxVelocity;
  final HitTestBehavior hitTestBehavior;
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
  final GestureTapCallback? onTertiaryTap;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final VoidCallback? onDoubleTap;
  final VoidCallback? onLongPress;
  final GestureDragStartCallback? onDragStart;
  final GestureDragUpdateCallback? onDragUpdate;
  final GestureDragEndCallback? onDragEnd;
  final GestureDragStartCallback? onVerticalDragStart;
  final GestureDragUpdateCallback? onVerticalDragUpdate;
  final GestureDragEndCallback? onVerticalDragEnd;
  final GestureDragStartCallback? onHorizontalDragStart;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final PointerDownEventListener? onPointerDown;
  final PointerUpEventListener? onPointerUp;
  final PointerMoveEventListener? onPointerMove;
  final PointerPanZoomStartEventListener? onPointerPanZoomStart;
  final PointerPanZoomUpdateEventListener? onPointerPanZoomUpdate;
  final PointerPanZoomEndEventListener? onPointerPanZoomEnd;
  final PointerSignalEventListener? onPointerSignal;
  final VoidCallback? onCancel;

  EventProp(
    this.disabled,
    this.cancelScope,
    this.prevent,
    this.tapUpDelay,
    this.doubleTapTimeout,
    this.delayTapForDouble,
    this.longPressTimeout,
    this.feedback,
    this.triggerDragScope,
    this.minVelocity,
    this.maxVelocity,
    this.hitTestBehavior,
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
    this.onTertiaryTap,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onDoubleTap,
    this.onLongPress,
    this.onDragStart,
    this.onDragUpdate,
    this.onDragEnd,
    this.onVerticalDragStart,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerMove,
    this.onPointerPanZoomStart,
    this.onPointerPanZoomUpdate,
    this.onPointerPanZoomEnd,
    this.onPointerSignal,
    this.onCancel,
  );

  factory EventProp.create(BuildContext context, ElEvent widget) {
    final $data = ElEventTheme.of(context);

    return EventProp(
      widget.disabled ?? $data.disabled ?? false,
      widget.cancelScope ?? $data.cancelScope ?? 20,
      widget.prevent ?? $data.prevent ?? true,
      widget.tapUpDelay ?? $data.tapUpDelay ?? 100,
      widget.doubleTapTimeout ?? $data.doubleTapTimeout ?? 300,
      widget.delayTapForDouble ?? $data.delayTapForDouble ?? false,
      widget.longPressTimeout ?? $data.longPressTimeout ?? 500,
      widget.feedback ?? $data.feedback ?? true,
      widget.triggerDragScope ?? $data.triggerDragScope ?? 0,
      widget.minVelocity ?? $data.minVelocity ?? kMinFlingVelocity,
      widget.maxVelocity ?? $data.maxVelocity ?? kMaxFlingVelocity,
      widget.hitTestBehavior ??
          $data.hitTestBehavior ??
          HitTestBehavior.deferToChild,
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
      widget.onTertiaryTap ?? $data.onTertiaryTap,
      widget.onTertiaryTapDown ?? $data.onTertiaryTapDown,
      widget.onTertiaryTapUp ?? $data.onTertiaryTapUp,
      widget.onDoubleTap ?? $data.onDoubleTap,
      widget.onLongPress ?? $data.onLongPress,
      widget.onDragStart ?? $data.onDragStart,
      widget.onDragUpdate ?? $data.onDragUpdate,
      widget.onDragEnd ?? $data.onDragEnd,
      widget.onVerticalDragStart ?? $data.onVerticalDragStart,
      widget.onVerticalDragUpdate ?? $data.onVerticalDragUpdate,
      widget.onVerticalDragEnd ?? $data.onVerticalDragEnd,
      widget.onHorizontalDragStart ?? $data.onHorizontalDragStart,
      widget.onHorizontalDragUpdate ?? $data.onHorizontalDragUpdate,
      widget.onHorizontalDragEnd ?? $data.onHorizontalDragEnd,
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
