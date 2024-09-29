// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/feedback/modal/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElModalThemeDataExtension on ElModalThemeData {
  ElModalThemeData copyWith({
    Color? color,
    double? elevation,
  }) {
    return ElModalThemeData(
      color: color ?? this.color,
      elevation: elevation ?? this.elevation,
    );
  }

  ElModalThemeData merge([ElModalThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      elevation: other.elevation,
    );
  }
}
