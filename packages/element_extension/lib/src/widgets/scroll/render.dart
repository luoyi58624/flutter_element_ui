part of 'index.dart';

class _SingleChildViewport extends SingleChildRenderObjectWidget {
  const _SingleChildViewport({
    this.axisDirection = AxisDirection.down,
    required this.offset,
    super.child,
    required this.clipBehavior,
  });

  final AxisDirection axisDirection;
  final ViewportOffset offset;
  final Clip clipBehavior;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScroll(
      offset: offset,
      axisDirection: axisDirection,
      // clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _RenderSingleChildViewport renderObject) {
    // Order dependency: The offset setter reads the axis direction.
    renderObject
      ..axisDirection = axisDirection
      ..offset = offset
      ..clipBehavior = clipBehavior;
  }

  @override
  SingleChildRenderObjectElement createElement() {
    return _SingleChildViewportElement(this);
  }
}

class _SingleChildViewportElement extends SingleChildRenderObjectElement
    with NotifiableElementMixin, ViewportElementMixin {
  _SingleChildViewportElement(_SingleChildViewport super.widget);
}

class _RenderScroll extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>
    implements RenderAbstractViewport {
  _RenderScroll({
    required ViewportOffset offset,
    AxisDirection axisDirection = AxisDirection.down,
  })  : _offset = offset,
        _axisDirection = axisDirection;

  ViewportOffset _offset;

  ViewportOffset get offset => _offset;

  set offset(ViewportOffset value) {
    if (value == _offset) {
      return;
    }
    if (attached) {
      _offset.removeListener(_hasScrolled);
    }
    _offset = value;
    if (attached) {
      _offset.addListener(_hasScrolled);
    }
    markNeedsLayout();
  }

  AxisDirection get axisDirection => _axisDirection;
  AxisDirection _axisDirection;

  set axisDirection(AxisDirection value) {
    if (value == _axisDirection) {
      return;
    }
    _axisDirection = value;
    markNeedsLayout();
  }

  void _hasScrolled() {
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  Axis get axis => axisDirectionToAxis(axisDirection);

  Offset get _paintOffset => _paintOffsetForPosition(offset.pixels);

  Offset _paintOffsetForPosition(double position) {
    return switch (axisDirection) {
      AxisDirection.up =>
        Offset(0.0, position - child!.size.height + size.height),
      AxisDirection.left =>
        Offset(position - child!.size.width + size.width, 0.0),
      AxisDirection.right => Offset(-position, 0.0),
      AxisDirection.down => Offset(0.0, -position),
    };
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
        child as RenderObject, Offset(offset.dx, offset.dy - _paintOffset.dy));
  }

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return child?.hitTest(result,
            position: Offset(position.dx, position.dy + _paintOffset.dy)) ??
        false;
  }

  @override
  RevealedOffset getOffsetToReveal(
    RenderObject target,
    double alignment, {
    Rect? rect,
    Axis? axis,
  }) {
    // One dimensional viewport has only one axis, override if it was
    // provided/may be mismatched.
    axis = this.axis;

    rect ??= target.paintBounds;
    if (target is! RenderBox) {
      return RevealedOffset(offset: offset.pixels, rect: rect);
    }

    final RenderBox targetBox = target;
    final Matrix4 transform = targetBox.getTransformTo(child);
    final Rect bounds = MatrixUtils.transformRect(transform, rect);
    final Size contentSize = child!.size;

    final (
      double mainAxisExtent,
      double leadingScrollOffset,
      double targetMainAxisExtent
    ) = switch (axisDirection) {
      AxisDirection.up => (
          size.height,
          contentSize.height - bounds.bottom,
          bounds.height
        ),
      AxisDirection.left => (
          size.width,
          contentSize.width - bounds.right,
          bounds.width
        ),
      AxisDirection.right => (size.width, bounds.left, bounds.width),
      AxisDirection.down => (size.height, bounds.top, bounds.height),
    };

    final double targetOffset = leadingScrollOffset -
        (mainAxisExtent - targetMainAxisExtent) * alignment;
    final Rect targetRect = bounds.shift(_paintOffsetForPosition(targetOffset));
    return RevealedOffset(offset: targetOffset, rect: targetRect);
  }
}
