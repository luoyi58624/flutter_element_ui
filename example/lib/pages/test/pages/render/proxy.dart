import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';
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
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _Box(
                  child: GestureDetector(
                    onTap: () {
                      el.i('xx');
                    },
                    // child: Container(
                    //   width: 100,
                    //   height: 100,
                    //   color: Colors.grey,
                    // ),
                    child: CupertinoButton.filled(
                      child: const Text('Primary'),
                      onPressed: () {},
                    ),
                  ),
                ),
                ElButton(
                  onPressed: () {},
                  type: 'primary',
                  padding: const EdgeInsets.symmetric(
                    horizontal: 64,
                    vertical: 14,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  round: true,
                  child: const Text(
                    'Primary',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ...List.generate(100, (index) => const Text('text')),
              ],
            ),
          ),
        ),
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

// @override
// void paint(PaintingContext context, Offset offset) {
//   context.canvas.drawRect(
//     offset & size,
//     Paint()..color = Colors.green,
//   );
//   if(child!=null) child!.paint(context, offset);
// }
}
