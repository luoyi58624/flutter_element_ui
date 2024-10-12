// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

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
      colors: colors.merge(other.colors),
      buttonTheme: buttonTheme.merge(other.buttonTheme),
      linkTheme: linkTheme.merge(other.linkTheme),
      inputTheme: inputTheme.merge(other.inputTheme),
      collapseTheme: collapseTheme.merge(other.collapseTheme),
      progressTheme: progressTheme.merge(other.progressTheme),
      cardTheme: cardTheme.merge(other.cardTheme),
      modalTheme: modalTheme.merge(other.modalTheme),
      messageTheme: messageTheme.merge(other.messageTheme),
      toastTheme: toastTheme.merge(other.toastTheme),
      tooltipTheme: tooltipTheme.merge(other.tooltipTheme),
      sliderTheme: sliderTheme.merge(other.sliderTheme),
      headerTheme: headerTheme.merge(other.headerTheme),
      asideTheme: asideTheme.merge(other.asideTheme),
      navigationMenuTheme: navigationMenuTheme.merge(other.navigationMenuTheme),
      codePreviewTheme: codePreviewTheme.merge(other.codePreviewTheme),
    );
  }
}
