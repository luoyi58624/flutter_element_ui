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
      curve: Curves.easeOutSine,
    );

    useEffect(() {
      controller.repeat();
      return null;
    }, [$animateData.duration]);
    el.i('build');
    return LayoutBuilder(builder: (context, constraints) {
      final $maxSize = constraints.maxWidth;
      final tween = Tween(begin: -$maxSize, end: $maxSize);
      final positionAnimation = tween.animate(curvedAnimation);
      return ClipRRect(
        borderRadius: $data.borderRadius,
        child: AnimatedBuilder(
            animation: controller.view,
            builder: (context, child) {
              return Stack(
                children: [
                  const _LineWrapperWidget(),
                  Positioned(
                    left: positionAnimation.value,
                    child: const _LineProgressWidget(),
                  ),
                ],
              );
            }),
      );
    });
  }
}
