part of 'index.dart';

class _ElProgressState extends ElSingleAnimatedWidgetState<ElProgress> {
  /// 当前 [modelValue] 在最大值、最小值之间的比例
  late double valueRatio;

  void setValueRatio() {
    valueRatio =
        max((widget.value - widget.min), 0) / (widget.max - widget.min);
  }

  @override
  void initState() {
    super.initState();
    setValueRatio();
    if (widget.indeterminate) animationController.repeat();
  }

  @override
  void didUpdateWidget(covariant ElProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.indeterminate != oldWidget.indeterminate) {
      if (widget.indeterminate) {
        animationController.repeat();
      } else {
        animationController.stop();
      }
    }
    if (widget.value != oldWidget.value ||
        widget.min != oldWidget.min ||
        widget.max != oldWidget.max) {
      setValueRatio();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final $maxSize = constraints.maxWidth;
      final $valueSize = constraints.maxWidth * valueRatio;
      return AnimatedBuilder(
          animation: animationController.view,
          child: Container(
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.bgColor ?? context.elTheme.colors.borderLighter,
              borderRadius: widget.round
                  ? BorderRadius.circular(widget.size / 2)
                  : widget.borderRadius,
            ),
          ),
          builder: (context, child) {
            final $value = animationController.value;
            late double position;
            if ($value < valueRatio) {
              position = (valueRatio - $value) * -$valueSize;
            } else {
              position = ($value - valueRatio) * ($maxSize);
            }
            return Stack(
              children: [
                child!,
                Positioned(
                  left: position,
                  right: 0,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: $valueSize,
                      height: widget.size,
                      decoration: BoxDecoration(
                        color: widget.color ?? context.elTheme.primary,
                        borderRadius: widget.round
                            ? BorderRadius.circular(widget.size / 2)
                            : widget.borderRadius,
                      ),
                    ),
                  ),
                ),
              ],
            );
          });
    });
  }
}

