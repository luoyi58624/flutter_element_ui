import 'dart:math';

import 'package:flutter/material.dart';

class TrianglePage extends StatelessWidget {
  const TrianglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制三角形 - triangle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: RepaintBoundary(
          child: CustomPaint(
            size: Size.infinite,
            painter: _MyPainter(),
          ),
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double s = 100;
    double r = 20;
    Paint paint = Paint()..color = Colors.green;

    Path path = Path();
    path.moveTo(r, s);
    path.arcTo(Rect.fromCircle(center: Offset(r, s - r), radius: r), pi / 4,
        pi, false);
    path.lineTo(s / 2, s / 2);
    path.lineTo(s, s);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
