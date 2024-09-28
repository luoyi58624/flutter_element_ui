part of 'index.dart';

/// 动画加载器进度条
class _AnimateLoader extends HookWidget {
  const _AnimateLoader({
    required this.duration,
    required this.curve,
  });

  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final $data = _ProgressInheritedWidget.of(context);

    final AnimationController controller = useAnimationController(
      duration: duration,
    );

    final positionRatioAnimation = Tween(
      begin: -$data.ratio,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: curve,
    ));

    useEffect(() {
      controller.repeat();
      return null;
    }, [duration]);

    double $radius = $data.round
        ? ($data.vertical ? $data.strokeSize.width : $data.strokeSize.height) /
            2
        : $data.radius;

    return ClipRRect(
      borderRadius: BorderRadius.circular($radius),
      child: AnimatedBuilder(
          animation: controller.view,
          builder: (context, child) {
            return RepaintBoundary(
              child: CustomPaint(
                size: $data.strokeSize,
                foregroundPainter: _AnimateProgressPainter(
                  ratio: $data.ratio,
                  positionRatio: positionRatioAnimation.value,
                  radius: $radius,
                  axis: $data.axis,
                  bgColor: $data.bgColor,
                  color: $data.color,
                ),
                painter: _AnimateWrapperProgressPainter($data.bgColor),
              ),
            );
          }),
    );
  }
}

class _AnimateWrapperProgressPainter extends CustomPainter {
  const _AnimateWrapperProgressPainter(this.bgColor);

  final Color bgColor;

  @override
  void paint(Canvas canvas, Size size) {
    // el.i('paint');
    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height),
      Paint()..color = bgColor,
    );
  }

  @override
  bool shouldRepaint(covariant _AnimateWrapperProgressPainter oldDelegate) {
    return false;
  }
}

class _AnimateProgressPainter extends CustomPainter {
  /// 进度条比值
  final double ratio;

  /// 进度条偏移位置比例
  final double positionRatio;

  final double radius;
  final AxisDirection axis;
  final Color bgColor;
  final Color color;

  _AnimateProgressPainter({
    required this.ratio,
    required this.positionRatio,
    required this.radius,
    required this.axis,
    required this.bgColor,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size $size) {
    Paint paint = Paint();

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
  bool shouldRepaint(covariant _AnimateProgressPainter oldDelegate) {
    return true;
  }
}
