import 'package:example/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'scroll_view.dart';

class ScrollRenderTestPage extends HookWidget {
  const ScrollRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义滚动渲染'),
      ),
      body: Listener(
        onPointerSignal: (e){
          i(e);
        },
        child: _Scroll(
          child: Container(
            width: 200,
            height: 1200,
            color: Colors.green,
            child: const Column(
              children: [
                Text('First'),
                Spacer(),
                Text('First'),
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
      ),
    );
  }
}

class _Scroll extends SingleChildRenderObjectWidget {
  const _Scroll({super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderScroll();
  }
}

class _RenderScroll extends RenderBox
    with RenderObjectWithChildMixin<RenderBox> {
  @override
  void performLayout() {
    i(constraints);
    size = constraints.biggest;
    if (child != null) {
      child!.layout(const BoxConstraints());
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(
      offset & size,
      Paint()..color = Colors.grey,
    );
    if (child != null) {
      context.paintChild(child as RenderObject, offset.copyWith(dy: -700));
    }
  }

  @override
  bool hitTestSelf(Offset position) {
    // TODO: implement hitTestSelf
    return true;
  }
}
