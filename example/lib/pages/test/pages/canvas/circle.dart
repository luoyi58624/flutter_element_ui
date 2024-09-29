import 'package:flutter/material.dart';

class CirclePage extends StatelessWidget {
  const CirclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制圆 - Circle'),
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
      ..strokeWidth = 4;

    canvas.drawCircle(const Offset(100, 100), 30, paint);
    canvas.drawCircle(
        const Offset(180, 100), 30, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
