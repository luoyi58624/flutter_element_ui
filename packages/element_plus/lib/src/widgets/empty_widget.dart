import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ElEmptyWidget extends LeafRenderObjectWidget {
  /// 以极小代价渲染空 [Widget] 作为占位符
  const ElEmptyWidget({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _EmptyRender(width, height);
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderObject renderObject,
  ) {
    (renderObject as _EmptyRender)
      .._width = width
      .._height = height;
  }
}

class _EmptyRender extends RenderBox {
  _EmptyRender(this._width, this._height);

  double? _width;

  set width(double? v) {
    if (_width != v) {
      _width = v;
      markNeedsLayout();
    }
  }

  double? _height;

  set height(double? v) {
    if (_height != v) {
      _height = v;
      markNeedsLayout();
    }
  }

  @override
  void performLayout() {
    size = Size(_width ?? 0.0, _height ?? 0.0);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) => false;
}
