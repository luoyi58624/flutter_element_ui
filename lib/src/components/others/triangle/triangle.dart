import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/global.dart';

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
      painter: _Painter(direction, $color, radius, onlyRightAngle),
    );
  }
}

class _Painter extends CustomPainter {
  final AxisDirection direction;
  final Color color;
  final double radius;
  final bool onlyRightAngle;

  _Painter(this.direction, this.color, this.radius, this.onlyRightAngle);

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
  bool shouldRepaint(_Painter oldDelegate) => oldDelegate != this;

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

  /// 圆角绘制，绘制逻辑可以参考 triangle_radius.png 图片
  void radiusPaint(Canvas canvas, Size size, Path path) {
    final w = size.width;
    final h = size.height;

    // 限制最大圆角值，由于需要绘制三个圆形实现三角形圆角，所以需要严格限制圆形尺寸
    final r = min(radius, min(w, h) / 3 / 2);

    // 225度圆弧坐标，此属性非常关键，它用于计算圆心的坐标、连接关键圆弧坐标点
    final arcLocation = r + r * sin((225) * pi / 180);

    late Offset c1; // 直角圆心坐标
    late Offset c2; // 对角圆心坐标 - 1
    late Offset c3; // 对角圆心坐标 - 2

    switch (direction) {
      case AxisDirection.up:
        // 直角圆心坐标系
        c1 = Offset(w / 2, r + r / 2);
        // 直角圆弧，逻辑都大致相同，不过是根据方向调整位置即可
        _RightAngle ra =
            (Rect.fromCircle(center: c1, radius: r), pi + pi / 4, pi / 2);

        // 只绘制直角圆角
        if (onlyRightAngle) {
          path.moveTo(0, h);
          path.arcTo(ra.$1, ra.$2, ra.$3, false);
          path.lineTo(w, h);
        } else {
          // 通过设计图你可以发现，两个圆的交叉距离正好是 arcLocation，由此可以得出对角圆心的 x 坐标
          c2 = Offset(r * 4 - arcLocation * 2, h - r);
          // 与上面一样，只不过是反过来
          c3 = Offset(w - (r * 4 - arcLocation * 2), h - r);

          // 以第一个对角圆心为原点，开始绘制
          path.moveTo(c2.dx, h);

          // 画出圆弧
          // * 第一个参数是圆的坐标点
          // * 第二个参数是圆弧的起始原点，从一个圆的右边开始，以顺时针开始旋转，一个 pi 指 180 度，
          // 由于我们的起始原点在圆的下方，所以绘制圆弧从 90 度开始
          // * 第三个参数是绘制的圆弧范围，和第二个参数逻辑一样，这里统一使用 _diagonalAngle 变量，
          // 它的计算公式可以参考设计图，从当前原点旋转 90 度后、再旋转 45 度达到圆的交界线
          path.arcTo(Rect.fromCircle(center: c2, radius: r), pi / 2,
              _diagonalAngle, false);

          // 绘制直角圆角
          path.arcTo(ra.$1, ra.$2, ra.$3, false);

          // 这里需要通过 arcLocation 定位到下一个对角坐标，计算方式参考设计图
          path.lineTo(c3.dx + (r - arcLocation), h - r - (r - arcLocation));

          // 绘制第二个对角圆弧，逻辑和第一个对角圆弧一样，只不过需要调整一下方位，
          // 绘制完后在最后一个节点会和起始节点自动连接起来
          path.arcTo(Rect.fromCircle(center: c3, radius: r), pi * 2 - pi / 4,
              _diagonalAngle, false);
        }
        break;
      case AxisDirection.right:
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

/// 对角圆弧
const _diagonalAngle = pi / 2 + pi / 4;
