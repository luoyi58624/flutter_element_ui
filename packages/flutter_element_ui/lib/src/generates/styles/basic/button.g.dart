// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/basic/button.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButtonStyleExtension on ElButtonStyle {
  ElButtonStyle copyWith({
    double? height,
    BorderRadiusGeometry? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElButtonStyle(
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }

  ElButtonStyle merge([ElButtonStyle? other]) {
    if (other == null) return this;
    return copyWith(
      height: other.height,
      borderRadius: other.borderRadius,
      padding: other.padding,
    );
  }
}
