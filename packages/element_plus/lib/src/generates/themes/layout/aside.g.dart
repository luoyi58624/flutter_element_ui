// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/layout/aside.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElAsideThemeDataExtension on ElAsideThemeData {
  ElAsideThemeData copyWith({
    Color? color,
    double? width,
  }) {
    return ElAsideThemeData(
      color: color ?? this.color,
      width: width ?? this.width,
    );
  }

  ElAsideThemeData merge([ElAsideThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      width: other.width,
    );
  }
}
