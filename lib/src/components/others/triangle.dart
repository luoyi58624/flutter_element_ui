import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class ElTriangle extends StatelessWidget {
  /// Element UI 三角形小部件
  const ElTriangle({
    super.key,
    this.size = const Size(12, 12),
    this.direction = AxisDirection.up,
    this.color,
    this.radius = 0,
  }) : assert(radius >= 0);

  /// 三角形的尺寸
  final Size size;

  /// 三角形的方向
  final AxisDirection direction;

  /// 三角形的颜色
  final Color? color;

  /// 三角形的圆角值
  final double radius;

  @override
  Widget build(BuildContext context) {
    late double width;
    late double height;
    // 根据方向将三角形的顶点位置设置为目标的一半，解决形状过于突出问题
    switch (direction) {
      case AxisDirection.up:
      case AxisDirection.down:
        width = size.width;
        height = size.height / 2;
        break;
      case AxisDirection.left:
      case AxisDirection.right:
        width = size.width / 2;
        height = size.height;
        break;
    }
    return CustomPaint(
      size: Size(width, height),
      painter: _MyPainter(direction, color ?? context.elTheme.primary, radius),
    );
  }
}

class _MyPainter extends CustomPainter {
  final AxisDirection direction;
  final Color color;
  final double r;

  _MyPainter(this.direction, this.color, this.r);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    if (r == 0) {
      simplePaint(canvas, size, path);
    } else {
      radiusPaint(canvas, size, path);
    }

    canvas.clipPath(path);

    var rect = Offset.zero & size;
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(_MyPainter oldDelegate) => oldDelegate != this;

  /// 简单绘制
  void simplePaint(Canvas canvas, Size size, Path path) {
    final w = size.width;
    final h = size.height;
    switch (direction) {
      case AxisDirection.up:
        path.moveTo(0, h);
        path.lineTo(w / 2, 0);
        path.lineTo(w, h);
        break;
      case AxisDirection.right:
        path.moveTo(0, 0);
        path.lineTo(w, h / 2);
        path.lineTo(0, h);
        break;
      case AxisDirection.down:
        path.moveTo(0, 0);
        path.lineTo(w, 0);
        path.lineTo(w / 2, h);
        break;
      case AxisDirection.left:
        path.moveTo(w, 0);
        path.lineTo(0, h / 2);
        path.lineTo(w, h);
        break;
    }
  }

  /// 圆角绘制
  void radiusPaint(Canvas canvas, Size size, Path path) {
    final w = size.width;
    final h = size.height;
    switch (direction) {
      case AxisDirection.up:
        path.moveTo(0, 0);
        path.lineTo(20, 0);
        // path.moveTo(r, h);
        // path.quadraticBezierTo(0, h, r, h - r);
        // path.lineTo(w / 2 - r / 2, r);
        // path.quadraticBezierTo(w / 2, 0, w / 2 + r / 2, r);
        // path.lineTo(w - r, h - r);
        // path.quadraticBezierTo(w, h, w - r, h);
        break;
      case AxisDirection.right:
        path.moveTo(0, 0);
        path.lineTo(w, h / 2);
        path.lineTo(0, h);
        break;
      case AxisDirection.down:
        path.moveTo(0, 0);
        path.lineTo(w, 0);
        path.lineTo(w / 2, h);
        break;
      case AxisDirection.left:
        path.moveTo(w, 0);
        path.lineTo(0, h / 2);
        path.lineTo(w, h);
        break;
    }
  }
}
