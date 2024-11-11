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

class ElListener extends ElEvent {
  /// 如果你想要阻止祖先 [Listener] 事件的执行，那么请对上层、下层组件同时使用 [ElListener]，
  /// 然后在中间插入 [ElStopPropagation] 小部件，当下层 [Listener] 事件触发时，
  /// 会阻止上层所有监听的指针事件。
  const ElListener({
    super.key,
    required this.child,
    this.hitTestBehavior = HitTestBehavior.deferToChild,
    this.onPointerDown,
    this.onPointerMove,
    this.onPointerUp,
    this.onPointerHover,
    this.onPointerCancel,
    this.onPointerPanZoomStart,
    this.onPointerPanZoomUpdate,
    this.onPointerPanZoomEnd,
    this.onPointerSignal,
  });

  final Widget child;

  /// 命中测试行为
  final HitTestBehavior hitTestBehavior;

  /// 指针按下事件
  final PointerDownEventListener? onPointerDown;

  /// 指针移动事件
  final PointerMoveEventListener? onPointerMove;

  /// 指针释放事件
  final PointerUpEventListener? onPointerUp;

  /// 指针悬停事件
  final PointerHoverEventListener? onPointerHover;

  /// 取消事件
  final PointerCancelEventListener? onPointerCancel;

  /// 平移、缩放开始事件
  final PointerPanZoomStartEventListener? onPointerPanZoomStart;

  /// 平移、缩放更新事件
  final PointerPanZoomUpdateEventListener? onPointerPanZoomUpdate;

  /// 平移、缩放结束事件
  final PointerPanZoomEndEventListener? onPointerPanZoomEnd;

  /// 当指针信号出现在当前小部件时触发，例如：鼠标齿轮滚动
  final PointerSignalEventListener? onPointerSignal;

  @override
  State<ElListener> createState() => _ElListenerState();
}

class _ElListenerState extends ElEventState<ElListener> {
  void _onPointerDown(PointerDownEvent e) {
    if (allowed) {
      ElStopPropagation._of(context, ElEvent.stopPropagation);
      widget.onPointerDown?.call(e);
    }
  }

  void _onPointerUp(PointerUpEvent e) {
    if (allowed) {
      reset();
      widget.onPointerUp?.call(e);
    }
  }

  void _onPointerCancel(PointerCancelEvent e) {
    if (allowed) {
      reset();
      widget.onPointerCancel?.call(e);
    }
  }

  @override
  Widget builder(BuildContext context) {
    return Listener(
      behavior: widget.hitTestBehavior,
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerCancel: _onPointerCancel,
      onPointerMove: widget.onPointerMove,
      onPointerHover: widget.onPointerHover,
      onPointerPanZoomStart: widget.onPointerPanZoomStart,
      onPointerPanZoomUpdate: widget.onPointerPanZoomUpdate,
      onPointerPanZoomEnd: widget.onPointerPanZoomEnd,
      onPointerSignal: widget.onPointerSignal,
      child: widget.child,
    );
  }
}
