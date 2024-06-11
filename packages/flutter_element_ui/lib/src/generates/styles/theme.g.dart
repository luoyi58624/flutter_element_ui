// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../styles/theme.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElColorThemeDataExtension on ElColorThemeData {
  ElColorThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    Color? bgColor,
    Color? headerColor,
    Color? cardColor,
    Color? modalColor,
    Color? titleColor,
    Color? textColor,
    Color? iconColor,
    Color? borderColor,
    Color? menuBackground,
    Color? menuActiveColor,
    double? cardElevation,
    double? modalElevation,
  }) {
    return ElColorThemeData(
      primary: primary ?? this.primary,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      bgColor: bgColor ?? this.bgColor,
      headerColor: headerColor ?? this.headerColor,
      cardColor: cardColor ?? this.cardColor,
      modalColor: modalColor ?? this.modalColor,
      titleColor: titleColor ?? this.titleColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
      menuBackground: menuBackground ?? this.menuBackground,
      menuActiveColor: menuActiveColor ?? this.menuActiveColor,
      cardElevation: cardElevation ?? this.cardElevation,
      modalElevation: modalElevation ?? this.modalElevation,
    );
  }
}

extension ElConfigDataExtension on ElConfigData {
  ElConfigData copyWith({
    double? iconSize,
    ElButtonStyle? buttonStyle,
    ElScrollConfigurationData? scrollConfiguration,
    double? inputRadius,
    double? cardRadius,
  }) {
    return ElConfigData(
      iconSize: iconSize ?? this.iconSize,
      buttonStyle: this.buttonStyle.merge(buttonStyle),
      scrollConfiguration: this.scrollConfiguration.merge(scrollConfiguration),
      inputRadius: inputRadius ?? this.inputRadius,
      cardRadius: cardRadius ?? this.cardRadius,
    );
  }
}

extension ElResponsiveDataExtension on ElResponsiveData {
  ElResponsiveData copyWith({
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return ElResponsiveData(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }
}
