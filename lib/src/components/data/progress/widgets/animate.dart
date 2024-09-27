part of '../index.dart';

class _AnimateProgressInheritedWidget extends InheritedWidget {
  const _AnimateProgressInheritedWidget(
    this.duration, {
    required super.child,
  });

  final Duration duration;

  static _AnimateProgressInheritedWidget of(BuildContext context) {
    final _AnimateProgressInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_AnimateProgressInheritedWidget>();
    assert(
        result != null, 'No _AnimateProgressInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_AnimateProgressInheritedWidget oldWidget) =>
      duration != oldWidget.duration;
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

    final positionRatioAnimation = Tween(
      begin: -$data.ratio,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeOutSine,
    ));

    final ratioAnimation = Tween(
      begin: $data.ratio,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    ));

    useEffect(() {
      controller.repeat();
      return null;
    }, [$animateData.duration]);

    double $radius = $data.round
        ? ($data.vertical ? $data.size.width : $data.size.height) / 2
        : $data.radius;

    return ClipRRect(
      borderRadius: BorderRadius.circular($radius),
      child: AnimatedBuilder(
          animation: controller.view,
          builder: (context, child) {
            return CustomPaint(
              size: $data.size,
              painter: _LineProgressPainter(
                ratio: ratioAnimation.value,
                positionRatio: positionRatioAnimation.value,
                radius: $radius,
                axis: $data.axis,
                bgColor: $data.bgColor,
                color: $data.color,
              ),
            );
          }),
    );
  }
}
