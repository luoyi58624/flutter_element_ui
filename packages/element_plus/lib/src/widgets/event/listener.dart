part of 'index.dart';

extension ElPointerDownEventExtension on PointerDownEvent {
  /// 将 tapDown 原始指针事件转成 [TapDownDetails]
  TapDownDetails get toDetails => TapDownDetails(
        globalPosition: position,
        localPosition: localPosition,
        kind: kind,
      );
}

extension ElPointerUpEventExtension on PointerUpEvent {
  /// 将 tapUp 原始指针事件转成 [TapUpDetails]
  TapUpDetails get toDetails => TapUpDetails(
        globalPosition: position,
        localPosition: localPosition,
        kind: kind,
      );
}

class ElListener extends _EventBubbleWidget {
  /// 对 [Listener] 进行包装，支持事件冒泡
  const ElListener({
    super.key,
    required this.child,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerCancel,
  });

  final Widget child;

  /// 命中测试行为
  final HitTestBehavior hitTestBehavior;

  /// 指针按下事件
  final PointerDownEventListener? onPointerDown;

  /// 指针释放事件
  final PointerUpEventListener? onPointerUp;

  /// 取消事件
  final PointerCancelEventListener? onPointerCancel;

  @override
  State<ElListener> createState() => _ElListenerState();
}

class _ElListenerState extends _EventBubbleWidgetState<ElListener> {
  void _onPointerDown(PointerDownEvent e) {
    ElStopPropagation._of(context, _EventBubbleWidget.stopPropagation);
    if (bubbleFlag) {
      if (widget.onPointerDown != null) widget.onPointerDown!(e);
    }
  }

  void _onPointerUp(PointerUpEvent e) {
    reset();
    if (bubbleFlag) {
      if (widget.onPointerUp != null) widget.onPointerUp!(e);
    }
  }

  void _onPointerCancel(PointerCancelEvent e) {
    reset();
    if (bubbleFlag) {
      if (widget.onPointerCancel != null) widget.onPointerCancel!(e);
    }
  }

  @override
  Widget builder(BuildContext context) {
    return Listener(
      behavior: widget.hitTestBehavior,
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      child: widget.child,
    );
  }
}
