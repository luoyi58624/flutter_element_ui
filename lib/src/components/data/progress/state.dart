part of 'index.dart';

const _curve = Curves.easeOutSine;

class _ElProgressState extends State<ElProgress>
    with SingleTickerProviderStateMixin {
  /// 动画控制器
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: widget.duration,
    value: 0.0,
  );

  /// 动画曲线
  late CurvedAnimation curvedAnimation;

  late Animation<double> positionAnimation;

  double? _maxSize;

  /// 进度条最大物理尺寸
  double get maxSize => _maxSize!;

  set maxSize(double size) {
    if (_maxSize != size) {
      _maxSize = size;
      final tween = Tween(begin: -maxSize, end: maxSize);
      positionAnimation = tween.animate(curvedAnimation);
      // i(curvedAnimation.curve.transform(0.5));
      i(tween.evaluate(curvedAnimation));
    }
  }

  /// 已加载的进度物理尺寸
  late double _valueSize;

  /// 当前 [modelValue] 在最大值、最小值之间的比例
  late double _valueRatio;

  /// 边框圆角
  late BorderRadiusGeometry _borderRadius;

  void setValueRatio() {
    _valueRatio =
        max((widget.value - widget.min), 0) / (widget.max - widget.min);
  }

  void setBorderRadius() {
    _borderRadius = widget.round
        ? BorderRadius.circular(widget.size / 2)
        : widget.borderRadius;
  }

  @override
  void initState() {
    super.initState();
    setValueRatio();
    setBorderRadius();
    curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: _curve,
    );

    if (widget.indeterminate) controller.repeat();
  }

  @override
  void didUpdateWidget(covariant ElProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.indeterminate != oldWidget.indeterminate) {
      if (widget.indeterminate) {
        controller.repeat();
      } else {
        controller.stop();
      }
    }
    if (widget.duration != oldWidget.duration) {
      controller.duration = widget.duration;
    }
    if (widget.value != oldWidget.value ||
        widget.min != oldWidget.min ||
        widget.max != oldWidget.max) {
      setValueRatio();
    }
    if (widget.round != oldWidget.round ||
        widget.borderRadius != oldWidget.borderRadius) {
      setBorderRadius();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      maxSize = constraints.maxWidth;
      _valueSize = maxSize * _valueRatio;
      return ClipRRect(
        borderRadius: _borderRadius,
        child: AnimatedBuilder(
            animation: controller.view,
            child: progressWrapper,
            builder: (context, child) {
              return Stack(
                children: [
                  child!,
                  Positioned(
                    left: positionAnimation.value,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: primaryProgress,
                    ),
                  ),
                ],
              );
            }),
      );
    });
  }

  Widget get progressWrapper {
    return AnimatedContainer(
      duration: context.elThemeDuration ?? const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      height: widget.size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: widget.bgColor ?? context.elTheme.colors.borderLight,
        borderRadius: _borderRadius,
      ),
    );
  }

  Widget get primaryProgress {
    return AnimatedContainer(
      duration: context.elThemeDuration ?? const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: _valueSize,
      height: widget.size,
      decoration: BoxDecoration(
        color: widget.color ?? context.elTheme.primary,
        borderRadius: _borderRadius,
      ),
    );
  }
}
