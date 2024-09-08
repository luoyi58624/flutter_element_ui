// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../styles/config_data.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElConfigDataExtension on ElConfigData {
  ElConfigData copyWith({
    double? baseHeight,
    BorderRadius? radius,
    bool? enableFeedback,
    Duration? themeDuration,
    Curve? themeCurve,
  }) {
    return ElConfigData(
      baseHeight: baseHeight ?? this.baseHeight,
      radius: radius ?? this.radius,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      themeDuration: themeDuration ?? this.themeDuration,
      themeCurve: themeCurve ?? this.themeCurve,
    );
  }

  ElConfigData merge([ElConfigData? other]) {
    if (other == null) return this;
    return copyWith(
      baseHeight: other.baseHeight,
      radius: other.radius,
      enableFeedback: other.enableFeedback,
      themeDuration: other.themeDuration,
      themeCurve: other.themeCurve,
    );
  }
}