// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/form/input.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElInputStyleExtension on ElInputThemeData {
  ElInputThemeData copyWith({
    double? height,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    TextStyle? textStyle,
  }) {
    return ElInputThemeData(
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
      textStyle: this.textStyle.merge(textStyle),
    );
  }

  ElInputThemeData merge([ElInputThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      height: other.height,
      borderRadius: other.borderRadius,
      margin: other.margin,
      padding: other.padding,
      textStyle: textStyle?.merge(other.textStyle),
    );
  }
}
