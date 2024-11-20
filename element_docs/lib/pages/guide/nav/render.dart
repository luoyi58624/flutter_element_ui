import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyRender extends SingleChildRenderObjectWidget {
  const MyRender({super.key, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MyRender();
  }
}

class _MyRender extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  _MyRender();

  BoxParentData get childParentData => (child!.parentData as BoxParentData);

  @override
  void performLayout() {
    i('performLayout');
    size = const Size(200, 200);
    if (child != null) {
      child!.layout(BoxConstraints.loose(size), parentUsesSize: true);
      childParentData.offset = const Offset(20, 50);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    i('paint');
    Paint paint = Paint()..color = Colors.grey.shade300;
    context.canvas.drawRect(offset & size, paint);
    if (child != null) {
      context.paintChild(child!, offset + childParentData.offset);
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return child?.hitTest(result,
            position: position - childParentData.offset) ??
        false;
  }
}
