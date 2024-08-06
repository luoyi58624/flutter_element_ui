import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/components/others/triangle/triangle.dart';
import 'package:luoyi_dart_base/luoyi_dart_base.dart';

class ElInputNumber extends StatefulWidget {
  const ElInputNumber({super.key});

  @override
  State<ElInputNumber> createState() => _ElInputNumberState();
}

class _ElInputNumberState extends State<ElInputNumber> {
  @override
  Widget build(BuildContext context) {
    return const _ControlButton(direction: AxisDirection.down);
    return const _InputNumberWidget(
      // content: UnconstrainedBox(
      //   child: Container(
      //     width: 150,
      //     height: 36,
      //     color: Colors.green,
      //   ),
      // ),
      // upButton: _ControlButton(direction: AxisDirection.up),
      downButton: _ControlButton(direction: AxisDirection.down),
      content: _Box(color: Colors.green),
      upButton: _Box(color: Colors.red),
      // downButton: _Box(color: Colors.grey),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({required this.direction});

  final AxisDirection direction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElTriangle(
        direction: direction,
      ),
    );
  }
}

enum _InputNumberSlot {
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
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    i('mount');
    _content = updateChild(
      _content,
      widget.content,
      _InputNumberSlot.content,
    );
    _upButton = updateChild(
      _upButton,
      widget.upButton,
      _InputNumberSlot.upButton,
    );
    _downButton = updateChild(
      _downButton,
      widget.downButton,
      _InputNumberSlot.downButton,
    );
  }

  // @override
  // void visitChildren(ElementVisitor visitor) {
  //   if (_content != null) visitor(_content!);
  //   if (_upButton != null) visitor(_upButton!);
  //   if (_downButton != null) visitor(_downButton!);
  // }

  @override
  void insertRenderObjectChild(RenderBox child, covariant Object? slot) {
    i(child.runtimeType, 'insert');
    switch (slot) {
      case _InputNumberSlot.content:
        renderObject.content = child;
        break;
      case _InputNumberSlot.upButton:
        renderObject.upButton = child;
        break;
      case _InputNumberSlot.downButton:
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
      case _InputNumberSlot.content:
        renderObject.content = null;
        break;
      case _InputNumberSlot.upButton:
        renderObject.upButton = null;
        break;
      case _InputNumberSlot.downButton:
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
  void performLayout() {
    i(constraints);
    content!.layout(BoxConstraints.tight(const Size(120, 40)));
    upButton!.layout(BoxConstraints.tight(const Size(24, 20)));
    downButton!.layout(BoxConstraints.tight(const Size(24, 20)));
    size = constraints.constrain(Size(200, 40));
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    BoxParentData contentParentData = content!.parentData as BoxParentData;
    i(contentParentData);
    context.paintChild(content!, offset);
    context.paintChild(upButton!, offset + Offset(120, 0));
    context.paintChild(downButton!, offset + Offset(120, 20));
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
    final w = size.width;
    final h = size.height;
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
