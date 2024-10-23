part of 'index.dart';

/// 按钮颜色样式预设，封装各种类型按钮在 default、hover、active 三种状态下的颜色主题
class _ButtonColors {
  _ButtonColors._();

  /// 计算按钮颜色样式
  static _ButtonColorStyle calcButtonColorStyle(
    BuildContext context, {
    required _ButtonProp prop,
    required bool isTap,
    required bool isHover,
  }) {
    late _ButtonColorStyle colors;
    if (prop.loadingBuilder != null && prop.loading) {
      return loadingButton(
        context,
        bgColor: prop.bgColor,
        link: prop.link,
        text: prop.text,
        plain: prop.plain,
      );
    } else {
      if (prop.link) {
        if (isTap) {
          colors = linkButtonActive(context, bgColor: prop.bgColor);
        } else if (isHover) {
          colors = linkButtonHover(context, bgColor: prop.bgColor);
        } else {
          colors = linkButton(
            context,
            bgColor: prop.bgColor,
            disabled: prop.disabled,
          );
        }
        return colors.linkButtonDisabled(prop.disabled);
      } else if (prop.text) {
        if (isTap) {
          colors = textButtonActive(
            context,
            bgColor: prop.bgColor,
            bg: prop.bg,
          );
        } else if (isHover) {
          colors = textButtonHover(
            context,
            bgColor: prop.bgColor,
            bg: prop.bg,
          );
        } else {
          colors = textButton(
            context,
            bgColor: prop.bgColor,
            bg: prop.bg,
            disabled: prop.disabled,
          );
        }
      } else if (prop.plain) {
        if (prop.bgColor == null) {
          if (isTap) {
            colors = plainButtonActive(context);
          } else if (isHover) {
            colors = plainButtonHover(context);
          } else {
            colors = plainButton(context, disabled: prop.disabled);
          }
        } else {
          if (isTap) {
            colors = themeButtonActive(context, bgColor: prop.bgColor!);
          } else if (isHover) {
            colors = themeButton(context, bgColor: prop.bgColor!);
          } else {
            colors = plainThemeButton(
              context,
              bgColor: prop.bgColor!,
              disabled: prop.disabled,
            );
          }
        }
      } else {
        if (prop.bgColor != null) {
          if (isTap) {
            colors = themeButtonActive(context, bgColor: prop.bgColor!);
          } else if (isHover) {
            colors = themeButtonHover(context, bgColor: prop.bgColor!);
          } else {
            colors = themeButton(
              context,
              bgColor: prop.bgColor!,
              disabled: prop.disabled,
            );
          }
        } else {
          if (isTap) {
            colors = buttonActive(context);
          } else if (isHover) {
            colors = buttonHover(context);
          } else {
            colors = button(context, disabled: prop.disabled);
          }
        }
      }
    }

    return colors;
  }

