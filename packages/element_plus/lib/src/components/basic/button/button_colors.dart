part of 'index.dart';

typedef _ColorStyleProp = ({
  Color? bgColor,
  bool plain,
  bool text,
  bool bg,
  bool link,
  bool disabled,
  bool loading,
});

/// 按钮颜色样式
class _ButtonColorStyle {
  Color? bgColor;
  Color? textColor;
  Color? borderColor;
  Color? loadingTextColor;

  _ButtonColorStyle({
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.loadingTextColor,
  });

  _ButtonColorStyle copyWith({
    Color? bgColor,
    Color? textColor,
    Color? borderColor,
    Color? loadingTextColor,
  }) {
    return _ButtonColorStyle(
      bgColor: bgColor ?? this.bgColor,
      textColor: textColor ?? this.textColor,
      borderColor: borderColor ?? this.borderColor,
      loadingTextColor: loadingTextColor ?? this.loadingTextColor,
    );
  }
}

extension _ButtonColorExtension on Color {
  /// 悬停状态颜色，颜色会变得更浅
  Color hover(BuildContext context, [bool? reverse]) =>
      elLight3(context, reverse: reverse ?? false);

  /// 按下状态颜色，颜色会变得更深
  Color tap(BuildContext context, [bool? reverse]) =>
      elLight3(context, reverse: reverse == null ? true : !reverse);

  /// 禁用状态颜色
  Color disabled(BuildContext context) => elLight5(context);
}

/// 按钮颜色样式预设，封装各种类型按钮在 default、hover、active 三种状态下的颜色主题
class _ButtonColors {
  _ButtonColors._();

  /// 计算按钮颜色样式
  static _ButtonColorStyle calcColorStyle(
    BuildContext context, {
    required _ColorStyleProp prop,
    required bool hasTap,
    required bool hasHover,
    required bool isFocus,
    required bool hasGroup,
  }) {
    final $elTheme = context.elTheme;
    late _ButtonColorStyle colors;

    if (prop.link) {
      if (hasTap) {
        colors = linkButtonActive(context, bgColor: prop.bgColor);
      } else if (hasHover) {
        colors = linkButtonHover(context, bgColor: prop.bgColor);
      } else {
        colors = linkButton(
          context,
          bgColor: prop.bgColor,
          disabled: prop.disabled || prop.loading,
        );
      }
    } else if (prop.text) {
      if (hasTap) {
        colors = textButtonActive(
          context,
          bgColor: prop.bgColor,
          bg: prop.bg,
        );
      } else if (hasHover || (hasGroup && isFocus)) {
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
          disabled: prop.disabled || prop.loading,
        );
      }
    } else if (prop.plain) {
      if (prop.bgColor == null) {
        if (hasTap) {
          colors = plainButtonActive(context);
        } else if (hasHover || isFocus) {
          colors = plainButtonHover(context);
        } else {
          colors = plainButton(
            context,
            disabled: prop.disabled || prop.loading,
          );
        }
      } else {
        if (hasTap) {
          colors = plainThemeButtonActive(context, bgColor: prop.bgColor!);
        } else if (hasHover || isFocus) {
          colors = themeButton(context, bgColor: prop.bgColor!);
        } else {
          colors = plainThemeButton(
            context,
            bgColor: prop.bgColor!,
            disabled: prop.disabled || prop.loading,
          );
        }
      }
    } else {
      if (prop.bgColor == null) {
        if (hasTap) {
          colors = _ButtonColorStyle(
            bgColor: $elTheme.primary.elLight9(context),
            textColor: $elTheme.primary,
            borderColor: $elTheme.primary,
          );
        } else if (hasHover || isFocus) {
          colors = _ButtonColorStyle(
            bgColor: $elTheme.primary.elLight9(context),
            textColor: $elTheme.primary,
            borderColor: $elTheme.primary.elLight6(context),
          );
        } else {
          colors = button(
            context,
            disabled: prop.disabled || prop.loading,
          );
        }
      } else {
        if (hasTap) {
          colors = themeButtonActive(context, bgColor: prop.bgColor!);
        } else if (hasHover || (hasGroup && isFocus)) {
          colors = themeButtonHover(context, bgColor: prop.bgColor!);
        } else {
          colors = themeButton(
            context,
            bgColor: prop.bgColor!,
            disabled: prop.disabled || prop.loading,
          );
        }
      }
    }

