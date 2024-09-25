// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/data/progress.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElProgressDataExtension on ElProgressData {
  ElProgressData copyWith({
    Duration? duration,
    Curve? curve,
    Curve? secondCurve,
  }) {
    return ElProgressData(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
      secondCurve: secondCurve ?? this.secondCurve,
    );
  }

  ElProgressData merge([ElProgressData? other]) {
    if (other == null) return this;
    return copyWith(
      duration: other.duration,
      curve: other.curve,
      secondCurve: other.secondCurve,
    );
  }
}
