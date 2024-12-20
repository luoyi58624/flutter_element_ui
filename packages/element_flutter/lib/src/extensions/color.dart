import 'package:element_dart/element_dart.dart';
import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart' show MaterialColor, Color, HSLColor;

extension FlutterColorStringExtension on String {
  /// 将16进制字符串颜色转成Color对象
  Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension FlutterColorExtension on Color {
  /// 判断一个颜色是否是暗色，171 表示 [El.warning] 的感知亮度，这个值可以覆盖 Element UI 默认的主题系统
  bool get isDark => hsp <= 171;

  /// 返回一个颜色的感知亮度：0 - 255，0 表示纯黑色，255 表示纯白色
  ///
  /// http://www.w3.org/TR/AERT#color-contrast
  int get hsp =>
      ((r.floatToInt8 * 299 + g.floatToInt8 * 587 + b.floatToInt8 * 114) / 1000)
          .ceilToDouble()
          .toInt();

  /// 根据明亮度获取一个新的颜色，lightness以1为基准，小于1则颜色变暗，大于1则颜色变亮
  Color getLightnessColor(double lightness) {
    final originalColor = HSLColor.fromColor(this);
    final newLightness = originalColor.lightness * lightness;
    final newColor = originalColor.withLightness(newLightness.clamp(0.0, 1.0));
    return newColor.toColor();
  }

  /// 将颜色转成 int
  int get toInt =>
      a.floatToInt8 << 24 |
      r.floatToInt8 << 16 |
      g.floatToInt8 << 8 |
      b.floatToInt8 << 0;

  /// Color对象转16进制字符串格式颜色
  /// * hasLeading 是否添加 # 前缀，默认true
  /// * hasAlpha 是否添加透明度，默认false
  String toHex({
    bool hasLeading = true,
    bool hasAlpha = false,
  }) =>
      '${hasLeading == true ? '#' : ''}'
      '${hasAlpha == true ? a.floatToInt8.toRadixString(16).padLeft(2, '0') : ''}'
      '${r.floatToInt8.toRadixString(16).padLeft(2, '0')}'
      '${g.floatToInt8.toRadixString(16).padLeft(2, '0')}'
      '${b.floatToInt8.toRadixString(16).padLeft(2, '0')}';

  /// 将当前颜色转换成 Material 颜色。
  ///
  /// 注意：[MaterialColor] 中所有颜色都是手动预设值，此函数只是简单根据预设梯度创建不同级别颜色，
  /// 所以最终得到的 [MaterialColor] 除 shade500 级别外都不匹配。
  MaterialColor toMaterialColor() {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r.floatToInt8 +
            ((ds < 0 ? r.floatToInt8 : (255 - r.floatToInt8)) * ds).round(),
        g.floatToInt8 +
            ((ds < 0 ? g.floatToInt8 : (255 - g.floatToInt8)) * ds).round(),
        b.floatToInt8 +
            ((ds < 0 ? b.floatToInt8 : (255 - b.floatToInt8)) * ds).round(),
        1,
      );
    }
    return MaterialColor(toInt, swatch);
  }

  /// 将颜色变得更亮
  /// * scale 0-100，值越大，颜色越亮
  Color brighten(int scale) {
    assert(scale >= 0 && scale <= 100);
    var p = scale / 100;
    return Color.fromARGB(
      a.floatToInt8,
      r.floatToInt8 + ((255 - r.floatToInt8) * p).round(),
      g.floatToInt8 + ((255 - g.floatToInt8) * p).round(),
      b.floatToInt8 + ((255 - b.floatToInt8) * p).round(),
    );
  }

  /// 将颜色变得更暗
  /// * scale 0-100，值越大，颜色越深
  Color darken(int scale) {
    assert(scale >= 0 && scale <= 100);
    var p = 1 - scale / 100;
    return Color.fromARGB(
      a.floatToInt8,
      (r.floatToInt8 * p).round(),
      (g.floatToInt8 * p).round(),
      (b.floatToInt8 * p).round(),
    );
  }

  /// 将颜色变得深，如果当前颜色是亮色，颜色会变暗，但如果当前颜色是暗色，则颜色会变亮
  /// * scale 0-100，值越大，颜色越深
  /// * reversal 是否反转，如果颜色是亮色，则颜色更亮，否则更暗
  /// * lightScale 0-100，当颜色是亮色时，应用的 scale 值
  /// * darkScale 0-100，当颜色是暗色时，应用的 scale 值
  Color deepen(
    int scale, {
    bool reversal = false,
    int? lightScale,
    int? darkScale,
  }) {
    return reversal
        ? (isDark ? darken(darkScale ?? scale) : brighten(lightScale ?? scale))
        : (isDark ? brighten(darkScale ?? scale) : darken(lightScale ?? scale));
  }

  /// 将当前颜色和另一种颜色按一定比例进行混合
  /// * other 与之混合的颜色
  /// * scale 0-100，比值越小就越接近color1，比值越大就接近color2
  Color mix(Color other, int scale) {
    assert(scale >= 0 && scale <= 100);
    var p = scale / 100;
    return Color.fromARGB(
      ((other.a.floatToInt8 - a.floatToInt8) * p + a.floatToInt8).round(),
      ((other.r.floatToInt8 - r.floatToInt8) * p + r.floatToInt8).round(),
      ((other.g.floatToInt8 - g.floatToInt8) * p + g.floatToInt8).round(),
      ((other.b.floatToInt8 - b.floatToInt8) * p + b.floatToInt8).round(),
    );
  }

  /// 根据状态返回新的颜色
  Color on(bool flag, {int scale = 10, Color? color}) =>
      flag ? (color ?? deepen(scale)) : this;
}
