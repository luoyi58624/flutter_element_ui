part of 'index.dart';

class _ScrollRenderWidget extends SingleChildRenderObjectWidget {
  const _ScrollRenderWidget({super.child, required this.offset});

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
    final BoxConstraints constraints = this.constraints;
    child!.layout(const BoxConstraints(), parentUsesSize: true);
    size = constraints.constrain(child!.size);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(
        child as RenderObject, Offset(offset.dx, offset.dy - _offset));
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return child?.hitTest(result,
            position: Offset(position.dx, position.dy + _offset)) ??
        false;
  }
}
