import 'dart:math';

import 'package:flutter/material.dart';

class ArcPage extends StatelessWidget {
  const ArcPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制圆弧 - Arc'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: CustomPaint(
          size: Size.infinite,
          painter: _MyPainter(),
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    Rect rect2 =
        Rect.fromCircle(center: const Offset(100.0, 100.0), radius: 40.0);
    canvas.drawArc(rect2, pi / 6, 2 * pi / 3, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
