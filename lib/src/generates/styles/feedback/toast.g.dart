// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/feedback/toast.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElToastStyleExtension on ElToastThemeData {
  ElToastThemeData copyWith({
    int? closeDuration,
    bool? enableFeedback,
    Widget Function(BuildContext, dynamic)? builder,
  }) {
    return ElToastThemeData(
      closeDuration: closeDuration ?? this.closeDuration,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      builder: builder ?? this.builder,
    );
  }

  ElToastThemeData merge([ElToastThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      closeDuration: other.closeDuration,
      enableFeedback: other.enableFeedback,
      builder: other.builder,
    );
  }
}
