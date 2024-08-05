import 'package:flutter/material.dart';

class LinePage extends StatelessWidget {
  const LinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('绘制线 - Line'),
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

    canvas.drawLine(Offset.zero, const Offset(100, 0), paint);
    canvas.drawLine(const Offset(300, 0), const Offset(100, 100), paint);
    canvas.drawLine(const Offset(300, 140), const Offset(0, 100), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
