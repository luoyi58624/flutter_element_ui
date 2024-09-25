part of '../index.dart';

class _AnimateProgressInheritedWidget extends InheritedWidget {
  const _AnimateProgressInheritedWidget(
    this.duration,
    this.curve,
    this.secondCurve, {
    required super.child,
  });

  final Duration duration;
  final Curve curve;
  final Curve secondCurve;

  static _AnimateProgressInheritedWidget of(BuildContext context) {
    final _AnimateProgressInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_AnimateProgressInheritedWidget>();
    assert(
        result != null, 'No _AnimateProgressInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_AnimateProgressInheritedWidget oldWidget) =>
      duration != oldWidget.duration ||
      curve != oldWidget.curve ||
      secondCurve != oldWidget.secondCurve;
}

/// 直线动画进度条
class _AnimateProgress extends HookWidget {
  const _AnimateProgress();

  @override
  Widget build(BuildContext context) {
    final $data = _ProgressInheritedWidget.of(context);
    final $animateData = _AnimateProgressInheritedWidget.of(context);

    final paintSize = Size($data.physicalSize, $data.size);
    final progressSize = $data.physicalSize * $data.ratio;

    final AnimationController controller = useAnimationController(
      duration: $animateData.duration * 2,
    );

    final positionTween = Tween(
      begin: -progressSize,
      end: paintSize.width,
    );
    final positionAnimation1 = positionTween.animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.0, 0.5, curve: $animateData.curve),
    ));
    final positionAnimation2 = positionTween.animate(CurvedAnimation(
      parent: controller,
      curve: Interval(0.5, 1.0, curve: $animateData.secondCurve),
    ));

    final sizeAnimation1 = Tween(
      begin: progressSize,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
    ));

    useEffect(() {
      controller.repeat();
      return null;
    }, [$animateData.duration]);

    return ClipRRect(
      borderRadius: BorderRadius.circular($data.radius),
      child: AnimatedBuilder(
          animation: controller.view,
          builder: (context, child) {
            return CustomPaint(
              size: paintSize,
              painter: _AnimateProgressPainter(
                bgColor: $data.bgColor,
                color: $data.color,
                radius: $data.radius,
                size1: sizeAnimation1.value,
                left1: positionAnimation1.value,
                size2: progressSize,
                left2: positionAnimation2.value,
              ),
            );
          }),
    );
  }
}

class _AnimateProgressPainter extends CustomPainter {
  final Color bgColor;
  final Color color;
  final double radius;
  final double size1;
  final double left1;
  final double size2;
  final double left2;

  _AnimateProgressPainter({
    required this.bgColor,
    required this.color,
    required this.radius,
    required this.size1,
    required this.left1,
    required this.size2,
    required this.left2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, 0, size.width, size.height),
      paint..color = bgColor,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(left1, 0, left1 + size1, size.height),
        Radius.circular(radius),
      ),
      paint..color = color,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(left2, 0, left2 + size2, size.height),
        Radius.circular(radius),
      ),
      paint..color = color,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
