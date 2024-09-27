part of './index.dart';

class _LineProgressPainter extends CustomPainter {
  /// 进度条比值
  final double ratio;

  /// 进度条偏移位置比例
  final double positionRatio;

  final double radius;
  final AxisDirection axis;
  final Color bgColor;
  final Color color;

  _LineProgressPainter({
    required this.ratio,
    required this.positionRatio,
    required this.radius,
    required this.axis,
    required this.bgColor,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size $size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, 0, $size.width, $size.height),
      paint..color = bgColor,
    );

    late double $position;

    late double l;
    late double t;
    late double r;
    late double b;
    switch (axis) {
      case AxisDirection.right:
        $position = $size.width * positionRatio;
        l = $position;
        t = 0;
        r = $position + ratio * $size.width;
        b = $size.height;
        break;
      case AxisDirection.up:
        $position = $size.height * positionRatio;
        l = 0;
        t = $size.height - ($position + ratio * $size.height);
        r = $size.width;
        b = $size.height - $position;
        break;
      case AxisDirection.down:
        $position = $size.height * positionRatio;
        l = 0;
        t = $position;
        r = $size.width;
        b = $position + ratio * $size.height;
        break;
      case AxisDirection.left:
        $position = $size.width * positionRatio;
        l = $size.width - ($position + ratio * $size.width);
        t = 0;
        r = $size.width - $position;
        b = $size.height;
        break;
    }

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(l, t, r, b),
        Radius.circular(radius),
      ),
      paint..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant _LineProgressPainter oldDelegate) {
    return true;
  }
}

class _CricleProgressPainter extends CustomPainter {
  final double ratio;
  final Size strokeSize;
  final Color bgColor;
  final Color color;

  _CricleProgressPainter({
    required this.ratio,
    required this.strokeSize,
    required this.bgColor,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size $size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeSize.width;

    final value = $size.height / 2;
    Rect rect2 = Rect.fromCircle(center: Offset(value, value), radius: value);

    canvas.drawCircle(Offset(value, value), value, paint..color = bgColor);
    canvas.drawArc(
        rect2, -math.pi / 2, ratio * 2 * math.pi, false, paint..color = color);
  }

  @override
  bool shouldRepaint(covariant _CricleProgressPainter oldDelegate) {
    return true;
  }
}

class _DashboardProgressPainter extends CustomPainter {
  final double ratio;
  final Size strokeSize;
  final Color bgColor;
  final Color color;

  _DashboardProgressPainter({
    required this.ratio,
    required this.strokeSize,
    required this.bgColor,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size $size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeSize.width;

    final value = $size.height / 2;
    Rect rect2 = Rect.fromCircle(center: Offset(value, value), radius: value);

    canvas.drawArc(
        rect2, _dashboardStart, _dashboardEnd, false, paint..color = bgColor);
    canvas.drawArc(rect2, _dashboardStart, ratio * _dashboardEnd, false,
        paint..color = color);
  }

  @override
  bool shouldRepaint(covariant _DashboardProgressPainter oldDelegate) {
    return true;
  }
}

const _dashboardStart = math.pi / 2 + math.pi / 4;
const _dashboardEnd = 2 * math.pi - math.pi / 2;
