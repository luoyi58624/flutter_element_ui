// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/feedback/message/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElMessageThemeDataExtension on ElMessageThemeData {
  /// 接收一组可选参数，返回新的对象
  ElMessageThemeData copyWith({
    double? offset,
    Duration? closeDuration,
    Duration? animationDuration,
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

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
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
