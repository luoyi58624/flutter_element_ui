// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/services/toast.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElToastThemeDataExtension on ElToastThemeData {
  /// 接收一组可选参数，返回新的对象
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

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElToastThemeData merge([ElToastThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      closeDuration: other.closeDuration,
      enableFeedback: other.enableFeedback,
      builder: other.builder,
    );
  }
}
