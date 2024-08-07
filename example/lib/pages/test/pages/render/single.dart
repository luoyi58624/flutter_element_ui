import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SingleRenderTestPage extends StatefulWidget {
  const SingleRenderTestPage({super.key});

  @override
  State<SingleRenderTestPage> createState() => _SingleRenderTestPageState();
}

class _SingleRenderTestPageState extends State<SingleRenderTestPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(vsync: this, duration: 300.ms);
  late final animate = Tween<double>(begin: 200.0, end: 500.0).animate(
    CurvedAnimation(parent: controller, curve: Curves.ease),
  );
  late final flag = Obs(false, watch: (newValue, oldValue) {
    if (newValue == true) {
      controller.forward();
    } else {
      controller.reverse();
    }
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义渲染测试'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox.expand(
          child: Column(
            children: [
              ElSwitch(flag),
              const Gap(8),
              Expanded(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return _Box(
                      width: animate.value,
                      child: Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.green,
                        ),
                      ),
                    );
                  },
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
