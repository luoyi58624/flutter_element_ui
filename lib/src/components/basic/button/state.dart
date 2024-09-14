part of 'index.dart';

/// 按钮宽度最小为 64
const double _minWidth = 64;

/// 改变按钮透明度样式值
const double _disabledOpacity = 0.6;

/// 文字类型按钮被禁用时透明值
const double _textButtonDisabledOpacity = 0.36;

typedef ElButtonProp = ({
  bool disabled,
});

class _ElButtonState extends State<ElButton> {
  late ElButtonStyle defaultStyle;
  late double buttonHeight;
  late bool disabled;

  /// 构建按钮事件
  Widget buildEvent({required WidgetBuilder builder}) {
    return ElTapBuilder(
      onTap: () {
        if (widget.enableFeedback ??
            defaultStyle.enableFeedback ??
            context.elConfig.enableFeedback) HapticFeedback.mediumImpact();
        if (widget.onPressed != null) widget.onPressed!();
      },
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      disabled: disabled,
      delay: defaultStyle.animatedDuration.inMilliseconds,
      builder: (context) {
        return ElHoverBuilder(
          disabled: disabled,
          cursor: widget.loading
              ? MouseCursor.defer
              : disabled
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
    if (widget.link) {
      $textColor = (widget.type == null
              ? $elTheme.colors.regularText
              : context.elThemeColors[widget.type]!)
          .buildEventColor(
        context,
        tapBuilder: (color) => color.tap(context),
        hoverBuilder: (color) => color.withOpacity(_disabledOpacity),
      );
      if (disabled) {
        $textColor = $textColor.withOpacity(_textButtonDisabledOpacity);
      }
    }
    // 文字按钮
    else if (widget.text) {
      final pageBgColor = $elTheme.colors.bg;
      $bgColor = pageBgColor
          .on(context.isHover, color: pageBgColor.deepen(4))
          .on(context.isTap, color: pageBgColor.deepen(10));
      $textColor = widget.type == null && widget.bgColor == null
          ? $elTheme.colors.regularText
          : context.elThemeColors[widget.type]!;
      if (disabled) {
        $textColor = $textColor.withOpacity(_textButtonDisabledOpacity);
      }
    } else {
      // 默认按钮
      if (widget.type == null && widget.bgColor == null) {
        $bgColor = context.isTap || context.isHover
            ? $elTheme.primary.themeLightBg(context)
            : $elTheme.colors.bg;

        $textColor = context.isTap || context.isHover
            ? $elTheme.primary
            : $elTheme.colors.regularText;
        if (disabled) {
          $textColor = $textColor.withOpacity(_textButtonDisabledOpacity);
        }

        $borderColor = context.isTap
            ? $elTheme.primary
            : context.isHover
                ? $elTheme.primary.themeLightBorder(context)
                : $defaultBorderColor;

        if (disabled) {
          $borderColor = $borderColor.withOpacity(_disabledOpacity);
        }
      } else {
        final $themeColor =
            widget.bgColor ?? context.elThemeColors[widget.type]!;

        // 镂空按钮
        if (widget.plain) {
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

          if (disabled) {
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
          if (disabled) {
            $bgColor = $bgColor.withOpacity(_disabledOpacity);
            $textColor = $textColor.withOpacity(_disabledOpacity);
          }
        }
      }
    }

    final $border = $borderColor == null
        ? const Border()
        : Border.all(color: $borderColor, width: 1);

    BorderRadiusGeometry $borderRadius = widget.round || widget.circle
        ? BorderRadius.circular(buttonHeight / 2)
        : widget.borderRadius ??
            defaultStyle.borderRadius ??
            context.elConfig.radius;

    final $horizontalPadding = buttonHeight / 2;

    final $padding = widget.circle || widget.link
        ? null
        : (widget.padding ??
            defaultStyle.padding ??
            (widget.round
                ? EdgeInsets.symmetric(horizontal: $horizontalPadding * 1.25)
                : EdgeInsets.symmetric(horizontal: $horizontalPadding)));

    final $constraints = widget.link
        ? null
        : BoxConstraints(
            minHeight: buttonHeight,
            minWidth: (widget.circle
                ? buttonHeight
                : widget.child is ElIcon
                    ? buttonHeight * 1.25
                    : _minWidth),
          );

    Widget result = ElDefaultTextStyle.merge(
      style: TextStyle(
        fontSize: 15,
        fontWeight: ElFont.medium,
        color: $textColor,
      ),
      child: AnimatedContainer(
        duration: context.elThemeDuration ?? defaultStyle.animatedDuration,
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
    result = widget.block && !widget.circle
        ? result
        : UnconstrainedBox(child: result);
    if (widget.loadingWidget != null) {
      result = Stack(
        children: [
          result,
          if (widget.loading)
            Positioned.fill(
              child: ElDefaultTextStyle.merge(
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                child: Center(child: widget.loadingWidget!),
              ),
            ),
        ],
      );
    }
    return result;
  }

  /// 构建默认的图标主题
  Widget buildIconTheme(BuildContext context, Widget iconWidget) {
    return ElIconTheme(
      color: ElDefaultTextStyle.of(context).style.color,
      size: buttonHeight / 2 - 2,
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

    Widget? leftIcon;
    if (widget.leftIcon != null) {
      if (widget.loadingWidget == null && widget.loading) {
        leftIcon = const ElLoading();
      } else {
        leftIcon = widget.leftIcon;
      }
    } else {
      if (widget.loadingWidget == null && widget.loading){
        leftIcon = const ElLoading();
      }
    }

    Widget childContent = Padding(
      padding: EdgeInsets.only(
        left: leftIcon != null ? 6.0 : 0.0,
        right: widget.rightIcon != null ? 6.0 : 0.0,
      ),
      child: $child,
    );

    childContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leftIcon != null) leftIcon,
        childContent,
        if (widget.rightIcon != null) widget.rightIcon!,
      ],
    );

    if (widget.loadingWidget != null) {
      childContent = Opacity(
        opacity: widget.loading == true ? 0.0 : 1.0,
        child: childContent,
      );
    }

    $child = buildIconTheme(
      context,
      childContent,
    );

    return $child;
  }

  @override
  Widget build(BuildContext context) {
    ElAssert.themeType(widget.type, 'ElButton');
    defaultStyle = context.elTheme.buttonStyle;
    buttonHeight =
        widget.height ?? defaultStyle.height ?? context.elConfig.baseHeight;
    disabled = widget.loading || widget.disabled;
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
