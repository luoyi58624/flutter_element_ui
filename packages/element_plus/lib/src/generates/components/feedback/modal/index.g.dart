// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/feedback/modal/index.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElModalThemeDataExtension on ElModalThemeData {
  /// 接收一组可选参数，返回新的对象
  ElModalThemeData copyWith({
    Color? color,
    double? elevation,
  }) {
    return ElModalThemeData(
      color: color ?? this.color,
      elevation: elevation ?? this.elevation,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElModalThemeData merge([ElModalThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      color: other.color,
      elevation: other.elevation,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElModalThemeData &&
          runtimeType == other.runtimeType &&
          color == other.color &&
          elevation == other.elevation;

  /// 生成 hashCode 方法
  int get _hashCode => color.hashCode ^ elevation.hashCode;
}
