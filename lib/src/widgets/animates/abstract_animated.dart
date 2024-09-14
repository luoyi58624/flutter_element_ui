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
  });

  final Duration duration;
  final Curve curve;

  @override
  State<ElSingleAnimatedWidget> createState();
}

abstract class ElSingleAnimatedWidgetState<T extends ElSingleAnimatedWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  /// 动画控制器
  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: widget.duration,
  );

  /// 动画曲线
  late CurvedAnimation curvedAnimation;

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
      curvedAnimation = CurvedAnimation(
        parent: animationController,
        curve: widget.curve,
      );
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
