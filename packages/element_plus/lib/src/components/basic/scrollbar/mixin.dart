part of 'index.dart';

/// Element UI 自定义滚动条实现
mixin _ElScrollbarMixin<T extends ElScrollbar>
    on SingleTickerProviderStateMixin<T> {
  late AnimationController animationController;
  late final _ScrollbarPainter scrollbarPainter;

  /// 鼠标是否进入滚动区域
  bool isHover = false;

  /// 是否处于拖拽滚动条状态
  bool isDragScroll = false;

  /// 对滚动条颜色变化进行线性插值，定义两个变量用于保存当前滚动条颜色和目标颜色
  Color? color1;
  Color? color2;

  /// 动画过程中保存的中间颜色，在短时间内快速更新动画时可以无缝衔接
  Color? lerpColor;

  /// 滚动条颜色
  Color get thumbColor => widget.thumbColor;

  /// 鼠标悬停在滚动轨道的颜色
  Color get activeColor =>
      widget.thumbActiveColor ?? thumbColor.withOpacity(0.9);

  /// 默认情况下，滚动条是处于隐藏状态，但如果开启一直显示，则固定为悬停状态
  Color get hideThumbColor => thumbColor.withOpacity(0);

  /// 对滚动条颜色进行线性插值
  Color get scrollbarColor {
    if (color1 == null || color2 == null) return hideThumbColor;
    lerpColor = Color.lerp(color1, color2, animationController.value);
    assert(lerpColor != null);
    return lerpColor!;
  }

  /// 将滚动条的一个颜色以动画形式转变成另一个颜色
  void changeColor(Color color1, Color color2) {
    this.color1 = lerpColor ?? color1;
    this.color2 = color2;
    animationController.forward(from: 0);
  }

  /// 延迟激活悬停滚动条，用户必须在滚动条上悬停一段时间，才激活滚动条高亮状态
  Timer? _delayActiveHover;

  void _cancelDelayActiveHover() {
    if (_delayActiveHover != null) {
      _delayActiveHover!.cancel();
      _delayActiveHover = null;
    }
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
      duration: const Duration(milliseconds: 200),
    )..addListener(updateScrollbarPainter);

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
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
