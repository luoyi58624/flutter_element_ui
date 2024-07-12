// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../styles/theme.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElColorThemeDataExtension on ElBrightnessData {
  ElBrightnessData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    Color? bgColor,
    Color? headerColor,
    Color? cardColor,
    Color? titleColor,
    Color? textColor,
    Color? iconColor,
    Color? borderColor,
    Color? asideBgColor,
    Color? menuActiveColor,
    double? cardElevation,
    double? modalElevation,
  }) {
    return ElBrightnessData(
      primary: primary ?? this.primary,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      bgColor: bgColor ?? this.bgColor,
      headerColor: headerColor ?? this.headerColor,
      cardColor: cardColor ?? this.cardColor,
      titleColor: titleColor ?? this.titleColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
      asideBgColor: asideBgColor ?? this.asideBgColor,
      menuActiveColor: menuActiveColor ?? this.menuActiveColor,
      cardElevation: cardElevation ?? this.cardElevation,
      modalElevation: modalElevation ?? this.modalElevation,
    );
  }
}

extension ElConfigDataExtension on ElConfigData {
  ElConfigData copyWith({
    double? fonSize,
    double? iconSize,
    double? radius,
    double? cardRadius,
    ElButtonStyle? buttonStyle,
  }) {
    return ElConfigData(
      fonSize: fonSize ?? this.fonSize,
      radius: radius ?? this.radius,
      cardRadius: cardRadius ?? this.cardRadius,
      buttonStyle: this.buttonStyle.merge(buttonStyle),
    );
  }
}
