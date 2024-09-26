import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      RepaintBoundary(
        child: HoverBuilder(builder: (context) {
          return CustomPaint(
            size: const Size(100, 100),
            painter:
                _MyPainter(color: context.isHover ? Colors.green : Colors.red),
          );
        }),
      ),
      CustomPaint(
        size: const Size(100, 100),
        painter: _MyPainter2(color: context.isHover ? Colors.green : Colors.red),
      ),
      // const RepaintBoundary(
      //   child: SizedBox(
      //     width: 400,
      //     height: 200,
      //     child: ElProgress.animate(50),
      //   ),
      // ),
      RepaintBoundary(
        child: SizedBox(
          width: 100,
          height: 150,
          child: CodeExample(children: [
            ElProgress.animate(50),
          ]),
        ),
      ),
    ];
  }
}

class _MyPainter extends CustomPainter {
  final Color color;

  _MyPainter({super.repaint, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}


class _MyPainter2 extends CustomPainter {
  final Color color;

  _MyPainter2({super.repaint, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    el.i('paint2');
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
