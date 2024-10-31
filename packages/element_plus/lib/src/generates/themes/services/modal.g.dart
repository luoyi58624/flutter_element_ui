// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../themes/services/modal.dart';

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
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

extension ElModalThemeDataLerpExtension on ElModalThemeData {
  /// 默认主题动画线性插值
  ElModalThemeData lerp(ElModalThemeData a, ElModalThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElModalThemeData(
      color: Color.lerp(a.color, b.color, t) ?? a.color,
      elevation: lerpDouble(a.elevation, b.elevation, t) ?? a.elevation,
    );
  }
}
