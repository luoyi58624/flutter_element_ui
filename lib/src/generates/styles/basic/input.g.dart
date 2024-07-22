// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/basic/input.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElInputStyleExtension on ElInputStyle {
  ElInputStyle copyWith({
    double? height,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    return ElInputStyle(
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      margin: margin ?? this.margin,
      padding: padding ?? this.padding,
    );
  }

  ElInputStyle merge([ElInputStyle? other]) {
    if (other == null) return this;
    return copyWith(
      height: other.height,
      borderRadius: other.borderRadius,
      margin: other.margin,
      padding: other.padding,
    );
  }
}
