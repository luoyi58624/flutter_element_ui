part of 'index.dart';

class ElButton2 extends ElRawButton {
  const ElButton2({
    super.key,
    required super.child,
    this.bgColor,
    this.width,
    this.height,
    this.iconSize,
    this.leftIcon,
    this.rightIcon,
    this.round = false,
    this.padding,
    super.duration,
    super.curve,
    super.type,
    super.block,
    super.textStyle,
    super.autofocus,
    super.disabled,
    super.loading,
    super.loadingWidget,
    super.loadingBuilder,
    super.onPressed,
  });

  /// 自定义颜色按钮，它会覆盖 [type] 属性
  final Color? bgColor;

  /// 按钮最小宽度，按钮的宽度受多种因素影响，具体表现有以下几种情况（按优先级排序）：
  /// * [block]，它会解除按钮约束，通常情况下按钮将充满整个空间，这取决于父级约束条件
  /// * [circle]，按钮宽度强制等于高度，因为此时按钮是圆形
  /// * [width]，用户自定义宽度
  /// * 最后：如果 [child] 是 [ElIcon] 或 [Icon]，那么默认宽度等于 height * 1.25
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

  /// 自定义按钮内边距
  final EdgeInsets? padding;

  @override
  State<ElRawButton> createState() => ElButton2State();
}

class ElButton2State<T extends ElButton2> extends ElRawButtonState<T> {
  bool get isIconChild => widget.child is ElIcon;

  bool get isDefaultButton => widget.type == null && widget.bgColor == null;

  @override
  Color get bgColor {
    if (isDefaultButton) {
      return context.isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    }
    return getBgColor();
  }

  @override
  Color? calcBgColor(BuildContext context) {
    final color = bgColor;
    if (isDefaultButton) {
      return context.hasTap
          ? color.elLight3(context, reverse: true)
          : context.hasHover
              ? color.elLight1(context, reverse: true)
              : color;
    } else {
      return context.hasTap
          ? color.elLight3(context, reverse: true)
          : context.hasHover
              ? color.elLight3(context)
              : color;
    }
  }

  @override
  Color? calcTextColor(BuildContext context, Color? $bgColor) {
    if (isDefaultButton) return context.elTheme.textTheme.regularStyle.color!;
    return bgColor.elTextColor(context);
  }

  /// 如果按钮需要绘制边框，请重写它
  Border? calcBorder(BuildContext context) => null;

  /// 获取按钮的背景颜色
  Color getBgColor() {
    if (widget.bgColor != null) return widget.bgColor!;
    return context.elThemeColors[widget.type ?? El.primary]!;
  }

  @override
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    final $bgColor = calcBgColor(context);
    final $textColor = calcTextColor(context, $bgColor);
    final $border = calcBorder(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: sizePreset.height!,
        minWidth: widget.width ??
            (isIconChild ? sizePreset.height! * 1.25 : sizePreset.width!),
      ),
      child: _AnimatedWidget(
        duration: duration,
        curve: curve,
        decoration: BoxDecoration(
          color: $bgColor,
          borderRadius: context.elConfig.radius,
          border: $border,
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
              EdgeInsets.symmetric(horizontal: sizePreset.height! / 2),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildButtonContent(BuildContext context) {
    Widget result = super.buildButtonContent(context);

    Widget? $leftIcon = widget.leftIcon;
    Widget? $rightIcon = widget.rightIcon;
    if (widget.loadingBuilder == null && widget.loading) {
      if ($leftIcon != null) {
        $leftIcon = widget.loadingWidget;
      } else if ($rightIcon != null) {
        $rightIcon = widget.loadingWidget;
      } else {
        if (!isIconChild) {
          $leftIcon = widget.loadingWidget;
        }
      }
    }

    result = Padding(
      padding: EdgeInsets.only(
        left: $leftIcon != null ? 6.0 : 0.0,
        right: $rightIcon != null ? 6.0 : 0.0,
      ),
      child: widget.loadingBuilder == null &&
              widget.leftIcon == null &&
              widget.loading &&
              isIconChild
          ? widget.loadingWidget
          : result,
    );

    result = DefaultSelectionStyle(
      mouseCursor: cursor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if ($leftIcon != null) $leftIcon,
          result,
          if ($rightIcon != null) $rightIcon,
        ],
      ),
    );

    if (widget.loadingBuilder != null) {
      result = Opacity(
        opacity: widget.loading == true ? 0.0 : 1.0,
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