    return colors;
  }

  /// 计算按钮组颜色样式，它多了 isSelected 选中状态
  static _ButtonColorStyle calcGroupColorStyle(
    BuildContext context, {
    required _ColorStyleProp prop,
    required bool hasTap,
    required bool hasHover,
    required bool isSelected,
  }) {
    final $elTheme = context.elTheme;
    late _ButtonColorStyle colors;

    if (prop.text) {
      if (isSelected) {
        Color $color = prop.bgColor ?? $elTheme.primary;
        if (hasTap) {
          colors = _ButtonColorStyle(
            bgColor: $color.elLight8(context),
            textColor: $color,
          );
        } else {
          colors = _ButtonColorStyle(
            bgColor: $color.elLight9(context),
            textColor: $color,
          );
        }
      } else {
        if (hasTap) {
          colors = _ButtonColors.textButtonActive(
            context,
            bg: prop.bg,
          );
        } else if (hasHover) {
          colors = _ButtonColors.textButtonHover(
            context,
            bg: prop.bg,
          );
        } else {
          colors = _ButtonColors.textButton(
            context,
            bg: prop.bg,
          );
        }
      }
    } else if (prop.plain) {
      if (prop.bgColor == null) {
        if (isSelected) {
          colors = _ButtonColorStyle(
            bgColor: $elTheme.layoutTheme.bgColor,
            textColor: $elTheme.primary,
            borderColor: $elTheme.primary,
          );
        } else if (hasHover || hasTap) {
          colors = _ButtonColorStyle(
            bgColor: $elTheme.layoutTheme.bgColor,
            textColor: $elTheme.primary,
            borderColor: $elTheme.layoutTheme.borderColor,
          );
        } else {
          colors = _ButtonColors.plainButton(context,
              disabled: prop.disabled || prop.loading);
        }
      } else {
        if (isSelected) {
          colors = _ButtonColors.themeButton(
            context,
            bgColor: prop.bgColor!,
            disabled: prop.disabled || prop.loading,
          );
        } else if (hasHover || hasTap) {
          colors = _ButtonColors.plainThemeButton(
            context,
            bgColor: prop.bgColor!,
            disabled: prop.disabled || prop.loading,
          );
          colors.textColor = colors.textColor!.tap(context);
        } else {
          colors = _ButtonColors.plainThemeButton(
            context,
            bgColor: prop.bgColor!,
            disabled: prop.disabled || prop.loading,
          );
        }
      }
    } else {
      if (prop.bgColor == null) {
        if (isSelected) {
          colors = _ButtonColorStyle(
            bgColor: $elTheme.layoutTheme.bgColor,
            textColor: $elTheme.primary,
            borderColor: $elTheme.primary,
          );
        } else if (hasHover || hasTap) {
          colors = _ButtonColorStyle(
            textColor: $elTheme.primary,
            borderColor: $elTheme.layoutTheme.borderColor,
          );
        } else {
          colors = _ButtonColors.button(
            context,
            disabled: prop.disabled || prop.loading,
          );
        }
      } else {
        if (isSelected) {
          colors = _ButtonColorStyle(
            bgColor: prop.bgColor,
            textColor: prop.bgColor!.elTextColor(context),
            borderColor: prop.bgColor,
          );
        } else if (hasHover || hasTap) {
          colors = _ButtonColorStyle(
            textColor: prop.bgColor,
            borderColor: $elTheme.layoutTheme.borderColor,
          );
        } else {
          colors = _ButtonColors.button(
            context,
            disabled: prop.disabled || prop.loading,
          );
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
    Color $bgColor = $elTheme.layoutTheme.bgColor!;
    Color $textColor = $elTheme.textTheme.regularStyle.color!;
    Color $borderColor = $elTheme.layoutTheme.borderColor!;

    if (disabled) {
      $textColor = $textColor.disabled(context);
      $borderColor = $borderColor.disabled(context);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle themeButton(
    BuildContext context, {
    required Color bgColor,
    bool disabled = false,
  }) {
    Color $bgColor = bgColor;
    Color $textColor = bgColor.elTextColor(context);
    Color $borderColor = bgColor;

    if (disabled) {
      $bgColor = bgColor.disabled(context);
      $textColor = $textColor.disabled(context);
      $borderColor = bgColor.disabled(context);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
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
    Color $bgColor = $elTheme.layoutTheme.bgColor!;
    Color $textColor = $elTheme.textTheme.regularStyle.color!;
    Color $borderColor = $elTheme.layoutTheme.borderColor!;

    if (disabled) {
      $textColor = $textColor.disabled(context);
      $borderColor = $borderColor.disabled(context);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle plainButtonHover(BuildContext context) {
    final $elTheme = context.elTheme;
    Color $bgColor = $elTheme.layoutTheme.bgColor!;
    Color $textColor = $elTheme.primary;
    Color $borderColor = $elTheme.primary;

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle plainButtonActive(BuildContext context) {
    final $elTheme = context.elTheme;
    Color $bgColor = $elTheme.layoutTheme.bgColor!;
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
    Color $bgColor = bgColor.elLight9(context);
    Color $textColor = bgColor;
    Color $borderColor = bgColor.elLight6(context);

    if (disabled) {
      $bgColor = $bgColor.disabled(context);
      $textColor = $textColor.disabled(context);
      $borderColor = $borderColor.disabled(context);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle plainThemeButtonActive(
    BuildContext context, {
    required Color bgColor,
  }) {
    if (PlatformUtil.isDesktop) {
      return themeButtonActive(context, bgColor: bgColor);
    } else {
      return themeButton(context, bgColor: bgColor);
    }
  }

  static _ButtonColorStyle textButton(
    BuildContext context, {
    Color? bgColor,
    bool bg = false,
    bool disabled = false,
  }) {
    final $elTheme = context.elTheme;
    final pageBgColor = $elTheme.layoutTheme.bgColor!;
    Color? $bgColor;
    if (bg) {
      $bgColor = pageBgColor.deepen(5);
    }

    var $textColor = bgColor ?? $elTheme.textTheme.regularStyle.color!;

    if (disabled) {
      $textColor = $textColor.disabled(context);
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
    final pageBgColor = $elTheme.layoutTheme.bgColor!;
    Color? $bgColor;
    if (bg) {
      $bgColor = pageBgColor.deepen(10);
    } else {
      $bgColor = pageBgColor.deepen(5);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: bgColor ?? $elTheme.textTheme.regularStyle.color!,
    );
  }

  static _ButtonColorStyle textButtonActive(
    BuildContext context, {
    Color? bgColor,
    bool bg = false,
  }) {
    final $elTheme = context.elTheme;
    final pageBgColor = $elTheme.layoutTheme.bgColor!;
    Color? $bgColor;
    if (bg) {
      $bgColor = pageBgColor.deepen(15);
    } else {
      $bgColor = pageBgColor.deepen(12);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: bgColor ?? $elTheme.textTheme.regularStyle.color!,
    );
  }

  static _ButtonColorStyle linkButton(
    BuildContext context, {
    Color? bgColor,
    bool disabled = false,
  }) {
    final $elTheme = context.elTheme;
    var $textColor = bgColor ?? $elTheme.textTheme.regularStyle.color!;
    if (disabled) {
      $textColor = $textColor.disabled(context);
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
    var $textColor = bgColor ?? $elTheme.textTheme.regularStyle.color!;
    return _ButtonColorStyle(
      textColor: $textColor.elLight5(context),
    );
  }

  static _ButtonColorStyle linkButtonActive(
    BuildContext context, {
    Color? bgColor,
  }) {
    final $elTheme = context.elTheme;
    var $textColor = bgColor ?? $elTheme.textTheme.regularStyle.color!;
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
      $loadingTextColor = bgColor ?? $elTheme.textTheme.regularStyle.color!;
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
