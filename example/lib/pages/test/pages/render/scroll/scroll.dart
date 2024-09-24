import 'package:example/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'scroll_view.dart';

class ScrollRenderTestPage extends HookWidget {
  const ScrollRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义滚动渲染'),
      ),
      body: _ScrollWidget(
        child: Container(
          width: 200,
          height: 120000,
          // color: Colors.green,
          child: Column(
            children: [
              ...List.generate(
                100,
                // (index) => Text('列表 - ${index + 1}'),
                (index) => ElButton(
                  onPressed: () {},
                  child: Text('列表 - ${index + 1}'),
                ),
              ),
              // Text('First'),
              // Spacer(),
              // Text('First'),
            ],
          ),
        ),
        // child: MyScrollView(
        //   children: [
        //     ...List.generate(
        //       100,
        //       (index) => ListTile(
        //         title: Text('列表-${index + 1}'),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}

class _ScrollWidget extends StatefulWidget {
  const _ScrollWidget({required this.child});

  final Widget child;

  @override
  State<_ScrollWidget> createState() => _ScrollWidgetState();
}

class _ScrollWidgetState extends State<_ScrollWidget> {
  double offset = 0;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerSignal: (e) {
        if (e is PointerScrollEvent) {
          setState(() {
            offset -= e.scrollDelta.dy;
          });
        }
      },
      child: GestureDetector(
        onVerticalDragUpdate: (e) {
          // i(e);
          setState(() {
            offset += e.delta.dy;
          });
        },
        child: _Scroll(
          offset: offset,
          child: widget.child,
        ),
      ),
    );
  }
}

class _Scroll extends SingleChildRenderObjectWidget {
  const _Scroll({super.child, required this.offset});

  final double offset;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScroll(offset: offset);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderScroll renderObject) {
    renderObject.offset = offset;
  }
}

class _RenderScroll extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  _RenderScroll({required double offset}) : _offset = offset;

  double _offset;

  set offset(double v) {
    _offset = v;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    el.i(constraints);
    size = constraints.biggest;
    if (child != null) {
      child!.layout(const BoxConstraints());
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      context.paintChild(child as RenderObject, offset.copyWith(dy: _offset));
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }
}
