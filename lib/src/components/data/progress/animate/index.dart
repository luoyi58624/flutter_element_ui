part of '../index.dart';

class _AnimateProgressInheritedWidget extends InheritedWidget {
  const _AnimateProgressInheritedWidget(
    this.duration,
    this.curve, {
    required super.child,
  });

  final Duration duration;
  final Curve curve;

  static _AnimateProgressInheritedWidget of(BuildContext context) {
    final _AnimateProgressInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_AnimateProgressInheritedWidget>();
    assert(
        result != null, 'No _AnimateProgressInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_AnimateProgressInheritedWidget oldWidget) => true;
}

/// 直线动画进度条
class _AnimateProgress extends HookWidget {
  const _AnimateProgress();

  @override
  Widget build(BuildContext context) {
    final $data = _ProgressInheritedWidget.of(context);
    final $animateData = _AnimateProgressInheritedWidget.of(context);

    final AnimationController controller = useAnimationController(
      duration: $animateData.duration,
    );
    CurvedAnimation curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: $animateData.curve,
    );

    useEffect(() {
      controller.repeat();
      return null;
    }, [$animateData.duration]);

    final tween = Tween(begin: -$data.physicalSize, end: $data.physicalSize);
    final positionAnimation = tween.animate(curvedAnimation);
    final paintSize = Size(double.infinity, $data.size);
    final progressSize = $data.physicalSize * $data.ratio;
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
                width: progressSize,
                left: positionAnimation.value,
                radius: $data.radius,
              ),
            );
          }),
    );
  }
}

class _AnimateProgressPainter extends CustomPainter {
  final Color bgColor;
  final Color color;
  final double width;
  final double left;
  final double radius;

  _AnimateProgressPainter({
    required this.bgColor,
    required this.color,
    required this.width,
    required this.left,
    required this.radius,
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
        Rect.fromLTRB(left, 0, left + width, size.height),
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
