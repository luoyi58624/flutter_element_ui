import 'dart:math';

import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      CustomPaint(
        size: Size(300, 300),
        painter: _CricleProgressPainter(),
      ),
    ];
  }
}

class _CricleProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size $size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 6;

    final value = $size.height / 2;
    Rect rect2 = Rect.fromCircle(center: Offset(value, value), radius: value);

    canvas.drawCircle(
        Offset(value, value), value, paint..color = Colors.grey.shade300);
    canvas.drawArc(rect2, -pi / 2, pi, false, paint..color = Colors.green);
  }

  @override
  bool shouldRepaint(covariant _CricleProgressPainter oldDelegate) {
    return true;
  }
}
