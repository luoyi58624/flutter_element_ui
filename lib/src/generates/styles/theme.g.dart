// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../styles/theme.dart';

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
    Color? bgColor,
    Color? headerColor,
    Color? asideBgColor,
    Color? cardColor,
    Color? modalColor,
    Color? titleColor,
    Color? textColor,
    Color? iconColor,
    Color? borderColor,
    Color? menuActiveColor,
    Color? sliderActiveColor,
    Color? sliderInactiveColor,
    Color? tooltipColor,
    double? cardElevation,
    double? modalElevation,
  }) {
    return ElThemeData(
      primary: primary ?? this.primary,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      bgColor: bgColor ?? this.bgColor,
      headerColor: headerColor ?? this.headerColor,
      asideBgColor: asideBgColor ?? this.asideBgColor,
      cardColor: cardColor ?? this.cardColor,
      modalColor: modalColor ?? this.modalColor,
      titleColor: titleColor ?? this.titleColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
      menuActiveColor: menuActiveColor ?? this.menuActiveColor,
      sliderActiveColor: sliderActiveColor ?? this.sliderActiveColor,
      sliderInactiveColor: sliderInactiveColor ?? this.sliderInactiveColor,
      tooltipColor: tooltipColor ?? this.tooltipColor,
      cardElevation: cardElevation ?? this.cardElevation,
      modalElevation: modalElevation ?? this.modalElevation,
    );
  }
}

extension ElConfigDataExtension on ElConfigData {
  ElConfigData copyWith({
    double? iconSize,
    BorderRadius? radius,
    BorderRadius? cardRadius,
    int? bgTransition,
    int? collapseDuration,
    TextStyle? textStyle,
    ElButtonStyle? buttonStyle,
    ElInputStyle? inputStyle,
  }) {
    return ElConfigData(
      iconSize: iconSize ?? this.iconSize,
      radius: radius ?? this.radius,
      cardRadius: cardRadius ?? this.cardRadius,
      bgTransition: bgTransition ?? this.bgTransition,
      collapseDuration: collapseDuration ?? this.collapseDuration,
      textStyle: this.textStyle.merge(textStyle),
      buttonStyle: this.buttonStyle.merge(buttonStyle),
      inputStyle: this.inputStyle.merge(inputStyle),
    );
  }
}
