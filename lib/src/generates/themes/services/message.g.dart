// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/services/message.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElMessageThemeDataExtension on ElMessageThemeData {
  ElMessageThemeData copyWith({
    double? offset,
    int? closeDuration,
    int? animationDuration,
    bool? showClose,
    bool? grouping,
    Widget Function(BuildContext, ElMessageModel)? builder,
  }) {
    return ElMessageThemeData(
      offset: offset ?? this.offset,
      closeDuration: closeDuration ?? this.closeDuration,
      animationDuration: animationDuration ?? this.animationDuration,
      showClose: showClose ?? this.showClose,
      grouping: grouping ?? this.grouping,
      builder: builder ?? this.builder,
    );
  }

  ElMessageThemeData merge([ElMessageThemeData? other]) {
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
