import 'package:flutter/material.dart';

class ElTriangle extends StatelessWidget {
  /// Element UI 绘制三角形小部件
  const ElTriangle({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(16, 16),
      painter: _MyPainter(),
      // child: Container(
      //   width: 100,
      //   height: 100,
      //   color: Colors.grey,
      // ),
    );
  }
}

class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = const Color(0xFFDCC48C);
    canvas.drawRect(rect, paint);

    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 2);
    path.lineTo(size.width, size.height);

    canvas.clipPath(path);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
