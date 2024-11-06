part of 'index.dart';

class _ElDragState extends State<ElDrag> {
  late Offset widgetPosition; // 当前小部件的全局位置坐标点
  Offset? downPosition; // 指针按下的全局坐标点
  Offset? downLocalPosition; // 指针按下的局部坐标点

  // 以 [downPosition] 为基点，判断移动幅度是否超出设置的 [widget.triggerOffset]
  ({double l, double t, double r, double b})? triggerPosition;

  bool isActiveDrag = false; // 是否开始拖拽
  OverlayEntry? _entry; // 拖拽浮层实例对象
  Offset oldDragOffset = Offset.zero; // 上一次的拖拽偏移值，用于计算 delta 变量
  final _dragOffset = Obs(Offset.zero); // 当前拖拽的位置

  Offset get dragOffset => _dragOffset.value;

  set dragOffset(Offset offset) {
    assert(downLocalPosition != null);
    _dragOffset.value = switch (widget.axis) {
      Axis.horizontal => Offset(
          offset.dx - downLocalPosition!.dx,
          widgetPosition.dy,
        ),
      Axis.vertical => Offset(
          widgetPosition.dx,
          offset.dy - downLocalPosition!.dy,
        ),
      null => Offset(
          offset.dx - downLocalPosition!.dx,
          offset.dy - downLocalPosition!.dy,
        ),
    };
  }

  void _onPointerDown(PointerDownEvent e) {
    setState(() {
      downPosition = e.position;
      downLocalPosition = e.localPosition;
      triggerPosition = (
        l: e.position.dx - widget.triggerOffset.dx,
        t: e.position.dy - widget.triggerOffset.dy,
        r: e.position.dx + widget.triggerOffset.dx,
        b: e.position.dy + widget.triggerOffset.dy
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
    if (isActiveDrag ||
        e.position.dx < triggerPosition!.l ||
        e.position.dx > triggerPosition!.r ||
        e.position.dy < triggerPosition!.t ||
        e.position.dy > triggerPosition!.b) {
      if (isActiveDrag == false) {
        isActiveDrag = true;
        dragOffset = e.position;
        if (widget.feedback != null) {
          _entry = OverlayEntry(
            builder: (context) => ObsBuilder(builder: (context) {
              return Positioned(
                left: dragOffset.dx,
                top: dragOffset.dy,
                child: UnconstrainedBox(child: widget.feedback),
              );
            }),
          );
          Overlay.of(context, rootOverlay: true).insert(_entry!);
        }
      } else {
        dragOffset = e.position;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    nextTick(() {
      widgetPosition = context.getPosition();
    });
    return ElListener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      onPointerMove: downPosition == null ? null : _onPointerMove,
      child: widget.child,
    );
  }
}
