// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/services/message.dart';

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

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

extension ElMessageThemeDataLerpExtension on ElMessageThemeData {
  /// 默认主题动画线性插值
  ElMessageThemeData lerp(
      ElMessageThemeData a, ElMessageThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElMessageThemeData(
      offset: lerpDouble(a.offset, b.offset, t) ?? a.offset,
      closeDuration: t < 0.5 ? a.closeDuration : b.closeDuration,
      animationDuration: t < 0.5 ? a.animationDuration : b.animationDuration,
      showClose: t < 0.5 ? a.showClose : b.showClose,
      grouping: t < 0.5 ? a.grouping : b.grouping,
      builder: t < 0.5 ? a.builder : b.builder,
    );
  }
}
