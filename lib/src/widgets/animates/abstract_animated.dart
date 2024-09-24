import 'package:flutter/widgets.dart';

/// ```dart
/// class Example extends ElSingleAnimatedWidget {
///   const Example({super.key});
///
///   @override
///   State<Example> createState() => _ExampleState();
/// }
///
/// class _ExampleState extends ElSingleAnimatedWidgetState<Example> {
///   @override
///   Widget build(BuildContext context) {
///     return const Placeholder();
///   }
/// }
/// ```
abstract class ElSingleAnimatedWidget extends StatefulWidget {
  /// 简单封装单个动画控制器的初始化
  const ElSingleAnimatedWidget({
    super.key,
    this.duration = Duration.zero,
    this.curve = Curves.linear,
    this.initialValue = 0.0,
    this.min = 0.0,
    this.max = 1.0,
  });

  /// 动画持续时间
  final Duration duration;

  /// 动画曲线
  final Curve curve;

  /// 当前动画初始值
  final double initialValue;

  /// 当前动画最小值
  final double min;

  /// 当前动画最大值
  final double max;

  @override
  State<ElSingleAnimatedWidget> createState();
}

abstract class ElSingleAnimatedWidgetState<T extends ElSingleAnimatedWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  /// 动画控制器
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: widget.duration,
    value: widget.initialValue,
    lowerBound: widget.min,
    upperBound: widget.max,
  );

  /// 动画曲线
  late CurvedAnimation curvedAnimation;

  double get animationValue => widget.initialValue;

  double get animationMin => widget.min;

  double get animationMax => widget.max;

  void _setCurvedAnimation() {
    curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: widget.curve,
    );
  }

  @override
  void initState() {
    super.initState();
    curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: widget.curve,
    );
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      animationController.duration = widget.duration;
    }
    if (widget.curve != oldWidget.curve) {
      _setCurvedAnimation();
    }
    if (widget.initialValue != oldWidget.initialValue) {
      animationController.value = widget.initialValue;
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
