// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/feedback/message.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElMessageStyleExtension on ElMessageStyle {
  ElMessageStyle copyWith({
    double? offset,
    int? messageDuration,
    int? animationDuration,
    bool? showClose,
    bool? grouping,
  }) {
    return ElMessageStyle(
      offset: offset ?? this.offset,
      messageDuration: messageDuration ?? this.messageDuration,
      animationDuration: animationDuration ?? this.animationDuration,
      showClose: showClose ?? this.showClose,
      grouping: grouping ?? this.grouping,
    );
  }

  ElMessageStyle merge([ElMessageStyle? other]) {
    if (other == null) return this;
    return copyWith(
      offset: other.offset,
      messageDuration: other.messageDuration,
      animationDuration: other.animationDuration,
      showClose: other.showClose,
      grouping: other.grouping,
    );
  }
}
