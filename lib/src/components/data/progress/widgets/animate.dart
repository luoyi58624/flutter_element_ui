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

    final AnimationController controller = useAnimationController(
      duration: $animateData.duration,
    );

    final positionAnimation = Tween(
      begin: -$data.ratio,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: $animateData.curve,
    ));

    final ratioAnimation = Tween(
      begin: $data.ratio,
      end: $data.ratio / 5,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));

    useEffect(() {
      controller.repeat();
      return null;
    }, [$animateData.duration]);

    final $radius = $data.round ? $data.size / 2 : $data.radius;
    return ClipRRect(
      borderRadius: BorderRadius.circular($radius),
      child: AnimatedBuilder(
          animation: controller.view,
          builder: (context, child) {
            return CustomPaint(
              size: $data.physicalSize,
              painter: _LineProgressPainter(
                ratio: ratioAnimation.value,
                position: positionAnimation.value,
                size: $data.size,
                radius: $radius,
                vertical: false,
                bgColor: $data.bgColor,
                color: $data.color,
              ),
            );
          }),
    );
  }
}

