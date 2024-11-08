part of 'index.dart';

class _Scroll extends SingleChildRenderObjectWidget {
  const _Scroll({super.child, required this.offset});

  final double offset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScroll(offset: offset);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderScroll renderObject) {
    renderObject.offset = offset;
  }
}

class _RenderScroll extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  _RenderScroll({required double offset}) : _offset = offset;

  double _offset;

  set offset(double v) {
    _offset = v;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    child!.layout(const BoxConstraints());
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child as RenderObject, Offset(offset.dx, _offset));
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }
}
