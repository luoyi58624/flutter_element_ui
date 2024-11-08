part of 'index.dart';

class _ElDragState extends State<ElDrag> {
  late Offset widgetPosition; // 当前小部件的全局位置坐标点
  Offset? downPosition; // 指针按下的全局坐标点
  Offset? downLocalPosition; // 指针按下的局部坐标点

  // 以 [downPosition] 为基点，判断移动幅度是否超出设置的 [widget.triggerOffset]
  ({double l, double t, double r, double b})? triggerPosition;

  bool isActiveDrag = false; // 是否开始拖拽
  late OverlayState _overlay; // 遮罩层
  late Offset _overlayOffset; // 遮罩层偏移位置
  OverlayEntry? _entry; // 拖拽浮层实例对象
  Offset oldDragOffset = Offset.zero; // 上一次的拖拽偏移值，用于计算 delta 变量
  final _dragOffset = Obs(Offset.zero); // 当前拖拽的位置

  Offset get dragOffset => _dragOffset.value;

  set dragOffset(Offset offset) {
    assert(downLocalPosition != null);
    _dragOffset.value = switch (widget.axis) {
      Axis.horizontal => Offset(
          offset.dx - downLocalPosition!.dx - _overlayOffset.dx,
          widgetPosition.dy,
        ),
      Axis.vertical => Offset(
          widgetPosition.dx,
          offset.dy - downLocalPosition!.dy - _overlayOffset.dy,
        ),
      null => Offset(
          offset.dx - downLocalPosition!.dx - _overlayOffset.dx,
          offset.dy - downLocalPosition!.dy - _overlayOffset.dy,
        ),
    };
  }

  void _onPointerDown(PointerDownEvent e) {
    setState(() {
      downPosition = e.position;
      downLocalPosition = e.localPosition;
      triggerPosition = (
        l: downPosition!.dx - widget.triggerOffset.dx,
        t: downPosition!.dy - widget.triggerOffset.dy,
        r: downPosition!.dx + widget.triggerOffset.dx,
        b: downPosition!.dy + widget.triggerOffset.dy
      );
    });
  }

  void _onPointerUp(PointerUpEvent e) {
    if (_entry != null) {
      _entry!.remove();
      _entry = null;
    }
    downPosition = null;
    isActiveDrag = false;
    setState(() {});
  }

  void _onPointerMove(PointerMoveEvent e) {
    final movePosition = e.position;
    if (isActiveDrag ||
        movePosition.dx < triggerPosition!.l ||
        movePosition.dx > triggerPosition!.r ||
        movePosition.dy < triggerPosition!.t ||
        movePosition.dy > triggerPosition!.b) {
      dragOffset = movePosition;
      if (isActiveDrag == false) {
        isActiveDrag = true;
        if (widget.feedback != null) {
          _entry = OverlayEntry(
            builder: (context) => ObsBuilder(builder: (context) {
              return Positioned(
                left: dragOffset.dx,
                top: dragOffset.dy,
                child: IgnorePointer(
                  child: UnconstrainedBox(child: widget.feedback),
                ),
              );
            }),
          );
          _overlay.insert(_entry!);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    nextTick(() {
      if (mounted) {
        widgetPosition = context.getPosition();
        _overlayOffset = _overlay.context.getPosition();
      }
    });
    if (context.mounted) {
      _overlay = Overlay.of(context, rootOverlay: widget.rootOverlay);
    }

    return ElListener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerMove: downPosition == null ? null : _onPointerMove,
      child: widget.child,
    );
  }
}
