import 'dart:math';

import 'package:example/global.dart';
import 'package:flutter/material.dart';

class PathPage extends StatelessWidget {
  const PathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制路径 - Path'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            Expanded(
              child: CustomPaint(
                size: Size.infinite,
                painter: _MyPainter(false),
              ),
            ),
            Expanded(
              child: CustomPaint(
                size: Size.infinite,
                painter: _MyPainter(true),
              ),
            ),
            Expanded(
              child: CustomPaint(
                size: Size.infinite,
                painter: _MyPainter2(),
              ),
            ),
            Expanded(
              child: UnconstrainedBox(
                child: Container(
                  width: 200,
                  height: 200,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.green,
                  ),
                  child: SelectableText(
                    Colors.green.toHex(),
                  ),
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  final bool fill;

  _MyPainter(this.fill);

  @override
  void paint(Canvas canvas, Size size) {
    double s = 200;
    double r = 20;

    Path path = Path();
    path.moveTo(r, 0);
    path.lineTo(s - r, 0);
    path.arcTo(Rect.fromCircle(center: Offset(s - r, r), radius: r), 3 * pi / 2,
        pi / 2, false);
    path.lineTo(s, s - r);
    path.arcTo(Rect.fromCircle(center: Offset(s - r, s - r), radius: r), 0,
        pi / 2, false);
    path.lineTo(r, s);
    path.arcTo(Rect.fromCircle(center: Offset(r, s - r), radius: r), pi / 2,
        pi / 2, false);
    path.lineTo(0, r);
    path.arcTo(
        Rect.fromCircle(center: Offset(r, r), radius: r), pi, pi / 2, false);
    path.lineTo(r, 0);
    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.green
          ..style = fill ? PaintingStyle.fill : PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _MyPainter2 extends CustomPainter {
  _MyPainter2();

  @override
  void paint(Canvas canvas, Size size) {
    double s = 200;
    double r = 20;

    Path path = Path();
    path.moveTo(r, 0);
    path.lineTo(s - r, 0);
    path.quadraticBezierTo(s, 0, s, r);
    path.lineTo(s, s - r);
    path.quadraticBezierTo(s, s, s - r, s);
    path.lineTo(r, s);
    path.quadraticBezierTo(0, s, 0, s - r);
    path.lineTo(0, r);
    path.quadraticBezierTo(0, 0, r, 0);
    canvas.drawPath(path, Paint()..color = Colors.green);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
