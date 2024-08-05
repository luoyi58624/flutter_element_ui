import 'dart:ui';

import 'package:flutter/material.dart';

class PointPage extends StatelessWidget {
  const PointPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制点 - Point'),
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
    Paint paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;

    canvas.drawPoints(
        PointMode.points,
        const [
          Offset(20.0, 130.0),
          Offset(100.0, 210.0),
          Offset(100.0, 310.0),
          Offset(200.0, 310.0),
          Offset(200.0, 210.0),
          Offset(280.0, 130.0),
          Offset(20.0, 130.0),
        ],
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
