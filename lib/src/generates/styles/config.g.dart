// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../styles/config.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

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
