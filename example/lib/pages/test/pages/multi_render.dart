import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MultiRenderTestPage extends StatelessWidget {
  const MultiRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}

class _MyWidget extends MultiChildRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MyRenderObject();
  }
}

class _MyRenderObject extends RenderBox
    with ContainerRenderObjectMixin<RenderBox, MultiChildLayoutParentData> {}
