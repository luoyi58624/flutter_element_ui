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
    Duration? globalDuration,
    Duration? colorDuration,
    TextStyle? textStyle,
    ElButtonStyle? buttonStyle,
    ElInputStyle? inputStyle,
    ElMessageStyle? messageStyle,
    ElToastStyle? toastStyle,
  }) {
    return ElConfigData(
      iconSize: iconSize ?? this.iconSize,
      radius: radius ?? this.radius,
      cardRadius: cardRadius ?? this.cardRadius,
      globalDuration: globalDuration ?? this.globalDuration,
      colorDuration: colorDuration ?? this.colorDuration,
      textStyle: this.textStyle.merge(textStyle),
      buttonStyle: this.buttonStyle.merge(buttonStyle),
      inputStyle: this.inputStyle.merge(inputStyle),
      messageStyle: this.messageStyle.merge(messageStyle),
      toastStyle: this.toastStyle.merge(toastStyle),
    );
  }
}
