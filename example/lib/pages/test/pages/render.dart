import 'package:example/global.dart';
import 'package:flutter/material.dart';

class RenderTestPage extends StatefulWidget {
  const RenderTestPage({super.key});

  @override
  State<RenderTestPage> createState() => _RenderTestPageState();
}

class _RenderTestPageState extends State<RenderTestPage> {
  @override
  Widget build(BuildContext context) {
    final dx = Obs(20.0);
    final dx2 = Obs(20.0);
    final dx3 = Obs(20.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('自定义渲染测试'),
      ),
      body: Column(
        children: [
          ObsBuilder(
            builder: (context) {
              return Transform.translate(
                offset: Offset(dx.value, 200),
                child: GestureDetector(
                  onHorizontalDragUpdate: (e) {
                    dx.value += e.delta.dx;
                  },
                  child: const _Box(),
                ),
              );
            },
          ),
          ObsBuilder(
            builder: (context) {
              return Transform.translate(
                offset: Offset(dx2.value, 200),
                child: GestureDetector(
                  onHorizontalDragUpdate: (e) {
                    dx2.value += e.delta.dx;
                  },
                  child: const ColoredBox(
                    color: Colors.green,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              );
            },
          ),
          ObsBuilder(
            builder: (context) {
              return Transform.translate(
                offset: Offset(dx3.value, 200),
                child: GestureDetector(
                  onHorizontalDragUpdate: (e) {
                    dx3.value += e.delta.dx;
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blueAccent,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Box extends LeafRenderObjectWidget {
  const _Box();

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BoxRender();
  }
}

class _BoxRender extends RenderBox {
  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void performLayout() {
    size = const Size(100, 100);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(
      offset & size,
      Paint()..color = Colors.grey,
    );
  }
}
