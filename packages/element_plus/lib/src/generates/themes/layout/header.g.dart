// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/layout/header.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElHeaderThemeDataExtension on ElHeaderThemeData {
  /// 接收一组可选参数，返回新的对象
  ElHeaderThemeData copyWith({
    Color? color,
    double? height,
  }) {
    return ElHeaderThemeData(
      color: color ?? this.color,
      height: height ?? this.height,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElHeaderThemeData merge([ElHeaderThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      height: other.height,
    );
  }
}
