// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/basic/icon.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElIconStyleExtension on ElIconStyle {
  ElIconStyle copyWith({
    dynamic? icon,
    double? size,
    Color? color,
  }) {
    return ElIconStyle(
      icon: icon ?? this.icon,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }

  ElIconStyle merge([ElIconStyle? other]) {
    if (other == null) return this;
    return copyWith(
      icon: other.icon,
      size: other.size,
      color: other.color,
    );
  }
}
