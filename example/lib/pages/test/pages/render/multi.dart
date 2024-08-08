import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MultiRenderTestPage extends HookWidget {
  const MultiRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义渲染多节点'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // _Box(children: [
            //   ...List.generate(
            //     1,
            //     (index) => Center(
            //       child: Container(
            //         width: 24,
            //         height: 24,
            //         color: Colors.green,
            //       ),
            //     ),
            //   ),
            // ]),
          ],
        ),
      ),
    );
  }
}

class _Box extends MultiChildRenderObjectWidget {
  const _Box({
    super.children,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BoxRender(width, height);
  }

  @override
  void updateRenderObject(BuildContext context, _BoxRender renderObject) {
    renderObject
      ..width = width
      ..height = height;
  }
}

class _ParentData extends ParentData with ContainerParentDataMixin<RenderBox> {}

class _BoxRender extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, _ParentData> {
  _BoxRender(this._width, this._height);

  double? _width;

  set width(double? width) {
    _width = width;
    markNeedsLayout();
  }

  double? _height;

  set height(double? height) {
    _height = height;
    markNeedsLayout();
  }

  @override
  void performLayout() {
    // i('xxxxx');
    size = constraints.constrain(Size(
      _width ?? double.infinity,
      _height ?? double.infinity,
    ));
    i(childCount);
    if (childCount > 0) {
      firstChild!.layout(const BoxConstraints());
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(
      offset & size,
      Paint()..color = Colors.grey,
    );
    context.paintChild(firstChild as RenderObject, offset);
  }
}