  /// 默认状态下的按钮样式
  static _ButtonColorStyle button(
    BuildContext context, {
    bool disabled = false,
  }) {
    final $elTheme = context.elTheme;
    Color $bgColor = $elTheme.bgColor;
    Color $textColor = $elTheme.regularTextColor;
    Color $borderColor = $elTheme.borderColor;

    if (disabled) {
      $bgColor = $bgColor.withOpacity(_disabledOpacity);
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
      $borderColor = $borderColor.withOpacity(_disabledOpacity);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  /// 悬停状态下的按钮样式
  static _ButtonColorStyle buttonHover(BuildContext context) {
    final $elTheme = context.elTheme;
    return _ButtonColorStyle(
      bgColor: $elTheme.primary.themeLightBg(context),
      textColor: $elTheme.primary,
      borderColor: $elTheme.primary.themeLightBorder(context),
    );
  }

  /// 激活状态下的按钮样式
  static _ButtonColorStyle buttonActive(BuildContext context) {
    final $elTheme = context.elTheme;
    return _ButtonColorStyle(
      bgColor: $elTheme.primary.themeLightBg(context),
      textColor: $elTheme.primary,
      borderColor: $elTheme.primary,
    );
  }

  static _ButtonColorStyle themeButton(
    BuildContext context, {
    required Color bgColor,
    bool disabled = false,
  }) {
    Color $bgColor = bgColor;
    Color $textColor = bgColor.elTextColor(context);

    if (disabled) {
      $bgColor = bgColor.withOpacity(_disabledOpacity);
      $textColor = $textColor.withOpacity(_themeButtonTextDisabledOpacity);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
    );
  }

  static _ButtonColorStyle themeButtonHover(
    BuildContext context, {
    required Color bgColor,
  }) {
    return _ButtonColorStyle(
      bgColor: bgColor.hover(context),
      textColor: bgColor.elTextColor(context),
      borderColor: bgColor.hover(context),
    );
  }

  static _ButtonColorStyle themeButtonActive(
    BuildContext context, {
    required Color bgColor,
  }) {
    return _ButtonColorStyle(
      bgColor: bgColor.tap(context),
      textColor: bgColor.elTextColor(context),
      borderColor: bgColor.tap(context),
    );
  }

  static _ButtonColorStyle plainButton(
    BuildContext context, {
    bool disabled = false,
  }) {
    final $elTheme = context.elTheme;
    Color $bgColor = $elTheme.bgColor;
    Color $textColor = $elTheme.regularTextColor;
    Color $borderColor = $elTheme.borderColor;

    if (disabled) {
      $bgColor = $bgColor.withOpacity(_disabledOpacity);
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
      $borderColor = $borderColor.withOpacity(_disabledOpacity);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle plainButtonHover(BuildContext context) {
    final $elTheme = context.elTheme;
    Color $bgColor = $elTheme.bgColor;
    Color $textColor = $elTheme.primary;
    Color $borderColor = $elTheme.primary.themeLightBorder(context);

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle plainButtonActive(BuildContext context) {
    final $elTheme = context.elTheme;
    Color $bgColor = $elTheme.bgColor;
    Color $textColor = $elTheme.primary;
    Color $borderColor = $elTheme.primary;

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle plainThemeButton(
    BuildContext context, {
    required Color bgColor,
    bool disabled = false,
  }) {
    Color $bgColor = bgColor.themeLightBg(context);
    Color $textColor = bgColor;
    Color $borderColor = bgColor.themeLightBorder(context);

    if (disabled) {
      $bgColor = $bgColor.withOpacity(_disabledOpacity);
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
      $borderColor = $borderColor.withOpacity(_disabledOpacity);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle textButton(
    BuildContext context, {
    Color? bgColor,
    bool bg = false,
    bool disabled = false,
  }) {
    final $elTheme = context.elTheme;
    final pageBgColor = $elTheme.bgColor;
    Color? $bgColor;
    if (bg) {
      $bgColor = pageBgColor.deepen(5);
    }

    var $textColor = bgColor ?? $elTheme.regularTextColor;

    if (disabled) {
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
    );
  }

  static _ButtonColorStyle textButtonHover(
    BuildContext context, {
    Color? bgColor,
    bool bg = false,
  }) {
    final $elTheme = context.elTheme;
    final pageBgColor = $elTheme.bgColor;
    Color? $bgColor;
    if (bg) {
      $bgColor = pageBgColor.deepen(10);
    } else {
      $bgColor = pageBgColor.deepen(5);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: bgColor ?? $elTheme.regularTextColor,
    );
  }

  static _ButtonColorStyle textButtonActive(
    BuildContext context, {
    Color? bgColor,
    bool bg = false,
  }) {
    final $elTheme = context.elTheme;
    final pageBgColor = $elTheme.bgColor;
    Color? $bgColor;
    if (bg) {
      $bgColor = pageBgColor.deepen(15);
    } else {
      $bgColor = pageBgColor.deepen(12);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: bgColor ?? $elTheme.regularTextColor,
    );
  }

  static _ButtonColorStyle linkButton(
    BuildContext context, {
    Color? bgColor,
    bool disabled = false,
  }) {
    final $elTheme = context.elTheme;
    var $textColor = bgColor ?? $elTheme.regularTextColor;
    if (disabled) {
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
    }
    return _ButtonColorStyle(
      textColor: $textColor,
    );
  }

  static _ButtonColorStyle linkButtonHover(
    BuildContext context, {
    Color? bgColor,
  }) {
    final $elTheme = context.elTheme;
    var $textColor = bgColor ?? $elTheme.regularTextColor;
    return _ButtonColorStyle(
      textColor: $textColor.withOpacity(_disabledOpacity),
    );
  }

  static _ButtonColorStyle linkButtonActive(
    BuildContext context, {
    Color? bgColor,
  }) {
    final $elTheme = context.elTheme;
    var $textColor = bgColor ?? $elTheme.regularTextColor;
    return _ButtonColorStyle(
      textColor: $textColor.tap(context),
    );
  }

  static _ButtonColorStyle loadingButton(
    BuildContext context, {
    Color? bgColor,
    bool plain = false,
    bool text = false,
    bool link = false,
  }) {
    final $elTheme = context.elTheme;
    final $isDark = context.isDark;

    Color? $loadingTextColor;
    Color? $bgColor;
    Color? $borderColor;

    if (text || link) {
      $loadingTextColor = bgColor ?? $elTheme.regularTextColor;
    } else {
      $bgColor = $isDark
          ? const Color.fromRGBO(57, 57, 57, 1.0)
          : const Color.fromRGBO(224, 224, 224, 1.0);
      $loadingTextColor = $isDark
          ? const Color.fromRGBO(118, 118, 118, 1.0)
          : const Color.fromRGBO(166, 166, 166, 1.0);
      if ((bgColor == null) || plain) {
        $borderColor = $isDark
            ? const Color.fromRGBO(57, 57, 57, 1.0)
            : const Color.fromRGBO(224, 224, 224, 1.0);
      }
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      borderColor: $borderColor,
      loadingTextColor: $loadingTextColor,
    );
  }
}
