part of 'index.dart';

const Duration _duration = Duration(milliseconds: 200);

class _ProgressInheritedWidget extends InheritedWidget {
  const _ProgressInheritedWidget(
    this.value,
    this.min,
    this.max,
    this.size,
    this.boxSize,
    this.round,
    this.radius,
    this.color,
    this.bgColor,
    this.ratio,
    this.physicalSize, {
    required super.child,
  });

  final double value;
  final double min;
  final double max;
  final double size;
  final double boxSize;
  final bool round;
  final double radius;
  final Color color;
  final Color bgColor;

  /// [value] 在 [min] 和 [max] 之间的比例
  final double ratio;

  /// 进度条整体所占据的物理尺寸
  final Size physicalSize;

  static _ProgressInheritedWidget of(BuildContext context) {
    final _ProgressInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ProgressInheritedWidget>();
    assert(result != null, 'No _ProgressInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ProgressInheritedWidget oldWidget) => true;
}

class ElProgressState extends State<ElProgress> {
  // /// 进度条动画控制器
  // late final AnimationController _controller = AnimationController(vsync: this);
  // late final CurvedAnimation _curvedAnimation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.easeOut,
  // );
  //
  // @override
  // void dispose() {
  //   // _controller.dispose();
  //   super.dispose();
  // }

  /// 以动画形式更新进度条
  void setAnimateProgress(double value) {}

  @override
  Widget build(BuildContext context) {
    final $bgColor = widget.bgColor ?? context.elTheme.colors.borderLight;
    final $color = widget.color ?? context.elTheme.primary;

    final $valueRatio =
        math.max((widget.value - widget.min), 0) / (widget.max - widget.min);

    late Widget result;
    if (widget._type == _ProgressType.line) {
      result = _LineProgress(
        value: $valueRatio,
        size: widget.size,
        color: $color,
        vertical: widget.vertical,
        disabledAnimate: widget.disabledAnimate,
      );
    } else if (widget._type == _ProgressType.animate) {
      result = _AnimateProgressInheritedWidget(widget.duration, widget.curve,
          child: const _AnimateProgress());
    }

    return LayoutBuilder(builder: (context, constraints) {
      late Size physicalSize;
      if (widget.vertical) {
        physicalSize = Size(widget.size, constraints.maxHeight);
      } else {
        physicalSize = Size(constraints.maxWidth, widget.size);
      }
      return UnconstrainedBox(
        child: SizedBox(
          width: widget.vertical ? widget.boxSize : physicalSize.width,
          height: widget.vertical ? physicalSize.height : widget.boxSize,
          child: Center(
            child: _ProgressInheritedWidget(
              widget.value,
              widget.min,
              widget.max,
              widget.size,
              widget.boxSize,
              widget.round,
              widget.radius,
              $color,
              $bgColor,
              $valueRatio,
              physicalSize,
              child: result,
            ),
          ),
        ),
      );
    });
  }
}
