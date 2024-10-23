part of 'index.dart';

/// 按钮组选中模式下颜色样式预设，在 [_ButtonColors] 基础上新增 selected 选中状态，并对部分主题颜色进行调整
class _ButtonGroupColors {
  _ButtonGroupColors._();

  /// 计算按钮组颜色样式
  static _ButtonColorStyle calcButtonColorStyle(
    BuildContext context, {
    required _ButtonProp prop,
    required bool isTap,
    required bool isHover,
    required bool isSelected,
  }) {
    late _ButtonColorStyle colors;
    if (prop.loadingBuilder != null && prop.loading) {
      return _ButtonColors.loadingButton(
        context,
        bgColor: prop.bgColor,
        link: prop.link,
        text: prop.text,
        plain: prop.plain,
      );
    } else {
      if (prop.text) {
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
          );
        }
      } else if (prop.plain) {
        if (prop.bgColor == null) {
          if (isTap) {
            colors = _ButtonColors.plainButtonActive(context);
          } else if (isHover) {
            colors = _ButtonColors.plainButtonHover(context);
          } else {
            colors =
                _ButtonColors.plainButton(context, disabled: prop.disabled);
          }
        } else {
          if (isTap) {
            colors = _ButtonColors.themeButtonActive(
              context,
              bgColor: prop.bgColor!,
            );
          } else if (isHover) {
            colors = _ButtonColors.themeButton(
              context,
              bgColor: prop.bgColor!,
            );
          } else {
            colors = _ButtonColors.plainThemeButton(
              context,
              bgColor: prop.bgColor!,
              disabled: prop.disabled,
            );
          }
        }
      } else {
        if (prop.bgColor != null) {
          if (isTap) {
            colors = _ButtonColors.themeButtonActive(
              context,
              bgColor: prop.bgColor!,
            );
          } else if (isHover) {
            colors = _ButtonColors.themeButtonHover(
              context,
              bgColor: prop.bgColor!,
            );
          } else {
            colors = _ButtonColors.themeButton(
              context,
              bgColor: prop.bgColor!,
              disabled: prop.disabled,
            );
          }
        } else {
          if (isTap) {
            colors = _ButtonColors.buttonActive(context);
          } else if (isHover) {
            colors = _ButtonColors.buttonHover(context);
          } else {
            colors = _ButtonColors.button(context, disabled: prop.disabled);
          }
        }
      }
    }

    return colors;
  }

  static _ButtonColorStyle defaultButtonSelected(BuildContext context) {
    final $elTheme = context.elTheme;
    return _ButtonColorStyle(
      bgColor: $elTheme.bgColor,
      textColor: $elTheme.primary,
      borderColor: $elTheme.primary,
    );
  }

  static _ButtonColorStyle themeButtonHover(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $themeColor = bgColor ?? context.elThemeColors[type];
    assert($themeColor != null);
    return _ButtonColorStyle(
      bgColor: $themeColor!.hover(context),
      textColor: $themeColor.elTextColor(context),
    );
  }

  static _ButtonColorStyle themeButtonActive(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $themeColor = bgColor ?? context.elThemeColors[type];
    assert($themeColor != null);
    return _ButtonColorStyle(
      bgColor: $themeColor!.tap(context),
      textColor: $themeColor.elTextColor(context),
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
}
