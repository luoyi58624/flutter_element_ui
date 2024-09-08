// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/data/collapse.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElCollapseStyleExtension on ElCollapseStyle {
  ElCollapseStyle copyWith({
    bool? keepState,
    Duration? duration,
    Curve? curve,
  }) {
    return ElCollapseStyle(
      keepState: keepState ?? this.keepState,
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  ElCollapseStyle merge([ElCollapseStyle? other]) {
    if (other == null) return this;
    return copyWith(
      keepState: other.keepState,
      duration: other.duration,
      curve: other.curve,
    );
  }
}
