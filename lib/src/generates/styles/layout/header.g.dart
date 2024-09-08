// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/layout/header.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElHeaderStyleExtension on ElHeaderStyle {
  ElHeaderStyle copyWith({
    Color? color,
    double? height,
  }) {
    return ElHeaderStyle(
      color: color ?? this.color,
      height: height ?? this.height,
    );
  }

  ElHeaderStyle merge([ElHeaderStyle? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      height: other.height,
    );
  }
}
