// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/config.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElConfigDataExtension on ElConfigData {
  ElConfigData copyWith({
    double? baseHeight,
    BorderRadius? radius,
    Duration? themeDuration,
    Curve? themeCurve,
  }) {
    return ElConfigData(
      baseHeight: baseHeight ?? this.baseHeight,
      radius: radius ?? this.radius,
      themeDuration: themeDuration ?? this.themeDuration,
      themeCurve: themeCurve ?? this.themeCurve,
    );
  }

  ElConfigData merge([ElConfigData? other]) {
    if (other == null) return this;
    return copyWith(
      baseHeight: other.baseHeight,
      radius: other.radius,
      themeDuration: other.themeDuration,
      themeCurve: other.themeCurve,
    );
  }
}
