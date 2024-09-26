// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/app/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElColorDataExtension on ElColorData {
  ElColorData copyWith({
    Color? bg,
    Color? icon,
    Color? text,
    Color? regularText,
    Color? secondaryText,
    Color? placeholderText,
    Color? border,
  }) {
    return ElColorData(
      bg: bg ?? this.bg,
      icon: icon ?? this.icon,
      text: text ?? this.text,
      regularText: regularText ?? this.regularText,
      secondaryText: secondaryText ?? this.secondaryText,
      placeholderText: placeholderText ?? this.placeholderText,
      border: border ?? this.border,
    );
  }

  ElColorData merge([ElColorData? other]) {
    if (other == null) return this;
    return copyWith(
      bg: other.bg,
      icon: other.icon,
      text: other.text,
      regularText: other.regularText,
      secondaryText: other.secondaryText,
      placeholderText: other.placeholderText,
      border: other.border,
    );
  }
}

extension ElConfigDataExtension on ElConfigData {
  ElConfigData copyWith({
    double? baseHeight,
    BorderRadius? radius,
    Duration? themeDuration,
    Curve? themeCurve,
  }) {
    return ElConfigData(
      baseHeight: baseHeight ?? this.baseHeight,
      radius: radius ?? this.radius,
      themeDuration: themeDuration ?? this.themeDuration,
      themeCurve: themeCurve ?? this.themeCurve,
    );
  }

  ElConfigData merge([ElConfigData? other]) {
    if (other == null) return this;
    return copyWith(
      baseHeight: other.baseHeight,
      radius: other.radius,
      themeDuration: other.themeDuration,
      themeCurve: other.themeCurve,
    );
  }
}

extension ElThemeDataExtension on ElThemeData {
  ElThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    ElColorData? colors,
    ElButtonThemeData? buttonTheme,
    ElLinkThemeData? linkTheme,
    ElInputThemeData? inputTheme,
    ElCollapseThemeData? collapseTheme,
    ElProgressThemeData? progressTheme,
    ElCardThemeData? cardTheme,
    ElModalThemeData? modalTheme,
    ElMessageThemeData? messageTheme,
    ElToastThemeData? toastTheme,
    ElTooltipThemeData? tooltipTheme,
    ElSliderThemeData? sliderTheme,
    ElHeaderThemeData? headerTheme,
    ElAsideThemeData? asideTheme,
    ElNavMenuThemeData? navigationMenuTheme,
    ElCodePreviewThemeData? codePreviewTheme,
  }) {
    return ElThemeData(
      primary: primary ?? this.primary,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      colors: this.colors.merge(colors),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      navigationMenuTheme: this.navigationMenuTheme.merge(navigationMenuTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
    );
  }

  ElThemeData merge([ElThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      primary: other.primary,
      success: other.success,
      info: other.info,
      warning: other.warning,
      error: other.error,
      colors: colors?.merge(other.colors),
      buttonTheme: buttonTheme?.merge(other.buttonTheme),
      linkTheme: linkTheme?.merge(other.linkTheme),
      inputTheme: inputTheme?.merge(other.inputTheme),
      collapseTheme: collapseTheme?.merge(other.collapseTheme),
      progressTheme: progressTheme?.merge(other.progressTheme),
      cardTheme: cardTheme?.merge(other.cardTheme),
      modalTheme: modalTheme?.merge(other.modalTheme),
      messageTheme: messageTheme?.merge(other.messageTheme),
      toastTheme: toastTheme?.merge(other.toastTheme),
      tooltipTheme: tooltipTheme?.merge(other.tooltipTheme),
      sliderTheme: sliderTheme?.merge(other.sliderTheme),
      headerTheme: headerTheme?.merge(other.headerTheme),
      asideTheme: asideTheme?.merge(other.asideTheme),
      navigationMenuTheme:
          navigationMenuTheme?.merge(other.navigationMenuTheme),
      codePreviewTheme: codePreviewTheme?.merge(other.codePreviewTheme),
    );
  }
}
