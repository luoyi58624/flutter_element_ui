import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyStackTestPage extends HookWidget {
  const MyStackTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义 Stack 布局'),
      ),
      body: Column(
        children: [
          MyStack(
            children: [
              Container(
                width: 200,
                height: 200,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  flag.value = !flag.value;
                },
                child: HoverBuilder(
                  onlyCursor: true,
                  cursor: SystemMouseCursors.click,
                  builder: (context) {
                    return Container(
                      width: 200,
                      height: 200,
                      color: flag.value ? Colors.green : Colors.red,
                    );
                  },
                ),
              ),
            ],
          ),
          // Container(
          //   width: 200,
          //   height: 200,
          //   color: Colors.blue,
          // ),
        ],
      ),
    );
  }
}

class MyStack extends MultiChildRenderObjectWidget {
  const MyStack({super.key, super.children});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderStack();
  }
}

class _StackParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderStack extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _StackParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _StackParentData> {
  @override
  void performLayout() {
    var child = firstChild;
    child!.layout(constraints.loosen(), parentUsesSize: true);
    (child.parentData as _StackParentData).offset = Offset.zero;
    size = child.size;
    var nextChild = childAfter(child);
    nextChild!.layout(constraints.loosen());
    (nextChild.parentData as _StackParentData).offset = const Offset(100, 100);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTest(BoxHitTestResult result, {required Offset position}) {
    if (hitTestChildren(result, position: position)) {
      result.add(BoxHitTestEntry(this, position));
      return true;
    }
    return false;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    // return defaultHitTestChildren(result, position: position);
    i('xx');
    var child = lastChild;
    while (child != null) {
      // The x, y parameters have the top left of the node's box as the origin.
      final _StackParentData childParentData =
          child.parentData! as _StackParentData;
      final bool isHit = result.addWithPaintOffset(
        offset: childParentData.offset,
        position: position,
        hitTest: (BoxHitTestResult result, Offset transformed) {
          assert(transformed == position - childParentData.offset);
          return child!.hitTest(result, position: transformed);
        },
      );
      if (isHit) {
        return true;
      }
      child = childParentData.previousSibling;
    }
    return false;
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! _StackParentData) {
      child.parentData = _StackParentData();
    }
  }
}
