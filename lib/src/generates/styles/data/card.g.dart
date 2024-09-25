// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/data/card.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCardStyleExtension on ElCardThemeData {
  ElCardThemeData copyWith({
    Color? color,
    double? elevation,
    BorderRadius? radius,
  }) {
    return ElCardThemeData(
      color: color ?? this.color,
      elevation: elevation ?? this.elevation,
      radius: radius ?? this.radius,
    );
  }

  ElCardThemeData merge([ElCardThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      elevation: other.elevation,
      radius: other.radius,
    );
  }
}
