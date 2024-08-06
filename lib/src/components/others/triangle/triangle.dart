import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class ElTriangle extends StatelessWidget {
  /// Element UI 三角形小部件
  const ElTriangle({
    super.key,
    this.size = 12,
    this.direction = AxisDirection.up,
    this.color,
    this.radius = 0,
    this.onlyRightAngle = false,
  }) : assert(radius >= 0);

  /// 三角形的尺寸
  final double size;

  /// 三角形的方向
  final AxisDirection direction;

  /// 三角形的颜色
  final Color? color;

  /// 三角形的圆角值
  final double radius;

  /// 是否只对直角进行圆角化
  final bool onlyRightAngle;

  @override
  Widget build(BuildContext context) {
    late double width;
    late double height;
    // 根据方向将三角形的顶点位置设置为目标的一半，这样才能渲染成等边直角三角形
    switch (direction) {
      case AxisDirection.up:
      case AxisDirection.down:
        width = size;
        height = size / 2;
        break;
      case AxisDirection.left:
      case AxisDirection.right:
        width = size / 2;
        height = size;
        break;
    }
    final $color = color ?? context.elTheme.primary;
    return CustomPaint(
      size: Size(width, height),
      painter: _MyPainter(direction, $color, radius, onlyRightAngle),
    );
  }
}

class _MyPainter extends CustomPainter {
  final AxisDirection direction;
  final Color color;
  final double radius;
  final bool onlyRightAngle;

  _MyPainter(this.direction, this.color, this.radius, this.onlyRightAngle);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    if (radius == 0) {
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
    final r = min(radius, min(w, h) / 3 / 2);

    // 根据圆的半径，获取225度的左上角的坐标所在位置
    final arcLocation = r + r * sin((225) * pi / 180);

    late Offset c1; // 直角圆心坐标
    late Offset c2; // 对角圆心坐标 - 1
    late Offset c3; // 对角圆心坐标 - 2

    switch (direction) {
      case AxisDirection.up:
        // 计算直角
        c1 = Offset(w / 2, r + r / 2);
        _RightAngle ra =
            (Rect.fromCircle(center: c1, radius: r), pi + pi / 4, pi / 2);

        if (onlyRightAngle) {
          path.moveTo(0, h);
          path.arcTo(ra.$1, ra.$2, ra.$3, false);
          path.lineTo(w, h);
        } else {
          c2 = Offset(r * 4 - arcLocation * 2, h - r);
          c3 = Offset(w - (r * 4 - arcLocation * 2), h - r);

          // 计算第一个对角
          path.moveTo(c2.dx, h);
          path.arcTo(Rect.fromCircle(center: c2, radius: r), pi / 2,
              _diagonalAngle, false);

          path.arcTo(ra.$1, ra.$2, ra.$3, false);

          // 计算第二个对角
          path.lineTo(c3.dx + (r - arcLocation), h - r - (r - arcLocation));
          path.arcTo(Rect.fromCircle(center: c3, radius: r), pi * 2 - pi / 4,
              _diagonalAngle, false);
        }
        break;
      case AxisDirection.right:
        // 计算直角
        c1 = Offset(w - r - r / 2, h / 2);
        _RightAngle ra =
            (Rect.fromCircle(center: c1, radius: r), pi + pi / 4 * 3, pi / 2);
        if (onlyRightAngle) {
          path.moveTo(0, 0);
          path.arcTo(ra.$1, ra.$2, ra.$3, false);
          path.lineTo(0, h);
        } else {
          c2 = Offset(r, r * 4 - arcLocation * 2);
          c3 = Offset(r, h - (r * 4 - arcLocation * 2));

          path.moveTo(0, c2.dy);
          path.arcTo(Rect.fromCircle(center: c2, radius: r), pi, _diagonalAngle,
              false);

          path.arcTo(ra.$1, ra.$2, ra.$3, false);

          path.lineTo(c3.dx + (r - arcLocation), c3.dy + (r - arcLocation));
          path.arcTo(
              Rect.fromCircle(center: c3, radius: r), 0, _diagonalAngle, false);
        }
        break;
      case AxisDirection.down:
        c1 = Offset(w / 2, h - r - r / 2);
        _RightAngle ra =
            (Rect.fromCircle(center: c1, radius: r), pi / 4, pi / 2);
        if (onlyRightAngle) {
          path.moveTo(0, 0);
          path.lineTo(w, 0);
          path.arcTo(ra.$1, ra.$2, ra.$3, false);
        } else {
          c2 = Offset(r * 4 - arcLocation * 2, r);
          c3 = Offset(w - (r * 4 - arcLocation * 2), r);

          path.moveTo(c2.dx - (r - arcLocation), r + (r - arcLocation));
          path.arcTo(Rect.fromCircle(center: c2, radius: r), pi / 2 + pi / 4,
              _diagonalAngle, false);

          path.lineTo(c3.dx + (r - arcLocation), 0);
          path.arcTo(Rect.fromCircle(center: c3, radius: r), pi + pi / 2,
              _diagonalAngle, false);

          path.arcTo(ra.$1, ra.$2, ra.$3, false);
        }

        break;
      case AxisDirection.left:
        c1 = Offset(r + r / 2, h / 2);
        _RightAngle ra =
            (Rect.fromCircle(center: c1, radius: r), pi / 2 + pi / 4, pi / 2);
        if (onlyRightAngle) {
          path.moveTo(w, 0);
          path.lineTo(w, h);
          path.arcTo(ra.$1, ra.$2, ra.$3, false);
        } else {
          c2 = Offset(w - r, r * 4 - arcLocation * 2);
          c3 = Offset(w - r, h - (r * 4 - arcLocation * 2));

          path.moveTo(c2.dx - (r - arcLocation), c2.dy - (r - arcLocation));
          path.arcTo(Rect.fromCircle(center: c2, radius: r), pi + pi / 4,
              _diagonalAngle, false);

          path.lineTo(w, c3.dy);
          path.arcTo(
              Rect.fromCircle(center: c3, radius: r), 0, _diagonalAngle, false);

          path.arcTo(ra.$1, ra.$2, ra.$3, false);
        }
        break;
    }
  }
}

typedef _RightAngle = (Rect rect, double startAngle, double sweepAngle);

/// 对角角度
const _diagonalAngle = pi / 2 + pi / 4;
