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
  final GestureDragUpdateCallback? onMove;
  final GestureDragEndCallback? onMoveEnd;

  final GestureDragUpdateCallback? onVerticalMove;
  final GestureDragEndCallback? onVerticalMoveEnd;

  /// 指针水平移动事件
  final GestureDragUpdateCallback? onHorizontalMove;

  /// 指针结束水平移动事件
  final GestureDragEndCallback? onHorizontalMoveEnd;
  final PointerSignalEventListener? onPointerSignal;

  _Prop({
    required this.disabled,
    required this.hitTestBehavior,
    required this.cursor,
    required this.onEnter,
    required this.onExit,
    required this.onHover,
    required this.onPointerDown,
    required this.onPointerUp,
    required this.onPointerCancel,
    required this.cancelScope,
    required this.onTap,
    required this.onContextMenu,
    required this.prevent,
    required this.onDoubleTap,
    required this.doubleTapTimeout,
    required this.delayTapForDouble,
    required this.onLongPress,
    required this.longPressTimeout,
    required this.feedback,
    required this.onMove,
    required this.onMoveEnd,
    required this.onVerticalMove,
    required this.onVerticalMoveEnd,
    required this.onHorizontalMove,
    required this.onHorizontalMoveEnd,
    required this.onPointerSignal,
  });

  /// 通过工厂函数创建按钮最终 prop 配置
  factory _Prop.create(BuildContext context, ElEvent widget) {
    final $data = ElEventTheme.of(context);

    return _Prop(
      disabled: widget.disabled ?? $data.disabled ?? false,
      hitTestBehavior: widget.hitTestBehavior ??
          $data.hitTestBehavior ??
          HitTestBehavior.deferToChild,
      cursor: widget.cursor ?? $data.cursor ?? MouseCursor.defer,
      onEnter: widget.onEnter ?? $data.onEnter,
      onExit: widget.onExit ?? $data.onExit,
      onHover: widget.onHover ?? $data.onHover,
      onPointerDown: widget.onPointerDown ?? $data.onPointerDown,
      onPointerUp: widget.onPointerUp ?? $data.onPointerUp,
      onPointerCancel: widget.onPointerCancel ?? $data.onPointerCancel,
      cancelScope: widget.cancelScope ?? $data.cancelScope ?? 10,
      onTap: widget.onTap ?? $data.onTap,
      onContextMenu: widget.onContextMenu ?? $data.onContextMenu,
      prevent: widget.prevent ?? $data.prevent ?? true,
      onDoubleTap: widget.onDoubleTap ?? $data.onDoubleTap,
      doubleTapTimeout:
          widget.doubleTapTimeout ?? $data.doubleTapTimeout ?? 300,
      delayTapForDouble:
          widget.delayTapForDouble ?? $data.delayTapForDouble ?? false,
      onLongPress: widget.onLongPress ?? $data.onLongPress,
      longPressTimeout:
          widget.longPressTimeout ?? $data.longPressTimeout ?? 500,
      feedback: widget.feedback ?? $data.feedback ?? true,
      onMove: widget.onMove ?? $data.onMove,
      onMoveEnd: widget.onMoveEnd ?? $data.onMoveEnd,
      onVerticalMove: widget.onVerticalMove ?? $data.onVerticalMove,
      onVerticalMoveEnd: widget.onVerticalMoveEnd ?? $data.onVerticalMoveEnd,
      onHorizontalMove: widget.onHorizontalMove ?? $data.onHorizontalMove,
      onHorizontalMoveEnd:
          widget.onHorizontalMoveEnd ?? $data.onHorizontalMoveEnd,
      onPointerSignal: widget.onPointerSignal ?? $data.onPointerSignal,
    );
  }
}
