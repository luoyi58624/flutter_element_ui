part of 'index.dart';

const int _animationDuration = 200;

/// Element UI 自定义滚动条实现
mixin _ElScrollbarMixin<T extends ElScrollbar>
    on SingleTickerProviderStateMixin<T> {
  late AnimationController animationController;
  late final _ScrollbarPainter scrollbarPainter;

  /// 鼠标是否进入滚动区域
  bool isHover = false;

  /// 是否处于拖拽滚动条状态
  bool isDragScroll = false;

  /// 转变前颜色
  Color? color1;

  /// 转变后颜色
  Color? color2;

  /// [color1]、[color2] 动画过程中的中间颜色
  Color? lerpColor;

  /// 默认情况下，滚动条是处于隐藏状态，但如果开启一直显示，则固定为悬停状态
  Color get defaultThumbColor => widget.mode == ElScrollbarMode.hover ||
          widget.mode == ElScrollbarMode.onlyScrolling
      ? widget.thumbColor.withOpacity(0)
      : widget.thumbColor;

  /// 对滚动条颜色进行线性插值
  Color get scrollbarColor {
    if (color1 == null || color2 == null) return defaultThumbColor;
    lerpColor = Color.lerp(color1, color2!, animationController.value)!;
    return lerpColor!;
  }

  /// 将滚动条的一个颜色以动画形式转变成另一个颜色，第一个颜色可以为 null
  void changeColor(Color? color1, Color color2) {
    this.color1 = lerpColor ?? color1 ?? defaultThumbColor;
    this.color2 = color2;
    animationController.forward(from: 0);
  }

  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = scrollbarColor
      ..trackRadius = widget.trackRadius
      ..trackColor = widget.showTrack
          ? (widget.trackColor ??
              (context.isDark ? Colors.black : Colors.white))
          : Colors.transparent
      ..trackBorderColor = widget.showTrack
          ? (widget.trackBorderColor ??
              (context.isDark ? Colors.black : Colors.white))
          : Colors.transparent
      ..textDirection = Directionality.of(context)
      ..thickness = widget.thickness
      ..radius = widget.radius
      ..mainAxisMargin = widget.mainAxisMargin
      ..shape = widget.shape
      ..crossAxisMargin = widget.crossAxisMargin
      ..minLength = widget.minThumbLength
      ..ignorePointer = !widget.interactive;
  }

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: _animationDuration),
    )
      ..addListener(updateScrollbarPainter)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          lerpColor = null;
        }
      });

    scrollbarPainter = _ScrollbarPainter(
      color: scrollbarColor,
      trackColor: widget.showTrack
          ? (widget.trackColor ??
              (context.isDark ? Colors.black : Colors.white))
          : Colors.transparent,
      trackBorderColor: widget.showTrack
          ? (widget.trackBorderColor ??
              (context.isDark ? Colors.black : Colors.white))
          : Colors.transparent,
      thickness: widget.thickness,
      radius: widget.radius,
      trackRadius: widget.trackRadius,
      mainAxisMargin: widget.mainAxisMargin,
      shape: widget.shape,
      crossAxisMargin: widget.crossAxisMargin,
      minLength: widget.minThumbLength,
    );
  }

  @override
  void didUpdateWidget(covariant oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mode != oldWidget.mode) {
      if (widget.mode == ElScrollbarMode.always) {
        color1 = null;
        color2 = null;
      }
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
