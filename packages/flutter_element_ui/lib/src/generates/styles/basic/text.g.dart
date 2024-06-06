// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/basic/text.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTextStyleExtension on ElTextStyle {
  ElTextStyle copyWith({
    TextStyle? textStyle,
    StrutStyle? strutStyle,
  }) {
    return ElTextStyle(
      textStyle: this.textStyle?.merge(textStyle),
      strutStyle: strutStyle ?? this.strutStyle,
    );
  }

  ElTextStyle merge([ElTextStyle? other]) {
    if (other == null) return this;
    return copyWith(
      textStyle: textStyle?.merge(other.textStyle),
      strutStyle: other.strutStyle,
    );
  }
}
