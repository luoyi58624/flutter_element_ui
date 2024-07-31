// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../styles/config.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElConfigDataExtension on ElConfigData {
  ElConfigData copyWith({
    double? baseWidgetHeight,
    double? iconSize,
    BorderRadius? radius,
    BorderRadius? cardRadius,
    Duration? colorDuration,
    Duration? globalDuration,
    TextStyle? textStyle,
    ElButtonStyle? buttonStyle,
    ElInputStyle? inputStyle,
    ElMessageStyle? messageStyle,
  }) {
    return ElConfigData(
      baseWidgetHeight: baseWidgetHeight ?? this.baseWidgetHeight,
      iconSize: iconSize ?? this.iconSize,
      radius: radius ?? this.radius,
      cardRadius: cardRadius ?? this.cardRadius,
      colorDuration: colorDuration ?? this.colorDuration,
      globalDuration: globalDuration ?? this.globalDuration,
      textStyle: this.textStyle.merge(textStyle),
      buttonStyle: this.buttonStyle.merge(buttonStyle),
      inputStyle: this.inputStyle.merge(inputStyle),
      messageStyle: this.messageStyle.merge(messageStyle),
    );
  }
}
