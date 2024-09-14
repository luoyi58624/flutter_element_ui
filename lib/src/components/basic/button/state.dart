part of 'index.dart';

/// 按钮宽度最小为 64
const double _minWidth = 64;

/// 改变按钮透明度样式值
const double _disabledOpacity = 0.6;

/// 文字类型按钮被禁用时透明值
const double _textButtonDisabledOpacity = 0.36;

typedef ElButtonProp = ({
  double? width,
  double height,
  Duration duration,
  Color? bgColor,
  Color? color,
  String? type,
  bool text,
  bool link,
  bool plain,
  bool round,
  bool block,
  BorderRadiusGeometry borderRadius,
  EdgeInsetsGeometry? padding,
  ElIcon? leftIcon,
  ElIcon? rightIcon,
  Widget? loadingWidget,
  bool circle,
  bool disabled,
  bool loading,
  bool enableFeedback,
});

class _ElButtonState extends State<ElButton> {
  late ElButtonStyle defaultStyle;
  late ElButtonProp prop;

  /// 构建最终样式
  void buildProp() {
    defaultStyle = context.elTheme.buttonStyle;
    prop = (
      width: null,
      height:
          widget.height ?? defaultStyle.height ?? context.elConfig.baseHeight,
      duration: defaultStyle.animatedDuration,
      bgColor: widget.bgColor,
      color: widget.color,
      type: widget.type,
      text: widget.text,
      link: widget.link,
      plain: widget.plain,
      round: widget.round,
      block: widget.block,
      borderRadius: widget.borderRadius ??
          defaultStyle.borderRadius ??
          context.elConfig.radius,
      padding: widget.padding ?? defaultStyle.padding,
      leftIcon: widget.leftIcon,
      rightIcon: widget.rightIcon,
      loadingWidget: widget.loadingWidget,
      circle: widget.circle,
      disabled: widget.loading || widget.disabled,
      loading: widget.loading,
      enableFeedback: widget.enableFeedback ??
          defaultStyle.enableFeedback ??
          context.elConfig.enableFeedback,
    );
  }

  /// 构建按钮事件
  Widget buildEvent({required WidgetBuilder builder}) {
    return ElTapBuilder(
      onTap: () {
        if (prop.enableFeedback) HapticFeedback.mediumImpact();
        if (widget.onPressed != null) widget.onPressed!();
      },
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      disabled: prop.disabled,
      delay: defaultStyle.animatedDuration.inMilliseconds,
      builder: (context) {
        return ElHoverBuilder(
          disabled: prop.disabled,
          cursor: prop.disabled
              ? SystemMouseCursors.forbidden
              : SystemMouseCursors.click,
          builder: (context) => builder(context),
        );
      },
    );
  }

