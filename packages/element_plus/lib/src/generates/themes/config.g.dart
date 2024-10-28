// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/config.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElConfigThemeDataExtension on ElConfigThemeData {
  /// 接收一组可选参数，返回新的对象
  ElConfigThemeData copyWith({
    double? size,
    BorderRadius? radius,
    double? borderSize,
    Duration? themeDuration,
    Curve? themeCurve,
  }) {
    return ElConfigThemeData(
      size: size ?? this.size,
      radius: radius ?? this.radius,
      borderSize: borderSize ?? this.borderSize,
      themeDuration: themeDuration ?? this.themeDuration,
      themeCurve: themeCurve ?? this.themeCurve,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElConfigThemeData merge([ElConfigThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
      radius: other.radius,
      borderSize: other.borderSize,
      themeDuration: other.themeDuration,
      themeCurve: other.themeCurve,
    );
  }
}
