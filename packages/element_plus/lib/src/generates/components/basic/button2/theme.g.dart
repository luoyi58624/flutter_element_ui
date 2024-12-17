// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../components/basic/button2/theme.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElButton2ThemeDataExtension on ElButton2ThemeData {
  /// 接收一组可选参数，返回新的对象
  ElButton2ThemeData copyWith({
    String? type,
    Color? bgColor,
  }) {
    return ElButton2ThemeData(
      type: type ?? this.type,
      bgColor: bgColor ?? this.bgColor,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElButton2ThemeData merge([ElButton2ThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      type: other.type,
      bgColor: other.bgColor,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElButton2ThemeData &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          bgColor == other.bgColor;

  /// 生成 hashCode 方法
  int get _hashCode => type.hashCode ^ bgColor.hashCode;
}

extension ElTextButtonThemeDataExtension on ElTextButtonThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTextButtonThemeData copyWith({
    String? type,
    bool? bg,
  }) {
    return ElTextButtonThemeData(
      type: type ?? this.type,
      bg: bg ?? this.bg,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTextButtonThemeData merge([ElTextButtonThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      type: other.type,
      bg: other.bg,
    );
  }

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElTextButtonThemeData &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          bg == other.bg;

  /// 生成 hashCode 方法
  int get _hashCode => type.hashCode ^ bg.hashCode;
}
