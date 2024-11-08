import 'package:element_docs/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/rendering.dart';

class ScrollRenderTestPage extends HookWidget {
  const ScrollRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义滚动渲染'),
      ),
      body: const _ScrollWidget(
        child: _Child(),
      ),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 120000,
      child: Column(
        children: [
          ...List.generate(
            100,
            (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElButton(
                onPressed: () {},
                child: Text('列表 - ${index + 1}'),
              ),
            ),
          ),
        ],
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
  /// 惯性移动动画控制器
  late final AnimationController controller =
      AnimationController.unbounded(vsync: vsync)..addListener(animateListener);
  double offset = 0;

  double? oldAnimateValue; // 记录旧的动画值，用于计算惯性移动的偏移值

  void animateListener() {
    late double details;
    if (oldAnimateValue == null) {
      oldAnimateValue = controller.value;
      details = controller.value;
    } else {
      details = controller.value - oldAnimateValue!;
      oldAnimateValue = controller.value;
    }
    setState(() {
      offset += details;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

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
          setState(() {
            offset += e.delta.dy;
          });
        },
        onVerticalDragEnd: (e) {
          FrictionSimulation frictionSim = FrictionSimulation(
            0.135,
            0.0,
            e.velocity.pixelsPerSecond.dy,
          );
          controller.animateWith(frictionSim);
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
    size = constraints.biggest;
    child!.layout(const BoxConstraints());
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child as RenderObject, Offset(offset.dx, _offset));
  }

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }
}