  /// 构建按钮外观
  Widget buildButtonWrapper(BuildContext context) {
    final $elTheme = context.elTheme;

    final $defaultBorderColor = $elTheme.colors.border;
    Color? $bgColor;
    Color? $textColor;
    Color? $borderColor;

    // 链接按钮
    if (prop.link) {
      $textColor = (prop.type == null
              ? $elTheme.colors.regularText
              : context.elThemeColors[prop.type]!)
          .buildEventColor(
        context,
        tapBuilder: (color) => color.tap(context),
        hoverBuilder: (color) => color.withOpacity(_disabledOpacity),
      );
      if (prop.disabled) {
        $textColor = $textColor.withOpacity(_textButtonDisabledOpacity);
      }
    }
    // 文字按钮
    else if (prop.text) {
      final pageBgColor = $elTheme.colors.bg;
      $bgColor = pageBgColor
          .on(context.isHover, color: pageBgColor.deepen(4))
          .on(context.isTap, color: pageBgColor.deepen(10));
      $textColor = prop.type == null && prop.bgColor == null
          ? $elTheme.colors.regularText
          : context.elThemeColors[prop.type]!;
      if (prop.disabled) {
        $textColor = $textColor.withOpacity(_textButtonDisabledOpacity);
      }
    } else {
      // 默认按钮
      if (prop.type == null && prop.bgColor == null) {
        $bgColor = context.isTap || context.isHover
            ? $elTheme.primary.themeLightBg(context)
            : $elTheme.colors.bg;

        $textColor = context.isTap || context.isHover
            ? $elTheme.primary
            : $elTheme.colors.regularText;
        if (prop.disabled) {
          $textColor = $textColor.withOpacity(_textButtonDisabledOpacity);
        }

        $borderColor = context.isTap
            ? $elTheme.primary
            : context.isHover
                ? $elTheme.primary.themeLightBorder(context)
                : $defaultBorderColor;

        if (prop.disabled) {
          $borderColor = $borderColor.withOpacity(_disabledOpacity);
        }
      } else {
        final $themeColor = prop.bgColor ?? context.elThemeColors[prop.type]!;

        // 镂空按钮
        if (prop.plain) {
          $bgColor = PlatformUtil.isDesktop
              ? (context.isTap
                  ? $themeColor.tap(context)
                  : context.isHover
                      ? $themeColor
                      : $themeColor.themeLightBg(context))
              : (context.isTap
                  ? $themeColor
                  : $themeColor.themeLightBg(context));

          $textColor = context.isTap || context.isHover
              ? $themeColor.elTextColor(context)
              : $themeColor;

          $borderColor = PlatformUtil.isDesktop
              ? (context.isTap
                  ? $themeColor.tap(context)
                  : context.isHover
                      ? $themeColor
                      : $themeColor.themeLightBorder(context))
              : (context.isTap
                  ? $themeColor
                  : $themeColor.themeLightBorder(context));

          if (prop.disabled) {
            $bgColor = $bgColor.withOpacity(_disabledOpacity);
            $textColor = $textColor.withOpacity(_textButtonDisabledOpacity);
            $borderColor = $borderColor.withOpacity(_disabledOpacity);
          }
        }
        // 主题按钮
        else {
          $bgColor = context.isTap
              ? $themeColor.tap(context)
              : context.isHover
                  ? $themeColor.hover(context)
                  : $themeColor;

          $textColor = $themeColor.elTextColor(context);
          if (prop.disabled) {
            $bgColor = $bgColor.withOpacity(_disabledOpacity);
          }
        }
      }
    }

    final $border = $borderColor == null
        ? const Border()
        : Border.all(color: $borderColor, width: 1);

    BorderRadiusGeometry $borderRadius = prop.round || prop.circle
        ? BorderRadius.circular(prop.height / 2)
        : prop.borderRadius;

    final $horizontalPadding = prop.height / 2;

    final $padding = prop.circle || prop.link
        ? null
        : (prop.padding ??
            (prop.round
                ? EdgeInsets.symmetric(horizontal: $horizontalPadding * 1.25)
                : EdgeInsets.symmetric(horizontal: $horizontalPadding)));

    final $constraints = prop.link
        ? null
        : BoxConstraints(
            minHeight: prop.height,
            minWidth: (prop.circle
                ? prop.height
                : widget.child is ElIcon
                    ? prop.height * 1.25
                    : _minWidth),
          );

    Widget result = ElDefaultTextStyle.merge(
      style: TextStyle(
        fontSize: 15,
        fontWeight: ElFont.medium,
        color: $textColor,
      ),
      child: AnimatedContainer(
        duration: context.elThemeDuration ?? prop.duration,
        alignment: Alignment.center,
        padding: $padding,
        constraints: $constraints,
        decoration: BoxDecoration(
          color: $bgColor,
          border: $border,
          borderRadius: $borderRadius,
        ),
        child: Builder(builder: (context) {
          return buildButtonContent(context);
        }),
      ),
    );
    return prop.block && !prop.circle ? result : UnconstrainedBox(child: result);
  }

  /// 构建默认的图标主题
  Widget buildIconTheme(BuildContext context, Widget iconWidget) {
    return ElIconTheme(
      color: ElDefaultTextStyle.of(context).style.color,
      size: prop.height / 2 - 2,
      child: iconWidget,
    );
  }

  /// 构建按钮内容
  Widget buildButtonContent(BuildContext context) {
    late Widget $child;
    if (widget.child is Widget) {
      if (widget.child is ElIcon) {
        $child = buildIconTheme(context, widget.child);
      } else {
        $child = widget.child;
      }
    } else {
      $child = ElText(
        '${widget.child}',
        strutStyle: const StrutStyle(forceStrutHeight: true),
      );
    }

    if (prop.loading || prop.leftIcon != null || prop.rightIcon != null) {
      $child = buildIconTheme(
        context,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (prop.loading) prop.loadingWidget ?? const ElLoading(),
            if (prop.leftIcon != null) prop.leftIcon!,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: $child,
            ),
            if (prop.rightIcon != null) prop.rightIcon!,
          ],
        ),
      );
    }
    return $child;
  }

  @override
  Widget build(BuildContext context) {
    ElAssert.themeType(widget.type, 'ElButton');
    buildProp();
    return buildEvent(
      builder: (context) => buildButtonWrapper(context),
    );
  }
}

extension _ButtonColorExtension on Color {
  /// hover 悬停颜色，颜色会变得更浅
  Color hover(BuildContext context) => elLight3(context);

  /// tap 按下颜色，颜色会变得更深
  Color tap(BuildContext context) => elLight3(context, reverse: true);

  /// 应用主题透明背景颜色
  Color themeLightBg(BuildContext context) => elLight9(context);

  /// 应用主题透明边框颜色
  Color themeLightBorder(BuildContext context) => elLight6(context);
}
