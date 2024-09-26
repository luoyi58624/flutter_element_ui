part of 'index.dart';

const Duration _duration = Duration(milliseconds: 200);

class ElProgressState extends State<ElProgress>
    with SingleTickerProviderStateMixin {
  /// 调整进度条当前位置动画控制器
  late final AnimationController _controller = AnimationController(vsync: this);
  late final CurvedAnimation _curvedAnimation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  /// 以动画形式更新进度条
  void setAnimateProgress(double value) {

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final $bgColor = widget.bgColor ?? context.elTheme.colors.borderLight;
    final $color = widget.color ?? context.elTheme.primary;
    final $radius = widget.round ? widget.size / 2 : widget.radius;
    final $valueRatio =
        math.max((widget.value - widget.min), 0) / (widget.max - widget.min);
    late Widget result;
    if (widget._type == _ProgressType.line) {
      result = _LineProgressInheritedWidget(widget.vertical,
          child: const _LineProgress());
    } else if (widget._type == _ProgressType.animate) {
      result = _AnimateProgressInheritedWidget(widget.duration, widget.curve,
          child: const _AnimateProgress());
    }

    return LayoutBuilder(builder: (context, constraints) {
      return _ProgressInheritedWidget(
          widget.value,
          widget.min,
          widget.max,
          widget.size,
          widget.round,
          $radius,
          $color,
          $bgColor,
          $valueRatio,
          constraints.maxWidth,
          child: result);
    });
  }
}

class _ProgressInheritedWidget extends InheritedWidget {
  const _ProgressInheritedWidget(
    this.value,
    this.min,
    this.max,
    this.size,
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
  final bool round;
  final double radius;
  final Color color;
  final Color bgColor;

  /// [value] 在 [min] 和 [max] 之间的比例
  final double ratio;

  /// 进度条整体所占据的物理尺寸
  final double physicalSize;

  static _ProgressInheritedWidget of(BuildContext context) {
    final _ProgressInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ProgressInheritedWidget>();
    assert(result != null, 'No _ProgressInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ProgressInheritedWidget oldWidget) =>
      value != oldWidget.value ||
      min != oldWidget.min ||
      max != oldWidget.max ||
      round != oldWidget.round ||
      radius != oldWidget.radius ||
      color != oldWidget.color ||
      bgColor != oldWidget.bgColor;
}
