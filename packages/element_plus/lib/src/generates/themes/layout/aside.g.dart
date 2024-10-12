// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/layout/aside.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElAsideThemeDataExtension on ElAsideThemeData {
  /// 接收一组可选参数，返回新的对象
  ElAsideThemeData copyWith({
    Color? color,
    double? width,
  }) {
    return ElAsideThemeData(
      color: color ?? this.color,
      width: width ?? this.width,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElAsideThemeData merge([ElAsideThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      width: other.width,
    );
  }
}
