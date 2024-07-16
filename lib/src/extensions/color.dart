import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/app.dart';
import 'package:flutter_element_ui/src/extensions/theme.dart';

extension ElColorStringExtension on String {
  /// 将16进制字符串颜色转成Color对象
  Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

/// Color工具函数扩展
extension ElColorExtension on Color {
  /// 判断一个颜色是否是暗色
  bool get isDark => hsp <= 168;

  /// 返回一个颜色的hsp (颜色的感知亮度)
  ///
  /// http://www.w3.org/TR/AERT#color-contrast
  int get hsp =>
      ((red * 299 + green * 587 + blue * 114) / 1000).ceilToDouble().toInt();

  /// 根据明亮度获取一个新的颜色，lightness以1为基准，小于1则颜色变暗，大于1则颜色变亮
  Color getLightnessColor(double lightness) {
    final originalColor = HSLColor.fromColor(this);
    final newLightness = originalColor.lightness * lightness;
    final newColor = originalColor.withLightness(newLightness.clamp(0.0, 1.0));
    return newColor.toColor();
  }

  /// Color对象转16进制字符串格式颜色
  /// * hasLeading 是否添加 # 前缀，默认true
  /// * hasAlpha 是否添加透明度，默认false
  String toHex({
    bool hasLeading = true,
    bool hasAlpha = false,
  }) =>
      '${hasLeading == true ? '#' : ''}'
      '${hasAlpha == true ? alpha.toRadixString(16).padLeft(2, '0') : ''}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  /// 创建Material颜色
  MaterialColor toMaterialColor() {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        red + ((ds < 0 ? red : (255 - red)) * ds).round(),
        green + ((ds < 0 ? green : (255 - green)) * ds).round(),
        blue + ((ds < 0 ? blue : (255 - blue)) * ds).round(),
        1,
      );
    }
    return MaterialColor(value, swatch);
  }

  /// 将颜色变得更亮
  /// * scale 0-100，值越大，颜色越亮
  Color brighten(int scale) {
    assert(scale >= 0 && scale <= 100);
    var p = scale / 100;
    return Color.fromARGB(alpha, red + ((255 - red) * p).round(),
        green + ((255 - green) * p).round(), blue + ((255 - blue) * p).round());
  }

  /// 将颜色变得更暗
  /// * scale 0-100，值越大，颜色越深
  Color darken(int scale) {
    assert(scale >= 0 && scale <= 100);
    var f = 1 - scale / 100;
    return Color.fromARGB(
        alpha, (red * f).round(), (green * f).round(), (blue * f).round());
  }

  /// 将颜色变得深，如果当前颜色是亮色，颜色会变暗，但如果当前颜色是暗色，则颜色会变亮
  /// * scale 0-100，值越大，颜色越深
  /// * lightScale 0-100，当颜色是亮色时，应用的 scale 值
  /// * darkScale 0-100，当颜色是暗色时，应用的 scale 值
  Color deepen(
    int scale, {
    int? lightScale,
    int? darkScale,
  }) {
    return isDark ? brighten(darkScale ?? scale) : darken(lightScale ?? scale);
  }

  /// 根据事件状态返回新的颜色
  Color on(bool flag, {int scale = 10, Color? color}) =>
      flag ? (color ?? deepen(scale)) : this;
}

/// 颜色渐变因子
const int _brightenRatio = 10;
const int _darkenRatio = 8;

/// 模拟 Element UI 九种渐变明亮度颜色，如果是亮色模式，则颜色将逐渐变亮，如果是暗色模式，则颜色将逐渐变暗
extension ColorExtension on Color {
  Color _light(BuildContext context, int level, bool reverse) {
    final darkenColor = darken(level * _darkenRatio);
    final brightenColor = brighten(level * _brightenRatio);
    if (!reverse) {
      return context.isDark ? darkenColor : brightenColor;
    } else {
      return context.isDark ? brightenColor : darkenColor;
    }
  }

  /// Element UI 一级渐变颜色
  Color _elLight1(BuildContext context, {bool reverse = false}) =>
      _light(context, 1, reverse);

  /// Element UI 二级渐变颜色
  Color _elLight2(BuildContext context, {bool reverse = false}) =>
      _light(context, 2, reverse);

  /// Element UI 三级渐变颜色
  Color _elLight3(BuildContext context, {bool reverse = false}) =>
      _light(context, 3, reverse);

  /// Element UI 四级渐变颜色
  Color _elLight4(BuildContext context, {bool reverse = false}) =>
      _light(context, 4, reverse);

  /// Element UI 五级渐变颜色
  Color _elLight5(BuildContext context, {bool reverse = false}) =>
      _light(context, 5, reverse);

  /// Element UI 六级渐变颜色
  Color _elLight6(BuildContext context, {bool reverse = false}) =>
      _light(context, 6, reverse);

  /// Element UI 七级渐变颜色
  Color _elLight7(BuildContext context, {bool reverse = false}) =>
      _light(context, 7, reverse);

  /// Element UI 八级渐变颜色
  Color _elLight8(BuildContext context, {bool reverse = false}) =>
      _light(context, 8, reverse);

  /// Element UI 九级渐变颜色
  Color _elLight9(BuildContext context, {bool reverse = false}) =>
      _light(context, 9, reverse);

  /// hover 悬停颜色，颜色会变得更浅
  Color elHover(BuildContext context) => _elLight2(context);

  /// tap 按下颜色，颜色会变得更深
  Color elTap(BuildContext context) => _elLight3(context, reverse: true);

  /// 应用主题透明背景颜色
  Color elThemeLightBg(BuildContext context) => _elLight9(context);

  /// 应用主题透明边框颜色
  Color elThemeLightBorder(BuildContext context) => _elLight6(context);

  /// 如果当前颜色是暗色，则应用暗色主题文字颜色，否则应用亮色主题文字颜色
  Color elTextColor(BuildContext context) =>
      isDark ? context.darkTheme.textColor : context.theme.textColor;
}
