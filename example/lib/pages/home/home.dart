import 'package:example/global.dart';
import 'package:flutter/material.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final show = useState(true);
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
        child: SelectionArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: 40,
                padding: const EdgeInsets.only(top: 4),
                color: Colors.grey,
                child: Row(
                  children: [
                    ClipPath(
                      clipper: _Clipper(),
                      child: Container(
                        width: 200,
                        height: 36,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // ElButton(
              //   onPressed: () {
              //     show.value = !show.value;
              //   },
              //   child: '切换',
              // ),
              // HoverBuilder(builder: (context) {
              //   return const Text('hello')
              //       .animate(target: show.value ? 1 : 0)
              //       .fade(duration: 200.ms);
              // }),
              // const Gap(50),
              // TapBuilder(builder: (context) {
              //   return Container(
              //     width: 100,
              //     height: 100,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //   ).animate(target: context ? 1 : 0).scale(
              //         duration: 200.ms,
              //         curve: Curves.easeOut,
              //         begin: const Offset(1.0, 1.0),
              //         end: const Offset(0.9, 0.9),
              //       );
              // }),
            ],
          ),
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

class _Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final w = size.width;
    final h = size.height;
    double r = h / 3;
    final path = Path();
    path.moveTo(0, h);
    path.quadraticBezierTo(r, h, r, h - r);
    path.lineTo(r, r);
    path.quadraticBezierTo(r, 0, r * 2, 0);
    path.lineTo(w - r * 2, 0);
    path.quadraticBezierTo(w - r, 0, w - r, r);
    path.lineTo(w - r, h - r);
    path.quadraticBezierTo(w - r, h, w, h);
    path.cubicTo(0, size.height - r * 0.33, r * 0.33, size.height, r, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
    return true;
  }
}
