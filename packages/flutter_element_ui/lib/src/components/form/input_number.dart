import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_element_ui/src/global.dart';

class ElInputNumber extends HookWidget {
  const ElInputNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return const _InputNumberWidget(
      content: TextField(),
      upButton: _Box(color: Colors.red),
      downButton: _Box(color: Colors.grey),
      // downButton: _ControlButton(direction: AxisDirection.down),
    );
  }
}
//
// class _ControlButton extends StatelessWidget {
//   const _ControlButton({required this.direction});
//
//   final AxisDirection direction;
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: ElTriangle(
//         direction: direction,
//       ),
//     );
//   }
// }

enum _Slot {
  content,
  upButton,
  downButton,
}

class _InputNumberWidget extends RenderObjectWidget {
  const _InputNumberWidget({
    required this.content,
    required this.upButton,
    required this.downButton,
  });

  final Widget content;
  final Widget upButton;
  final Widget downButton;

  @override
  RenderObjectElement createElement() => _InputNumberElement(this);

  @override
  RenderObject createRenderObject(BuildContext context) => _InputNumberRender();
}

class _InputNumberElement extends RenderObjectElement {
  _InputNumberElement(super.widget);

  Element? _content;
  Element? _upButton;
  Element? _downButton;

  @override
  _InputNumberWidget get widget => super.widget as _InputNumberWidget;

  @override
  _InputNumberRender get renderObject =>
      super.renderObject as _InputNumberRender;

  @override
  void visitChildren(ElementVisitor visitor) {
    if (_content != null) visitor(_content!);
    if (_upButton != null) visitor(_upButton!);
    if (_downButton != null) visitor(_downButton!);
  }

  @override
  void forgetChild(Element child) {
    assert(child == _content || child == _upButton);
    if (child == _content) {
      _content = null;
    } else if (child == _upButton) {
      _upButton = null;
    } else if (child == _downButton) {
      _downButton = null;
    }
    super.forgetChild(child);
  }

  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _content = inflateWidget(widget.content, _Slot.content);
    _upButton = inflateWidget(widget.upButton, _Slot.upButton);
    _downButton = inflateWidget(widget.downButton, _Slot.downButton);
  }

  @override
  void update(_InputNumberWidget newWidget) {
    super.update(newWidget);
    _content = updateChild(
      _content,
      newWidget.content,
      _Slot.content,
    );
    _upButton = updateChild(
      _upButton,
      widget.upButton,
      _Slot.upButton,
    );
    _downButton = updateChild(
      _downButton,
      widget.downButton,
      _Slot.downButton,
    );
  }

  @override
  void insertRenderObjectChild(RenderBox child, covariant Object? slot) {
    switch (slot) {
      case _Slot.content:
        renderObject.content = child;
        break;
      case _Slot.upButton:
        renderObject.upButton = child;
        break;
      case _Slot.downButton:
        renderObject.downButton = child;
        break;
    }
  }

  @override
  void moveRenderObjectChild(covariant RenderObject child,
      covariant Object? oldSlot, covariant Object? newSlot) {
    assert(false);
  }

  @override
  void removeRenderObjectChild(
      covariant RenderObject child, covariant Object? slot) {
    switch (slot) {
      case _Slot.content:
        renderObject.content = null;
        break;
      case _Slot.upButton:
        renderObject.upButton = null;
        break;
      case _Slot.downButton:
        renderObject.downButton = null;
        break;
      case null:
        assert(false);
    }
  }
}

class _InputNumberRender extends RenderBox {
  RenderBox? _content;

  RenderBox? get content => _content;

  set content(RenderBox? value) {
    if (value == _content) return;
    if (_content != null) dropChild(_content!);
    _content = value;
    if (_content != null) adoptChild(_content!);
  }

  RenderBox? _upButton;

  RenderBox? get upButton => _upButton;

  set upButton(RenderBox? value) {
    if (value == _upButton) return;
    if (_upButton != null) dropChild(_upButton!);
    _upButton = value;
    if (_upButton != null) adoptChild(_upButton!);
  }

  RenderBox? _downButton;

  RenderBox? get downButton => _downButton;

  set downButton(RenderBox? value) {
    if (value == _downButton) return;
    if (_downButton != null) dropChild(_downButton!);
    _downButton = value;
    if (_downButton != null) adoptChild(_downButton!);
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    if (content != null) content!.attach(owner);
    if (upButton != null) upButton!.attach(owner);
    if (downButton != null) downButton!.attach(owner);
  }

  @override
  void detach() {
    super.detach();
    content?.detach();
    upButton?.detach();
    downButton?.detach();
  }

  @override
  void visitChildren(RenderObjectVisitor visitor) {
    if (content != null) visitor(content!);
    if (upButton != null) visitor(upButton!);
    if (downButton != null) visitor(downButton!);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    for (RenderBox? child in [downButton, upButton, content]) {
      if (child != null) {
        final BoxParentData parentData = child.parentData as BoxParentData;
        final bool isHit = result.addWithPaintOffset(
          offset: parentData.offset,
          position: position,
          hitTest: (BoxHitTestResult result, Offset transformed) {
            assert(transformed == position - parentData.offset);
            return child.hitTest(result, position: transformed);
          },
        );
        if (isHit) {
          return true;
        }
      }
    }

    return false;
  }

  @override
  void performLayout() {
    content!.layout(
      BoxConstraints.tight(const Size(120, 40)),
      parentUsesSize: true,
    );
    upButton!.layout(
      BoxConstraints.tight(const Size(24, 20)),
      parentUsesSize: true,
    );
    downButton!.layout(
      BoxConstraints.tight(const Size(24, 20)),
      parentUsesSize: true,
    );
    size = constraints.constrain(Size(
      content!.size.width + upButton!.size.width,
      content!.size.height,
    ));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    // BoxParentData contentParentData = content!.parentData as BoxParentData;
    // i(contentParentData, 'xxx');

    context.paintChild(content!, offset);
    context.paintChild(upButton!, offset + const Offset(120, 0));
    context.paintChild(downButton!, offset + const Offset(120, 20));
  }
}

class _Box extends LeafRenderObjectWidget {
  final Color color;

  const _Box({required this.color});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BoxRender(color);
  }

  @override
  void updateRenderObject(BuildContext context, _BoxRender renderObject) {
    renderObject.color = color;
  }
}

class _BoxRender extends RenderBox {
  _BoxRender(this.color);

  Color color;

  @override
  void paint(PaintingContext context, Offset offset) {
    // final w = size.width;
    // final h = size.height;
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    // final path = Path()
    //   ..moveTo(0, h)
    //   ..lineTo(w / 2, 0)
    //   ..lineTo(w, h);
    // context.canvas.clipPath(path);
    context.canvas.drawRect(offset & size, paint);
  }

  @override
  void performLayout() {
    size = constraints.constrain(const Size(50, 50));
  }
}
