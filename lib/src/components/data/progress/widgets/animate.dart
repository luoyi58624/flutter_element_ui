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
  bool updateShouldNotify(_AnimateProgressInheritedWidget oldWidget) =>
      duration != oldWidget.duration || curve != oldWidget.curve;
}

/// 动画进度条
class _AnimateProgress extends HookWidget {
  const _AnimateProgress();

  @override
  Widget build(BuildContext context) {
    final $data = _ProgressInheritedWidget.of(context);
    final $animateData = _AnimateProgressInheritedWidget.of(context);

    final paintSize = Size($data.physicalSize, $data.size);
    final progressSize = $data.physicalSize * $data.ratio;

    final AnimationController controller = useAnimationController(
      duration: $animateData.duration,
    );

    final positionAnimation = Tween(
      begin: -progressSize,
      end: paintSize.width,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: $animateData.curve,
    ));

    final sizeAnimation = Tween(
      begin: progressSize,
      end: progressSize / 5,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
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
                size: sizeAnimation.value,
                left: positionAnimation.value,
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
  final double size;
  final double left;

  _AnimateProgressPainter({
    required this.bgColor,
    required this.color,
    required this.radius,
    required this.size,
    required this.left,
  });

  @override
  void paint(Canvas canvas, Size $size) {
    Paint paint = Paint()..style = PaintingStyle.fill;

    canvas.drawRect(
      Rect.fromLTRB(0, 0, $size.width, $size.height),
      paint..color = bgColor,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(left, 0, left + size, $size.height),
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
