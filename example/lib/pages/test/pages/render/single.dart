import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SingleRenderTestPage extends HookWidget {
  const SingleRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    double maxSize = 50;
    final controller = useAnimationController(duration: 450.ms);
    final animate = Tween<double>(begin: 30.0, end: maxSize).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    final radiusAnimate = Tween<double>(begin: 4.0, end: 8.0).animate(
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义渲染单节点'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
          child: Column(
            children: [
              const Gap(16),
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
                          1000,
                          (index) => SizedBox(
                            width: maxSize,
                            height: maxSize,
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
                                      // child: Center(
                                      //   child: Container(
                                      //     width: 24,
                                      //     height: 24,
                                      //     color: Colors.green,
                                      //   ),
                                      // ),
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
    if (child != null) {
      final childConstraints = BoxConstraints.tight(size);
      child!.layout(childConstraints);
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(
      offset & size,
      Paint()..color = Colors.grey,
    );
    if (child != null) {
      context.paintChild(child as RenderObject, offset);
    }
  }
}
