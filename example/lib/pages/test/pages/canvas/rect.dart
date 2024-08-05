import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class RectPage extends StatelessWidget {
  const RectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制矩形 - Rect'),
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
      ..strokeWidth = 2;

    canvas.drawRect(const Rect.fromLTRB(0, 50, 100, 0), paint);
    canvas.drawRect(const Rect.fromLTRB(0, 60, 100, 110),
        paint..style = PaintingStyle.fill);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          const Rect.fromLTRB(110, 50, 210, 0),
          const Radius.circular(8),
        ),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
