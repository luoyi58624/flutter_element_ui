// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/feedback/tooltip.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTooltipStyleExtension on ElTooltipStyle {
  ElTooltipStyle copyWith({
    Color? color,
    bool? enableFeedback,
  }) {
    return ElTooltipStyle(
      color: color ?? this.color,
      enableFeedback: enableFeedback ?? this.enableFeedback,
    );
  }

  ElTooltipStyle merge([ElTooltipStyle? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      enableFeedback: other.enableFeedback,
    );
  }
}
