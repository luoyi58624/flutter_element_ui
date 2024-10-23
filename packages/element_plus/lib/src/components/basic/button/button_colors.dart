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
        type: prop.type,
        bgColor: prop.bgColor,
        link: prop.link,
        text: prop.text,
        plain: prop.plain,
      );
    } else {
      if (prop.link) {
        if (isTap) {
          colors = linkButtonActive(
            context,
            type: prop.type,
          );
        } else if (isHover) {
          colors = linkButtonHover(
            context,
            type: prop.type,
          );
        } else {
          colors = linkButton(
            context,
            type: prop.type,
          );
        }
        return colors.linkButtonDisabled(prop.disabled);
      } else if (prop.text) {
        if (isTap) {
          colors = textButtonActive(
            context,
            type: prop.type,
            bgColor: prop.bgColor,
            bg: prop.bg,
          );
        } else if (isHover) {
          colors = textButtonHover(
            context,
            type: prop.type,
            bgColor: prop.bgColor,
            bg: prop.bg,
          );
        } else {
          colors = textButton(
            context,
            type: prop.type,
            bgColor: prop.bgColor,
            bg: prop.bg,
          );
        }
        return colors.textButtonDisabled(prop.disabled);
      } else if (prop.plain) {
        if (isTap) {
          colors = plainButtonActive(
            context,
            type: prop.type,
            bgColor: prop.bgColor,
          );
        } else if (isHover) {
          colors = plainButtonHover(
            context,
            type: prop.type,
            bgColor: prop.bgColor,
          );
        } else {
          colors = plainButton(
            context,
            type: prop.type,
            bgColor: prop.bgColor,
          );
        }
        return colors.plainButtonDisabled(prop.disabled);
      } else {
        if (isTap) {
          colors = buttonActive(
            context,
            type: prop.type,
            bgColor: prop.bgColor,
          );
        } else if (isHover) {
          colors = buttonHover(
            context,
            type: prop.type,
            bgColor: prop.bgColor,
          );
        } else {
          colors = button(
            context,
            type: prop.type,
            bgColor: prop.bgColor,
            disabled: prop.disabled,
          );
        }
        return colors;
      }
    }
  }

  /// 默认状态下的按钮样式
  static _ButtonColorStyle button(
    BuildContext context, {
    String? type,
    Color? bgColor,
    bool disabled = false,
  }) {
    final $elTheme = context.elTheme;
    final $themeColor = bgColor ?? context.elThemeColors[type];
    Color? $bgColor;
    late Color $textColor;
    late Color $borderColor;

    if ($themeColor == null) {
      $bgColor = $elTheme.bgColor;
      $textColor = $elTheme.regularTextColor;
      $borderColor = $elTheme.borderColor;
      if (disabled) {
        $textColor = $textColor.withOpacity(_textDisabledOpacity);
        $borderColor = $borderColor.withOpacity(_disabledOpacity);
      }
    } else {
      $bgColor = $themeColor;
      $textColor = $themeColor.elTextColor(context);
      $borderColor = $themeColor;
      if (disabled) {
        $bgColor = $bgColor.withOpacity(_disabledOpacity);
        $textColor = $textColor.withOpacity(_themeButtonTextDisabledOpacity);
        $borderColor = $borderColor.withOpacity(_disabledOpacity);
      }
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  /// 悬停状态下的按钮样式
  static _ButtonColorStyle buttonHover(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $elTheme = context.elTheme;
    final $themeColor = bgColor ?? context.elThemeColors[type];
    Color? $bgColor;
    late Color $textColor;
    late Color $borderColor;

    if ($themeColor == null) {
      $bgColor = $elTheme.primary.themeLightBg(context);
      $textColor = $elTheme.primary;
      $borderColor = $elTheme.primary.themeLightBorder(context);
    } else {
      $bgColor = $themeColor.hover(context);
      $textColor = $themeColor.elTextColor(context);
      $borderColor = $themeColor.hover(context);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  /// 激活状态下的按钮样式
  static _ButtonColorStyle buttonActive(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $elTheme = context.elTheme;
    final $themeColor = bgColor ?? context.elThemeColors[type];
    Color? $bgColor;
    late Color $textColor;
    late Color $borderColor;

    if ($themeColor == null) {
      $bgColor = $elTheme.primary.themeLightBg(context);
      $textColor = $elTheme.primary;
      $borderColor = $elTheme.primary;
    } else {
      $bgColor = $themeColor.tap(context);
      $textColor = $themeColor.elTextColor(context);
      $borderColor = $themeColor.tap(context);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle plainButton(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $elTheme = context.elTheme;
    final $themeColor = bgColor ?? context.elThemeColors[type];
    Color? $bgColor;
    late Color $textColor;
    late Color $borderColor;

    if ($themeColor != null) {
      $bgColor = $themeColor.themeLightBg(context);
      $textColor = $themeColor;
      $borderColor = $themeColor.themeLightBorder(context);
    } else {
      $textColor = $elTheme.regularTextColor;
      $borderColor = $elTheme.borderColor;
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle plainButtonHover(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $elTheme = context.elTheme;
    final $themeColor = bgColor ?? context.elThemeColors[type];

    Color? $bgColor;
    late Color $textColor;
    late Color $borderColor;

    if ($themeColor != null) {
      $bgColor = $themeColor;
      $textColor = $themeColor.elTextColor(context);
      $borderColor = $themeColor;
    } else {
      $textColor = $elTheme.primary;
      $borderColor = $elTheme.primary.themeLightBorder(context);
    }

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
    );
  }

  static _ButtonColorStyle plainButtonActive(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $elTheme = context.elTheme;
    final $themeColor = bgColor ?? context.elThemeColors[type];

    if ($themeColor != null) {
      if (PlatformUtil.isDesktop) {
        return _ButtonColorStyle(
          bgColor: $themeColor.tap(context),
          textColor: $themeColor.elTextColor(context),
          borderColor: $themeColor.tap(context),
        );
      } else {
        return _ButtonColorStyle(
          bgColor: $themeColor,
          textColor: $themeColor.elTextColor(context),
          borderColor: $themeColor,
        );
      }
    } else {
      return _ButtonColorStyle(
        textColor: $elTheme.primary,
        borderColor: $elTheme.primary,
      );
    }
  }

  static _ButtonColorStyle textButton(
    BuildContext context, {
    String? type,
    Color? bgColor,
    bool bg = false,
  }) {
    final $elTheme = context.elTheme;
    final pageBgColor = $elTheme.bgColor;
    Color? $bgColor;
    if (bg) {
      $bgColor = pageBgColor.deepen(5);
    }

    var $textColor = type == null && bgColor == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!;

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
    );
  }

  static _ButtonColorStyle textButtonHover(
    BuildContext context, {
    String? type,
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

    var $textColor = type == null && bgColor == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!;

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
    );
  }

  static _ButtonColorStyle textButtonActive(
    BuildContext context, {
    String? type,
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

    var $textColor = type == null && bgColor == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!;

    return _ButtonColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
    );
  }

  static _ButtonColorStyle linkButton(BuildContext context, {String? type}) {
    final $elTheme = context.elTheme;

    var $textColor = (type == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!);

    return _ButtonColorStyle(
      textColor: $textColor,
    );
  }

  static _ButtonColorStyle linkButtonHover(BuildContext context,
      {String? type}) {
    final $elTheme = context.elTheme;

    var $textColor = (type == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!);

    return _ButtonColorStyle(
      textColor: $textColor.withOpacity(_disabledOpacity),
    );
  }

  static _ButtonColorStyle linkButtonActive(BuildContext context,
      {String? type}) {
    final $elTheme = context.elTheme;

    var $textColor = (type == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!);

    return _ButtonColorStyle(
      textColor: $textColor.tap(context),
    );
  }

  static _ButtonColorStyle loadingButton(
    BuildContext context, {
    String? type,
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
      $loadingTextColor = type == null && bgColor == null
          ? $elTheme.regularTextColor
          : context.elThemeColors[type]!;
    } else {
      $bgColor = $isDark
          ? const Color.fromRGBO(57, 57, 57, 1.0)
          : const Color.fromRGBO(224, 224, 224, 1.0);
      $loadingTextColor = $isDark
          ? const Color.fromRGBO(118, 118, 118, 1.0)
          : const Color.fromRGBO(166, 166, 166, 1.0);
      if ((type == null && bgColor == null) || plain) {
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
