import 'dart:math' as math;

import 'package:element_dart/element_dart.dart';
import 'package:flutter/gestures.dart' show DragStartBehavior;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ScrollWidget extends StatelessWidget {
  const ScrollWidget({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.child,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.hitTestBehavior = HitTestBehavior.opaque,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  }) : assert(
          !(controller != null && (primary ?? false)),
          'Primary ScrollViews obtain their ScrollController via inheritance '
          'from a PrimaryScrollController widget. You cannot both set primary to '
          'true and pass an explicit controller.',
        );

  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final Widget? child;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final HitTestBehavior hitTestBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  AxisDirection _getDirection(BuildContext context) {
    return getAxisDirectionFromAxisReverseAndDirectionality(
        context, scrollDirection, reverse);
  }

  @override
  Widget build(BuildContext context) {
    final AxisDirection axisDirection = _getDirection(context);
    Widget? contents = child;
    if (padding != null) {
      contents = Padding(padding: padding!, child: contents);
    }
    final bool effectivePrimary = primary ??
        controller == null &&
            PrimaryScrollController.shouldInherit(context, scrollDirection);

    final ScrollController? scrollController = effectivePrimary
        ? PrimaryScrollController.maybeOf(context)
        : controller;

    Widget scrollable = Scrollable(
      dragStartBehavior: dragStartBehavior,
      axisDirection: axisDirection,
      controller: scrollController,
      physics: physics,
      restorationId: restorationId,
      clipBehavior: clipBehavior,
      hitTestBehavior: hitTestBehavior,
      viewportBuilder: (BuildContext context, ViewportOffset offset) {
        return _SingleChildViewport(
          axisDirection: axisDirection,
          offset: offset,
          clipBehavior: clipBehavior,
          child: contents,
        );
      },
    );

    if (keyboardDismissBehavior == ScrollViewKeyboardDismissBehavior.onDrag) {
      scrollable = NotificationListener<ScrollUpdateNotification>(
        child: scrollable,
        onNotification: (ScrollUpdateNotification notification) {
          final FocusScopeNode currentScope = FocusScope.of(context);
          if (notification.dragDetails != null &&
              !currentScope.hasPrimaryFocus &&
              currentScope.hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
          return false;
        },
      );
    }

    return effectivePrimary && scrollController != null
        // Further descendant ScrollViews will not inherit the same
        // PrimaryScrollController
        ? PrimaryScrollController.none(child: scrollable)
        : scrollable;
  }
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
    i(_offset);
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
      // axisDirection: axisDirection,
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

// =======================================================================

class _RenderSingleChildViewport extends RenderBox
    with RenderObjectWithChildMixin<RenderBox>
    implements RenderAbstractViewport {
  _RenderSingleChildViewport({
    AxisDirection axisDirection = AxisDirection.down,
    required ViewportOffset offset,
    RenderBox? child,
    required Clip clipBehavior,
  })  : _axisDirection = axisDirection,
        _offset = offset,
        _clipBehavior = clipBehavior {
    this.child = child;
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

  Axis get axis => axisDirectionToAxis(axisDirection);

  ViewportOffset get offset => _offset;
  ViewportOffset _offset;

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

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.none].
  Clip get clipBehavior => _clipBehavior;
  Clip _clipBehavior = Clip.none;

  set clipBehavior(Clip value) {
    if (value != _clipBehavior) {
      _clipBehavior = value;
      markNeedsPaint();
      markNeedsSemanticsUpdate();
    }
  }

  void _hasScrolled() {
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }

  @override
  void setupParentData(RenderObject child) {
    // We don't actually use the offset argument in BoxParentData, so let's
    // avoid allocating it at all.
    if (child.parentData is! ParentData) {
      child.parentData = ParentData();
    }
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _offset.addListener(_hasScrolled);
  }

  @override
  void detach() {
    _offset.removeListener(_hasScrolled);
    super.detach();
  }

  @override
  bool get isRepaintBoundary => true;

  double get _viewportExtent {
    assert(hasSize);
    return switch (axis) {
      Axis.horizontal => size.width,
      Axis.vertical => size.height,
    };
  }

  double get _minScrollExtent {
    assert(hasSize);
    return 0.0;
  }

  double get _maxScrollExtent {
    assert(hasSize);
    if (child == null) {
      return 0.0;
    }
    return math.max(
        0.0,
        switch (axis) {
          Axis.horizontal => child!.size.width - size.width,
          Axis.vertical => child!.size.height - size.height,
        });
  }

  BoxConstraints _getInnerConstraints(BoxConstraints constraints) {
    return switch (axis) {
      Axis.horizontal => constraints.heightConstraints(),
      Axis.vertical => constraints.widthConstraints(),
    };
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return child?.getMinIntrinsicWidth(height) ?? 0.0;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return child?.getMaxIntrinsicWidth(height) ?? 0.0;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return child?.getMinIntrinsicHeight(width) ?? 0.0;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return child?.getMaxIntrinsicHeight(width) ?? 0.0;
  }

  // We don't override computeDistanceToActualBaseline(), because we
  // want the default behavior (returning null). Otherwise, as you
  // scroll, it would shift in its parent if the parent was baseline-aligned,
  // which makes no sense.

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    if (child == null) {
      return constraints.smallest;
    }
    final Size childSize =
        child!.getDryLayout(_getInnerConstraints(constraints));
    return constraints.constrain(childSize);
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    if (child == null) {
      size = constraints.smallest;
    } else {
      child!.layout(_getInnerConstraints(constraints), parentUsesSize: true);
      size = constraints.constrain(child!.size);
    }

    if (offset.hasPixels) {
      if (offset.pixels > _maxScrollExtent) {
        offset.correctBy(_maxScrollExtent - offset.pixels);
      } else if (offset.pixels < _minScrollExtent) {
        offset.correctBy(_minScrollExtent - offset.pixels);
      }
    }

    offset.applyViewportDimension(_viewportExtent);
    offset.applyContentDimensions(_minScrollExtent, _maxScrollExtent);
  }

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

  bool _shouldClipAtPaintOffset(Offset paintOffset) {
    assert(child != null);
    switch (clipBehavior) {
      case Clip.none:
        return false;
      case Clip.hardEdge:
      case Clip.antiAlias:
      case Clip.antiAliasWithSaveLayer:
        return paintOffset.dx < 0 ||
            paintOffset.dy < 0 ||
            paintOffset.dx + child!.size.width > size.width ||
            paintOffset.dy + child!.size.height > size.height;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Offset paintOffset = _paintOffset;
    context.paintChild(child as RenderObject, offset + paintOffset);
    // if (child != null) {
    //   final Offset paintOffset = _paintOffset;
    //
    //   void paintContents(PaintingContext context, Offset offset) {
    //     context.paintChild(child!, offset + paintOffset);
    //   }
    //
    //   if (_shouldClipAtPaintOffset(paintOffset)) {
    //     _clipRectLayer.layer = context.pushClipRect(
    //       needsCompositing,
    //       offset,
    //       Offset.zero & size,
    //       paintContents,
    //       clipBehavior: clipBehavior,
    //       oldLayer: _clipRectLayer.layer,
    //     );
    //   } else {
    //     _clipRectLayer.layer = null;
    //     paintContents(context, offset);
    //   }
    // }
  }

  final LayerHandle<ClipRectLayer> _clipRectLayer =
      LayerHandle<ClipRectLayer>();

  @override
  void dispose() {
    _clipRectLayer.layer = null;
    super.dispose();
  }

  @override
  void applyPaintTransform(RenderBox child, Matrix4 transform) {
    final Offset paintOffset = _paintOffset;
    transform.translate(paintOffset.dx, paintOffset.dy);
  }

  @override
  Rect? describeApproximatePaintClip(RenderObject? child) {
    if (child != null && _shouldClipAtPaintOffset(_paintOffset)) {
      return Offset.zero & size;
    }
    return null;
  }

  // @override
  // bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
  //   if (child != null) {
  //     return result.addWithPaintOffset(
  //       offset: _paintOffset,
  //       position: position,
  //       hitTest: (BoxHitTestResult result, Offset transformed) {
  //         assert(transformed == position + -_paintOffset);
  //         return child!.hitTest(result, position: transformed);
  //       },
  //     );
  //   }
  //   return false;
  // }

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

  @override
  void showOnScreen({
    RenderObject? descendant,
    Rect? rect,
    Duration duration = Duration.zero,
    Curve curve = Curves.ease,
  }) {
    if (!offset.allowImplicitScrolling) {
      return super.showOnScreen(
        descendant: descendant,
        rect: rect,
        duration: duration,
        curve: curve,
      );
    }

    final Rect? newRect = RenderViewportBase.showInViewport(
      descendant: descendant,
      viewport: this,
      offset: offset,
      rect: rect,
      duration: duration,
      curve: curve,
    );
    super.showOnScreen(
      rect: newRect,
      duration: duration,
      curve: curve,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Offset>('offset', _paintOffset));
  }

  @override
  Rect describeSemanticsClip(RenderObject child) {
    final double remainingOffset = _maxScrollExtent - offset.pixels;
    switch (axisDirection) {
      case AxisDirection.up:
        return Rect.fromLTRB(
          semanticBounds.left,
          semanticBounds.top - remainingOffset,
          semanticBounds.right,
          semanticBounds.bottom + offset.pixels,
        );
      case AxisDirection.right:
        return Rect.fromLTRB(
          semanticBounds.left - offset.pixels,
          semanticBounds.top,
          semanticBounds.right + remainingOffset,
          semanticBounds.bottom,
        );
      case AxisDirection.down:
        return Rect.fromLTRB(
          semanticBounds.left,
          semanticBounds.top - offset.pixels,
          semanticBounds.right,
          semanticBounds.bottom + remainingOffset,
        );
      case AxisDirection.left:
        return Rect.fromLTRB(
          semanticBounds.left - remainingOffset,
          semanticBounds.top,
          semanticBounds.right + offset.pixels,
          semanticBounds.bottom,
        );
    }
  }
}
