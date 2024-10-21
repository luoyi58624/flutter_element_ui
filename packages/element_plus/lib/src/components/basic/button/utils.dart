part of 'index.dart';

class _ButtonStyleUtil {
  static _ColorStyle defaultStyle(
    BuildContext context, {
    required bool disabled,
    bool triggerEvent = true,
  }) {
    final $isHover = triggerEvent && context.isHover;
    final $isTap = triggerEvent && context.isTap;
    final $elTheme = context.elTheme;
    final $defaultBorderColor = $elTheme.borderColor;

    var $bgColor = $isTap || $isHover
        ? $elTheme.primary.themeLightBg(context)
        : $elTheme.bgColor;

    var $textColor =
        $isTap || $isHover ? $elTheme.primary : $elTheme.regularTextColor;
    if (disabled) {
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
    }

    var $borderColor = $isTap
        ? $elTheme.primary
        : $isHover
            ? $elTheme.primary.themeLightBorder(context)
            : $defaultBorderColor;

    if (disabled) {
      $borderColor = $borderColor.withOpacity(_disabledOpacity);
    }

    return (
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
      loadingTextColor: null,
    );
  }

  static _ColorStyle themeStyle(
    BuildContext context, {
    required String? type,
    required Color? bgColor,
    required bool disabled,
    bool triggerEvent = true,
  }) {
    final $isHover = triggerEvent && context.isHover;
    final $isTap = triggerEvent && context.isTap;
    final $themeColor = bgColor ?? context.elThemeColors[type]!;

    var $bgColor = $isTap
        ? $themeColor.tap(context)
        : $isHover
            ? $themeColor.hover(context)
            : $themeColor;

    var $textColor = $themeColor.elTextColor(context);
    if (disabled) {
      $bgColor = $bgColor.withOpacity(_disabledOpacity);
      $textColor = $textColor.withOpacity(_themeButtonTextDisabledOpacity);
    }

    return (
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle plainStyle(
    BuildContext context, {
    required String? type,
    required Color? bgColor,
    required bool disabled,
    bool triggerEvent = true,
  }) {
    final $isHover = triggerEvent && context.isHover;
    final $isTap = triggerEvent && context.isTap;
    final $themeColor = bgColor ?? context.elThemeColors[type]!;

    var $bgColor = PlatformUtil.isDesktop
        ? ($isTap
            ? $themeColor.tap(context)
            : $isHover
                ? $themeColor
                : $themeColor.themeLightBg(context))
        : ($isTap ? $themeColor : $themeColor.themeLightBg(context));

    var $textColor =
        $isTap || $isHover ? $themeColor.elTextColor(context) : $themeColor;

    var $borderColor = PlatformUtil.isDesktop
        ? ($isTap
            ? $themeColor.tap(context)
            : $isHover
                ? $themeColor
                : $themeColor.themeLightBorder(context))
        : ($isTap ? $themeColor : $themeColor.themeLightBorder(context));

    if (disabled) {
      $bgColor = $bgColor.withOpacity(_disabledOpacity);
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
      $borderColor = $borderColor.withOpacity(_disabledOpacity);
    }

    return (
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
      loadingTextColor: null,
    );
  }

  static _ColorStyle textStyle(
    BuildContext context, {
    required String? type,
    required Color? bgColor,
    required bool bg,
    required bool disabled,
    bool triggerEvent = true,
  }) {
    final $isHover = triggerEvent && context.isHover;
    final $isTap = triggerEvent && context.isTap;
    final $elTheme = context.elTheme;

    final pageBgColor = $elTheme.bgColor;
    Color? $bgColor;
    if (bg) {
      $bgColor = pageBgColor
          .deepen(4)
          .on($isHover, color: pageBgColor.deepen(10))
          .on($isTap, color: pageBgColor.deepen(16));
    } else {
      if ($isTap) {
        $bgColor = pageBgColor.deepen(10);
      } else if ($isHover) {
        $bgColor = pageBgColor.deepen(4);
      }
    }
    var $textColor = type == null && bgColor == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!;
    if (disabled) {
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
    }

    return (
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle linkStyle(
    BuildContext context, {
    required String? type,
    required bool disabled,
    bool triggerEvent = true,
  }) {
    final $isHover = triggerEvent && context.isHover;
    final $isTap = triggerEvent && context.isTap;
    final $elTheme = context.elTheme;

    var $textColor = (type == null
        ? $elTheme.regularTextColor
        : context.elThemeColors[type]!);
    $textColor = $textColor
        .on($isHover, color: $textColor.withOpacity(_disabledOpacity))
        .on($isTap, color: $textColor.tap(context));
    if (disabled) {
      $textColor = $textColor.withOpacity(_textDisabledOpacity);
    }

    return (
      bgColor: null,
      textColor: $textColor,
      borderColor: null,
      loadingTextColor: null,
    );
  }

  static _ColorStyle loadingStyle(
    BuildContext context, {
    required String? type,
    required Color? bgColor,
    required bool link,
    required bool text,
    required bool plain,
  }) {
    final $elTheme = context.elTheme;
    final $isDark = context.isDark;

    Color? $loadingTextColor;
    Color? $bgColor;
    Color? $borderColor;

    if (link || text) {
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

    return (
      bgColor: $bgColor,
      textColor: null,
      borderColor: $borderColor,
      loadingTextColor: $loadingTextColor,
    );
  }
}
