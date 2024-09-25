// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/basic/button.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButtonStyleExtension on ElButtonThemeData {
  ElButtonThemeData copyWith({
    double? height,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
  }) {
    return ElButtonThemeData(
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
    );
  }

  ElButtonThemeData merge([ElButtonThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      height: other.height,
      borderRadius: other.borderRadius,
      padding: other.padding,
    );
  }
}
