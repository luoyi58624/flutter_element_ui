// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../styles/feedback/message.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElMessageStyleExtension on ElMessageStyle {
  ElMessageStyle copyWith({
    double? offset,
    int? closeDuration,
    int? animationDuration,
    bool? showClose,
    bool? grouping,
    Widget Function(BuildContext, ElMessage)? builder,
  }) {
    return ElMessageStyle(
      offset: offset ?? this.offset,
      closeDuration: closeDuration ?? this.closeDuration,
      animationDuration: animationDuration ?? this.animationDuration,
      showClose: showClose ?? this.showClose,
      grouping: grouping ?? this.grouping,
      builder: builder ?? this.builder,
    );
  }

  ElMessageStyle merge([ElMessageStyle? other]) {
    if (other == null) return this;
    return copyWith(
      offset: other.offset,
      closeDuration: other.closeDuration,
      animationDuration: other.animationDuration,
      showClose: other.showClose,
      grouping: other.grouping,
      builder: other.builder,
    );
  }
}
