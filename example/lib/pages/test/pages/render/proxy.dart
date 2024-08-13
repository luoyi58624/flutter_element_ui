import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProxyRenderTestPage extends StatelessWidget {
  const ProxyRenderTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProxyRender'),
      ),
      body: Column(
        children: [
          _Box(
            child: Container(
              width: 100,
              height: 100,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

class _Box extends SingleChildRenderObjectWidget {
  const _Box({super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BoxRender();
  }
}

class _BoxRender extends RenderProxyBox {
  _BoxRender();

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void performLayout() {
    // size = const Size(100, 100);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(
      offset & size,
      Paint()..color = Colors.grey,
    );
  }
}
