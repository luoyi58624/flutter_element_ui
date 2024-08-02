// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/feedback/toast.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElToastStyleExtension on ElToastStyle {
  ElToastStyle copyWith({
    int? closeDuration,
    bool? enableFeedback,
    Widget Function(BuildContext, dynamic)? builder,
  }) {
    return ElToastStyle(
      closeDuration: closeDuration ?? this.closeDuration,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      builder: builder ?? this.builder,
    );
  }

  ElToastStyle merge([ElToastStyle? other]) {
    if (other == null) return this;
    return copyWith(
      closeDuration: other.closeDuration,
      enableFeedback: other.enableFeedback,
      builder: other.builder,
    );
  }
}
