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
            return CustomPaint(
              size: $data.strokeSize,
              painter: _LineProgressPainter(
                ratio: $data.ratio,
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
