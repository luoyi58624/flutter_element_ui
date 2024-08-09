import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MultiRenderTestPage extends HookWidget {
  const MultiRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    final useCustomBox = useState(false);
    var result = [
      ...[Colors.green, Colors.red, Colors.blue, Colors.amber].map(
        (e) => Container(
          width: 200,
          height: 200,
          color: e,
        ),
      ),
      ...List.generate(
        10,
        (index) => ElevatedButton(
          onPressed: () {},
          child: const Text('hello'),
        ),
      ),
      ...List.generate(
        100,
        (index) => const Padding(
          padding: EdgeInsets.all(8),
          child: Material(
            elevation: 8,
            color: Colors.green,
            child: SizedBox(
              width: 200,
              height: 200,
              child: H1('标题'),
            ),
          ),
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义渲染多节点'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElButton(
              onPressed: () {
                flag.value = !flag.value;
              },
              child: flag.value ? '水平布局' : '垂直布局',
            ),
            ElButton(
              onPressed: () {
                useCustomBox.value = !useCustomBox.value;
              },
              child: useCustomBox.value ? '自定义排版' : 'Flutter排版',
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: flag.value ? Axis.horizontal : Axis.vertical,
                child: useCustomBox.value
                    ? _Box(
                        size: 150,
                        axis: flag.value ? Axis.horizontal : Axis.vertical,
                        children: result,
                      )
                    : flag.value
                        ? Row(
                            children: result,
                          )
                        : Column(
                            children: result,
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Box extends MultiChildRenderObjectWidget {
  const _Box({
    super.children,
    this.size = 50,
    this.axis = Axis.vertical,
  });

  final double size;
  final Axis axis;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BoxRender(size, axis);
  }

  @override
  void updateRenderObject(BuildContext context, _BoxRender renderObject) {
    renderObject
      ..boxSize = size
      ..axis = axis;
  }
}

class _ParentData extends ContainerBoxParentData<RenderBox> {}

class _BoxRender extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _ParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _ParentData> {
  _BoxRender(this._boxSize, this._axis);

  double _boxSize;

  set boxSize(double boxSize) {
    _boxSize = boxSize;
    markNeedsLayout();
  }

  Axis _axis;

  set axis(Axis axis) {
    _axis = axis;
    markNeedsLayout();
  }

  bool get isVertical => _axis == Axis.vertical;

  @override
  void performLayout() {
    var child = firstChild;
    Size boxSize = isVertical ? Size(_boxSize, 0) : Size(0, _boxSize);
    while (child != null) {
      var childParentData = child.parentData as _ParentData;
      child.layout(
        BoxConstraints(
          minWidth: isVertical ? _boxSize : 0,
          maxWidth: isVertical ? _boxSize : double.infinity,
          minHeight: isVertical ? 0 : _boxSize,
          maxHeight: isVertical ? double.infinity : _boxSize,
        ),
        parentUsesSize: true,
      );
      if (isVertical) {
        childParentData.offset = Offset(0, boxSize.height);
        boxSize = Size(boxSize.width, boxSize.height + child.size.height);
      } else {
        childParentData.offset = Offset(boxSize.width, 0);
        boxSize = Size(boxSize.width + child.size.width, boxSize.height);
      }
      child = childAfter(child);
    }
    size = constraints.constrain(boxSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _ParentData) {
      child.parentData = _ParentData();
    }
  }
}
