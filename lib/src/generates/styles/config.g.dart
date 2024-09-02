// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../styles/config.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElConfigDataExtension on ElConfigData {
  ElConfigData copyWith({
    double? headerHeight,
    double? baseHeight,
    double? iconSize,
    BorderRadius? radius,
    BorderRadius? cardRadius,
    bool? enableFeedback,
    TextStyle? textStyle,
    ElButtonStyle? buttonStyle,
    ElLinkStyle? linkStyle,
    ElInputStyle? inputStyle,
    ElMessageStyle? messageStyle,
    ElToastStyle? toastStyle,
  }) {
    return ElConfigData(
      headerHeight: headerHeight ?? this.headerHeight,
      baseHeight: baseHeight ?? this.baseHeight,
      iconSize: iconSize ?? this.iconSize,
      radius: radius ?? this.radius,
      cardRadius: cardRadius ?? this.cardRadius,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      textStyle: this.textStyle.merge(textStyle),
      buttonStyle: this.buttonStyle.merge(buttonStyle),
      linkStyle: this.linkStyle.merge(linkStyle),
      inputStyle: this.inputStyle.merge(inputStyle),
      messageStyle: this.messageStyle.merge(messageStyle),
      toastStyle: this.toastStyle.merge(toastStyle),
    );
  }

  ElConfigData merge([ElConfigData? other]) {
    if (other == null) return this;
    return copyWith(
      headerHeight: other.headerHeight,
      baseHeight: other.baseHeight,
      iconSize: other.iconSize,
      radius: other.radius,
      cardRadius: other.cardRadius,
      enableFeedback: other.enableFeedback,
      textStyle: textStyle?.merge(other.textStyle),
      buttonStyle: buttonStyle?.merge(other.buttonStyle),
      linkStyle: linkStyle?.merge(other.linkStyle),
      inputStyle: inputStyle?.merge(other.inputStyle),
      messageStyle: messageStyle?.merge(other.messageStyle),
      toastStyle: toastStyle?.merge(other.toastStyle),
    );
  }
}
