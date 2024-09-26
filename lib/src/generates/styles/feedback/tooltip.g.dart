// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/feedback/tooltip.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTooltipThemeDataExtension on ElTooltipThemeData {
  ElTooltipThemeData copyWith({
    Color? color,
    bool? enableFeedback,
  }) {
    return ElTooltipThemeData(
      color: color ?? this.color,
      enableFeedback: enableFeedback ?? this.enableFeedback,
    );
  }

  ElTooltipThemeData merge([ElTooltipThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      enableFeedback: other.enableFeedback,
    );
  }
}
