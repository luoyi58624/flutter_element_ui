import 'package:example/global.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final direction = useState(AxisDirection.up);
    final slider = Obs(20.0);
    final slider2 = useState(20.0);
    final slider3 = useObs(0.0);
    final slider4 = Obs(120.0);
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
        actions: [
          if (context.sm)
            ObsBuilder(builder: (context) {
              return Switch(
                value: GlobalState.isDark.value,
                onChanged: (v) => GlobalState.isDark.value = v,
              );
            }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ObsBuilder(builder: (context) {
            //   return ElSlider2(
            //     value: slider4.value,
            //     onChanged: (v) => slider4.value = v,
            //   );
            // }),
            // ElButton(
            //   onPressed: () {
            //     switch (direction.value) {
            //       case AxisDirection.up:
            //         direction.value = AxisDirection.right;
            //         break;
            //       case AxisDirection.right:
            //         direction.value = AxisDirection.down;
            //         break;
            //       case AxisDirection.down:
            //         direction.value = AxisDirection.left;
            //         break;
            //       case AxisDirection.left:
            //         direction.value = AxisDirection.up;
            //         break;
            //     }
            //   },
            //   child: '${direction.value}',
            // ),
            // RepaintBoundary(
            //   child: ElevatedButton(
            //     onPressed: () {},
            //     child: const Text('button'),
            //   ),
            // ),
            // const Gap(16),
            // ElTriangle(
            //   direction: direction.value,
            // ),
            // const Row(
            //   children: [
            //     ElTriangle(direction: AxisDirection.up),
            //     ElTriangle(direction: AxisDirection.right),
            //     ElTriangle(direction: AxisDirection.down),
            //     ElTriangle(direction: AxisDirection.left),
            //   ],
            // ),
            // _Box(),
            // ElSlider(slider),
            // ObsBuilder(builder: (context) {
            //   return Slider(
            //     value: slider3.value,
            //     max: 100,
            //     onChanged: (v) {
            //       slider3.value = v;
            //     },
            //   );
            // }),
            // GestureDetector(
            //   onHorizontalDragUpdate: (e) {
            //     i(e.delta.dx);
            //     slider2.value += e.delta.dx;
            //   },
            //   child: Container(
            //     width: double.infinity,
            //     height: 100,
            //     color: Colors.grey,
            //     child: Transform.translate(
            //       offset: Offset(slider2.value, 0),
            //       child: UnconstrainedBox(
            //         child: Container(
            //           width: 50,
            //           height: 50,
            //           color: Colors.green,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class _Box extends LeafRenderObjectWidget {
  @override
  RenderObject createRenderObject(BuildContext context) {
    return _BoxRender();
  }
}

class _BoxRender extends RenderBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.lightBlue;
    context.canvas.drawRect(offset & const Size(100, 100), paint);
  }

  @override
  void performLayout() {
    size = const Size(100, 200);
  }
}
