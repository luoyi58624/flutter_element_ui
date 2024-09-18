part of 'index.dart';

/// 按钮宽度最小为 64
const double _minWidth = 64;

/// 按钮 background、border 禁用透明度
const double _disabledOpacity = 0.6;

/// 按钮 text 禁用透明度
const double _textDisabledOpacity = 0.36;

/// 主题按钮 text 禁用透明度
const double _themeButtonTextDisabledOpacity = 0.85;

/// 按钮动画持续时间，默认 100 毫秒
const int _duration = 100;

/// 按钮默认文本样式
const _defaultTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

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

class _ElButtonState extends State<ElButton> {
  late ElButtonStyle defaultStyle;
  late double buttonHeight;
  late bool disabled;

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

  /// 构建按钮事件
  Widget buildEvent({required WidgetBuilder builder}) {
    return ElTapBuilder(
      onTap: () {
        if (widget.onPressed != null) widget.onPressed!();
      },
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      disabled: disabled,
      delay: _duration,
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
    final $isDark = context.isDark;
    final $isHover = context.isHover;
    final $isTap = context.isTap;

    Color? $bgColor;
    Color? $textColor;
    Color? $borderColor;
    Color? $loadingTextColor;

    // 处理自定义加载器按钮外观，如果传递了 loadingBuilder，那么按钮原本内容将被隐藏
    if (widget.loadingBuilder != null && widget.loading) {
      if (widget.link || widget.text) {
        $loadingTextColor = widget.type == null && widget.bgColor == null
            ? $elTheme.colors.regularText
            : context.elThemeColors[widget.type]!;
      } else {
        $bgColor = $isDark
            ? const Color.fromRGBO(57, 57, 57, 1.0)
            : const Color.fromRGBO(224, 224, 224, 1.0);
        $loadingTextColor = $isDark
            ? const Color.fromRGBO(118, 118, 118, 1.0)
            : const Color.fromRGBO(166, 166, 166, 1.0);
        if ((widget.type == null && widget.bgColor == null) || widget.plain) {
          $borderColor = $isDark
              ? const Color.fromRGBO(57, 57, 57, 1.0)
              : const Color.fromRGBO(224, 224, 224, 1.0);
        }
      }
    } else {
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
          $textColor = $textColor.withOpacity(_textDisabledOpacity);
        }
      }
      // 文字按钮
      else if (widget.text) {
        final pageBgColor = $elTheme.colors.bg;
        if (widget.bg) {
          $bgColor = pageBgColor
              .deepen(4)
              .on($isHover, color: pageBgColor.deepen(2))
              .on($isTap, color: pageBgColor.deepen(8));
        } else {
          if ($isTap) {
            $bgColor = pageBgColor.deepen(8);
          } else if ($isHover) {
            $bgColor = pageBgColor.deepen(4);
          }
        }
        $textColor = widget.type == null && widget.bgColor == null
            ? $elTheme.colors.regularText
            : context.elThemeColors[widget.type]!;
        if (disabled) {
          $textColor = $textColor.withOpacity(_textDisabledOpacity);
        }
      } else {
        // 默认按钮
        if (widget.type == null && widget.bgColor == null) {
          $bgColor = $isTap || $isHover
              ? $elTheme.primary.themeLightBg(context)
              : $elTheme.colors.bg;

          $textColor = $isTap || $isHover
              ? $elTheme.primary
              : $elTheme.colors.regularText;
          if (disabled) {
            $textColor = $textColor.withOpacity(_textDisabledOpacity);
          }

          $borderColor = $isTap
              ? $elTheme.primary
              : $isHover
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
                ? ($isTap
                    ? $themeColor.tap(context)
                    : $isHover
                        ? $themeColor
                        : $themeColor.themeLightBg(context))
                : ($isTap ? $themeColor : $themeColor.themeLightBg(context));

            $textColor = $isTap || $isHover
                ? $themeColor.elTextColor(context)
                : $themeColor;

            $borderColor = PlatformUtil.isDesktop
                ? ($isTap
                    ? $themeColor.tap(context)
                    : $isHover
                        ? $themeColor
                        : $themeColor.themeLightBorder(context))
                : ($isTap
                    ? $themeColor
                    : $themeColor.themeLightBorder(context));

            if (disabled) {
              $bgColor = $bgColor.withOpacity(_disabledOpacity);
              $textColor = $textColor.withOpacity(_textDisabledOpacity);
              $borderColor = $borderColor.withOpacity(_disabledOpacity);
            }
          }
          // 主题按钮
          else {
            $bgColor = $isTap
                ? $themeColor.tap(context)
                : $isHover
                    ? $themeColor.hover(context)
                    : $themeColor;

            $textColor = $themeColor.elTextColor(context);
            if (disabled) {
              $bgColor = $bgColor.withOpacity(_disabledOpacity);
              $textColor =
                  $textColor.withOpacity(_themeButtonTextDisabledOpacity);
            }
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
                    : widget.width ?? _minWidth),
          );

    Widget result = ElDefaultTextStyle.merge(
      style: _defaultTextStyle.copyWith(
        color: $textColor,
      ),
      child: AnimatedContainer(
        duration:
            context.elThemeDuration ?? const Duration(milliseconds: _duration),
        alignment: Alignment.center,
        padding: $padding,
        constraints: $constraints,
        clipBehavior: Clip.hardEdge,
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
    if (widget.loadingBuilder != null && widget.loading) {
      assert($loadingTextColor != null,
          ElAssert.elementError('ElButton loadingBuilder color 参数不能为空'));
      result = Stack(
        children: [
          result,
          Positioned.fill(
            child: ElDefaultTextStyle.merge(
              style: _defaultTextStyle.copyWith(
                color: $loadingTextColor,
              ),
              child: Center(
                child: buildIconTheme(
                  color: $loadingTextColor,
                  child:
                      widget.loadingBuilder!($loadingTextColor!),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return result;
  }

  /// 构建默认的图标主题
  Widget buildIconTheme({
    required Widget child,
    Color? color,
  }) {
    return ElIconTheme(
      color: color,
      size: buttonHeight / 2 - 2,
      child: child,
    );
  }

  /// 构建按钮内容
  Widget buildButtonContent(BuildContext context) {
    late Widget $child;
    if (widget.child is Widget) {
      $child = widget.child;
    } else {
      $child = ElText('${widget.child}');
    }

    Widget? leftIcon;
    if (widget.leftIcon != null) {
      if (widget.loadingBuilder == null && widget.loading) {
        leftIcon = widget.loadingWidget;
      } else {
        leftIcon = widget.leftIcon;
      }
    } else {
      if (widget.loadingBuilder == null && widget.loading) {
        leftIcon = widget.loadingWidget;
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

    if (widget.loadingBuilder != null) {
      childContent = Opacity(
        opacity: widget.loading == true ? 0.0 : 1.0,
        child: childContent,
      );
    }

    $child = buildIconTheme(
      color: ElDefaultTextStyle.of(context).style.color,
      child: childContent,
    );

    return $child;
  }
}
