import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MultiRenderTestPage extends HookWidget {
  const MultiRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(duration: 450.ms);
    final animate = Tween<double>(begin: 100.0, end: 200.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    final radiusAnimate = Tween<double>(begin: 4.0, end: 16.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    final flag = useObs(false, watch: (newValue, oldValue) {
      if (newValue == true) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
    final count = useObs(0);
    i('build');
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义渲染测试'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: count,
                builder: (context, value, _) {
                  return ElButton(
                    onPressed: () {
                      count.value++;
                    },
                    child: 'count: ${value}',
                  );
                },
              ),
              ElSwitch(flag),
              const Gap(8),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      runSpacing: 4,
                      spacing: 4,
                      children: [
                        ...List.generate(
                          10,
                          (index) => SizedBox(
                            width: 200,
                            height: 200,
                            child: AnimatedBuilder(
                              animation: controller,
                              builder: (context, child) {
                                return UnconstrainedBox(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        radiusAnimate.value),
                                    child: _Box(
                                      width: animate.value,
                                      height: animate.value,
                                      child: Center(
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Box extends SingleChildRenderObjectWidget {
  const _Box({
    super.child,
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

class _BoxRender extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
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
    final childConstraints = BoxConstraints.tight(size);
    child!.layout(childConstraints);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(
      offset & size,
      Paint()..color = Colors.grey,
    );
    context.paintChild(child as RenderObject, offset);
  }
}
