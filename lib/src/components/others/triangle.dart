import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class ElTriangle extends StatelessWidget {
  /// Element UI 绘制三角形小部件
  const ElTriangle({
    super.key,
    this.size = 16,
    this.direction = AxisDirection.up,
    this.color,
  });

  final double size;
  final AxisDirection direction;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final $color = color ?? context.elTheme.primary;
    return RepaintBoundary(
      child: CustomPaint(
        size: Size(size, size),
        painter: _MyPainter(direction, $color),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  final AxisDirection direction;
  final Color color;

  _MyPainter(this.direction, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    print(direction);
    Path path = Path();
    switch (direction) {
      case AxisDirection.up:
        path.moveTo(0, size.height);
        path.lineTo(size.width / 2, size.height / 2);
        path.lineTo(size.width, size.height);
        break;
      case AxisDirection.right:
        path.moveTo(0, 0);
        path.lineTo(size.width / 2, size.height / 2);
        path.lineTo(0, size.height);
        break;
      case AxisDirection.down:
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);
        path.lineTo(size.width / 2, size.height / 2);
        break;
      case AxisDirection.left:
        path.moveTo(size.width, 0);
        path.lineTo(size.width / 2, size.height / 2);
        path.lineTo(size.width, size.height);
        break;
    }

    canvas.clipPath(path);

    var rect = Offset.zero & size;
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(_MyPainter oldDelegate) {
    return oldDelegate.direction != direction;
  }
}
