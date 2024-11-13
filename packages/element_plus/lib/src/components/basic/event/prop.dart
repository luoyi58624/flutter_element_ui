part of 'index.dart';

class _Prop {
  final bool disabled;
  final HitTestBehavior hitTestBehavior;
  final MouseCursor cursor;
  final PointerEnterEventListener? onEnter;
  final PointerExitEventListener? onExit;
  final PointerHoverEventListener? onHover;
  final PointerDownEventListener? onTapDown;
  final PointerUpEventListener? onTapUp;
  final int tapUpDelay;
  final VoidCallback? onTapCancel;
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

  _Prop({
    required this.disabled,
    required this.hitTestBehavior,
    required this.cursor,
    required this.onEnter,
    required this.onExit,
    required this.onHover,
    required this.onTapDown,
    required this.onTapUp,
    required this.tapUpDelay,
    required this.onTapCancel,
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
      onTapDown: widget.onTapDown ?? $data.onTapDown,
      onTapUp: widget.onTapUp ?? $data.onTapUp,
      tapUpDelay: widget.tapUpDelay ?? $data.tapUpDelay ?? 100,
      onTapCancel: widget.onTapCancel ?? $data.onTapCancel,
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
    );
  }
}
