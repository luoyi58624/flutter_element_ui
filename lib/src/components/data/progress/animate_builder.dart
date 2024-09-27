part of 'index.dart';

typedef _ProgressAnimateBuilder = Widget Function(
  double ratio,
  Size strokeSize,
  Color color,
);

/// 通用的进度条动画构建器
class _AnimateBuilder extends StatefulWidget {
  const _AnimateBuilder({
    required this.ratio,
    required this.strokeSize,
    required this.color,
    required this.axis,
    required this.duration,
    required this.curve,
    required this.builder,
  });

  final double ratio;
  final Size strokeSize;
  final Color color;
  final AxisDirection axis;
  final Duration duration;
  final Curve curve;
  final _ProgressAnimateBuilder builder;

  @override
  State<_AnimateBuilder> createState() => _AnimateBuilderState();
}

class _AnimateBuilderState extends State<_AnimateBuilder>
    with TickerProviderStateMixin {
  /// 进度条外观动画控制器
  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late CurvedAnimation curve = CurvedAnimation(
    parent: controller,
    curve: Curves.linear,
  );
  late Animation<Size?> strokeSizeAnimate;
  late Animation<Color?> colorAnimate;

  /// 进度条更新比例动画控制器
  late AnimationController ratioController = AnimationController(
    vsync: this,
    duration: widget.duration,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        ratioAnimate = Tween(
          begin: widget.ratio,
          end: widget.ratio,
        ).animate(ratioCurve);
      }
    });
  late CurvedAnimation ratioCurve = CurvedAnimation(
    parent: ratioController,
    curve: widget.curve,
  );
  late Animation<double> ratioAnimate;

  bool _execAnimate = false;
  bool _execRatioAnimate = false;

  @override
  void initState() {
    super.initState();
    strokeSizeAnimate = SizeTween(
      begin: widget.strokeSize,
      end: widget.strokeSize,
    ).animate(curve);
    colorAnimate = ColorTween(
      begin: widget.color,
      end: widget.color,
    ).animate(curve);
    ratioAnimate = Tween(
      begin: widget.ratio,
      end: widget.ratio,
    ).animate(ratioCurve);
  }

  @override
  void didUpdateWidget(covariant _AnimateBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      ratioController.duration = widget.duration;
    }
    if (widget.curve != oldWidget.curve) {
      ratioCurve = CurvedAnimation(
        parent: ratioController,
        curve: widget.curve,
      );
      ratioAnimate = Tween(
        begin: ratioAnimate.value,
        end: widget.ratio,
      ).animate(ratioCurve);
    }
    if (widget.strokeSize != oldWidget.strokeSize) {
      strokeSizeAnimate = Tween(
        // 如果是更改进度条方向引起的尺寸变化，那么不能应用动画，因为进度条尺寸约束为无限大，
        // 虽然 LayoutBuilder 可以解决此问题，但它会导致重绘溢出问题，性能会降低 50%
        begin: widget.axis == oldWidget.axis
            ? strokeSizeAnimate.value
            : widget.strokeSize,
        end: widget.strokeSize,
      ).animate(curve);
      _execAnimate = true;
    }
    if (widget.color != oldWidget.color) {
      colorAnimate = ColorTween(
        begin: colorAnimate.value,
        end: widget.color,
      ).animate(curve);
      _execAnimate = true;
    }
    if (widget.ratio != oldWidget.ratio) {
      ratioAnimate = Tween(
        begin: ratioAnimate.value,
        end: widget.ratio,
      ).animate(ratioCurve);
      _execRatioAnimate = true;
    }
    if (_execAnimate) {
      _execAnimate = false;
      controller.forward(from: 0);
    }
    if (_execRatioAnimate) {
      _execRatioAnimate = false;
      ratioController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    controller.dispose;
    ratioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: Listenable.merge([controller.view, ratioController.view]),
        builder: (context, child) {
          return widget.builder(
            ratioAnimate.value,
            strokeSizeAnimate.value!,
            colorAnimate.value!,
          );
        });
  }
}
