part of 'index.dart';

/// 按钮颜色样式预设，封装各种类型按钮在 default、hover、active 三种状态下的颜色主题
class _Preset {
  static _ColorStyle defaultButton(BuildContext context) {
    final $elTheme = context.elTheme;
    return _ColorStyle(
      bgColor: $elTheme.bgColor,
      textColor: $elTheme.regularTextColor,
      borderColor: $elTheme.borderColor,
      loadingTextColor: null,
    );
  }

  static _ColorStyle defaultButtonHover(BuildContext context) {
    final $elTheme = context.elTheme;
    return _ColorStyle(
      bgColor: $elTheme.primary.themeLightBg(context),
      textColor: $elTheme.primary,
      borderColor: $elTheme.primary.themeLightBorder(context),
      loadingTextColor: null,
    );
  }

  static _ColorStyle defaultButtonActive(BuildContext context) {
    final $elTheme = context.elTheme;
    return _ColorStyle(
      bgColor: $elTheme.primary.themeLightBg(context),
      textColor: $elTheme.primary,
      borderColor: $elTheme.primary,
      loadingTextColor: null,
    );
  }

  static _ColorStyle themeButton(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $themeColor = bgColor ?? context.elThemeColors[type];
    assert($themeColor != null);
    return _ColorStyle(
      bgColor: $themeColor,
      textColor: $themeColor!.elTextColor(context),
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle themeButtonHover(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $themeColor = bgColor ?? context.elThemeColors[type];
    assert($themeColor != null);
    return _ColorStyle(
      bgColor: $themeColor!.hover(context),
      textColor: $themeColor.elTextColor(context),
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle themeButtonActive(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $themeColor = bgColor ?? context.elThemeColors[type];
    assert($themeColor != null);
    return _ColorStyle(
      bgColor: $themeColor!.tap(context),
      textColor: $themeColor.elTextColor(context),
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle plainButton(
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

    return _ColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
      loadingTextColor: null,
    );
  }

  static _ColorStyle plainButtonHover(
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

    return _ColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
      loadingTextColor: null,
    );
  }

  static _ColorStyle plainButtonActive(
    BuildContext context, {
    String? type,
    Color? bgColor,
  }) {
    final $elTheme = context.elTheme;
    final $themeColor = bgColor ?? context.elThemeColors[type];

    if ($themeColor != null) {
      if (PlatformUtil.isDesktop) {
        return _ColorStyle(
          bgColor: $themeColor.tap(context),
          textColor: $themeColor.elTextColor(context),
          borderColor: $themeColor.tap(context),
        );
      } else {
        return _ColorStyle(
          bgColor: $themeColor,
          textColor: $themeColor.elTextColor(context),
          borderColor: $themeColor,
        );
      }
    } else {
      return _ColorStyle(
        textColor: $elTheme.primary,
        borderColor: $elTheme.primary,
      );
    }
  }

  static _ColorStyle textButton(
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

    return _ColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle textButtonHover(
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

    return _ColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle textButtonActive(
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

    return _ColorStyle(
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle linkButton(BuildContext context, {String? type}) {
    final $elTheme = context.elTheme;

    var $textColor = (type == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!);

    return _ColorStyle(
      bgColor: null,
      textColor: $textColor,
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle linkButtonHover(BuildContext context, {String? type}) {
    final $elTheme = context.elTheme;

    var $textColor = (type == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!);

    return _ColorStyle(
      bgColor: null,
      textColor: $textColor.withOpacity(_disabledOpacity),
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle linkButtonActive(BuildContext context, {String? type}) {
    final $elTheme = context.elTheme;

    var $textColor = (type == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!);

    return _ColorStyle(
      bgColor: null,
      textColor: $textColor.tap(context),
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle loadingButton(
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

    return _ColorStyle(
      bgColor: $bgColor,
      textColor: null,
      borderColor: $borderColor,
      loadingTextColor: $loadingTextColor,
    );
  }
}

class _ButtonGroupUtil {
  static bool isSelected(dynamic modelValue, int index) {
    // 如果是按钮组，则将选中的值作为悬停状态
    if (modelValue != null) {
      if (modelValue is List) {
        if (modelValue.contains(index)) {
          return true;
        }
      } else if (modelValue == index) {
        return true;
      }
    }

    return false;
  }
}
