// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/basic/button.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButtonStyleExtension on ElButtonStyle {
  ElButtonStyle copyWith({
    double? height,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    Duration? animatedDuration,
    bool? enableFeedback,
  }) {
    return ElButtonStyle(
      height: height ?? this.height,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      animatedDuration: animatedDuration ?? this.animatedDuration,
      enableFeedback: enableFeedback ?? this.enableFeedback,
    );
  }

  ElButtonStyle merge([ElButtonStyle? other]) {
    if (other == null) return this;
    return copyWith(
      height: other.height,
      borderRadius: other.borderRadius,
      padding: other.padding,
      animatedDuration: other.animatedDuration,
      enableFeedback: other.enableFeedback,
    );
  }
}
