// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../themes/components/basic/text.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElTextThemeDataExtension on ElTextThemeData {
  /// 接收一组可选参数，返回新的对象
  ElTextThemeData copyWith({
    TextStyle? textStyle,
    TextStyle? regularStyle,
    TextStyle? secondaryStyle,
    TextStyle? placeholderStyle,
  }) {
    return ElTextThemeData(
      textStyle: this.textStyle.merge(textStyle),
      regularStyle: this.regularStyle.merge(regularStyle),
      secondaryStyle: this.secondaryStyle.merge(secondaryStyle),
      placeholderStyle: this.placeholderStyle.merge(placeholderStyle),
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElTextThemeData merge([ElTextThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      textStyle: other.textStyle,
      regularStyle: other.regularStyle,
      secondaryStyle: other.secondaryStyle,
      placeholderStyle: other.placeholderStyle,
    );
  }
}

// **************************************************************************
// ElThemeModelGenerator
// **************************************************************************

extension ElTextThemeDataLerpExtension on ElTextThemeData {
  /// 默认主题动画线性插值
  ElTextThemeData lerp(ElTextThemeData a, ElTextThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElTextThemeData(
      textStyle: TextStyle.lerp(a.textStyle, b.textStyle, t) ?? a.textStyle,
      regularStyle:
          TextStyle.lerp(a.regularStyle, b.regularStyle, t) ?? a.regularStyle,
      secondaryStyle: TextStyle.lerp(a.secondaryStyle, b.secondaryStyle, t) ??
          a.secondaryStyle,
      placeholderStyle:
          TextStyle.lerp(a.placeholderStyle, b.placeholderStyle, t) ??
              a.placeholderStyle,
    );
  }
}
