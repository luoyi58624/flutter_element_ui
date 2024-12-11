part of 'index.dart';

class ElButton2 extends ElRawButton {
  const ElButton2({
    super.key,
    required super.child,
    super.duration,
    super.curve,
    super.type,
    this.bgColor,
    this.width,
    this.height,
    this.iconSize,
    this.leftIcon,
    this.rightIcon,
    this.round = false,
    this.block = false,
    this.padding,
    super.textStyle,
    super.autofocus,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  /// 自定义颜色按钮，它会覆盖 [type] 属性
  final Color? bgColor;

  /// 按钮宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 自定义图标尺寸
  final double? iconSize;

  /// 按钮左图标
  final Widget? leftIcon;

  /// 按钮右图标
  final Widget? rightIcon;

  /// 圆角按钮
  final bool round;

  /// 块级按钮，宽度会充满容器，其原理只是移除 [UnconstrainedBox] 小部件
  final bool block;

  /// 自定义按钮内边距
  final EdgeInsets? padding;

  @override
  State<ElRawButton> createState() => ElButton2State();
}

class ElButton2State<T extends ElButton2> extends ElRawButtonState<T> {
  bool get isIconChild => widget.child is ElIcon;

  @override
  Color calcBgColor(BuildContext context, Color color) {
    return context.hasTap
        ? color.elLight3(context, reverse: true)
        : context.hasHover
            ? color.elLight3(context)
            : color;
  }

  @override
  Color calcTextColor(BuildContext context, Color color) {
    return color.elTextColor(context);
  }

  @override
  Widget buildWrapper(BuildContext context) {
    Color $bgColor =
        widget.bgColor ?? context.elThemeColors[widget.type ?? El.primary]!;
    final $textColor = calcTextColor(context, $bgColor);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: sizePreset.height,
        minWidth: widget.width ??
            (isIconChild ? sizePreset.height * 1.25 : sizePreset.width),
      ),
      child: _AnimatedWidget(
        duration: duration,
        curve: widget.curve,
        decoration: BoxDecoration(
          color: calcBgColor(context, $bgColor),
          borderRadius: context.elConfig.radius,
        ),
        textStyle: TextStyle(
          color: $textColor,
          fontSize: sizePreset.fontSize,
          fontWeight: FontWeight.w500,
        ).merge(widget.textStyle),
        iconThemeData: ElIconThemeData(
            size: widget.iconSize ?? sizePreset.iconSize, color: $textColor),
        child: Padding(
          padding: widget.padding ??
              EdgeInsets.symmetric(horizontal: sizePreset.height / 2),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);
    if (!widget.block) {
      result = UnconstrainedBox(
        child: result,
      );
    }
    return result;
  }
}

class _AnimatedWidget extends ImplicitlyAnimatedWidget {
  const _AnimatedWidget({
    required super.duration,
    super.curve,
    required this.decoration,
    required this.textStyle,
    required this.iconThemeData,
    required this.child,
  });

  final BoxDecoration decoration;
  final TextStyle textStyle;
  final ElIconThemeData iconThemeData;
  final Widget child;

  @override
  AnimatedWidgetBaseState<_AnimatedWidget> createState() =>
      _AnimatedWidgetState();
}

class _AnimatedWidgetState extends AnimatedWidgetBaseState<_AnimatedWidget> {
  DecorationTween? _decoration;
  TextStyleTween? _textStyle;
  ElIconThemeDataTween? _iconThemeData;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decoration!.evaluate(animation),
      child: ElDefaultTextStyle(
        style: _textStyle!.evaluate(animation),
        child: ElIconTheme(
          data: _iconThemeData!.evaluate(animation),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _decoration = visitor(_decoration, widget.decoration,
            (dynamic value) => DecorationTween(begin: value as BoxDecoration))
        as DecorationTween;
    _textStyle = visitor(_textStyle, widget.textStyle,
            (dynamic value) => TextStyleTween(begin: value as TextStyle))
        as TextStyleTween;
    _iconThemeData = visitor(
            _iconThemeData,
            widget.iconThemeData,
            (dynamic value) =>
                ElIconThemeDataTween(begin: value as ElIconThemeData))
        as ElIconThemeDataTween;
  }
}
