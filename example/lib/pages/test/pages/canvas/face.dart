import 'dart:math';

import 'package:flutter/material.dart';

class FacePage extends StatelessWidget {
  const FacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制笑脸'),
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
    canvas.drawCircle(const Offset(100, 50), 50, Paint()..color = Colors.green);
    canvas.drawCircle(const Offset(80, 40), 6, Paint()..color = Colors.white);
    canvas.drawCircle(const Offset(120, 40), 6, Paint()..color = Colors.white);

    canvas.drawArc(
        Rect.fromCircle(center: const Offset(100.0, 55.0), radius: 25.0),
        pi / 6,
        2 * pi / 3,
        false,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 5);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
