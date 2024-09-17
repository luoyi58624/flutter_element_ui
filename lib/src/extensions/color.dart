import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/event.dart';
import 'package:flutter_element_ui/src/global.dart';

import '../app.dart';

extension ElColorStringExtension on String {
  /// 将16进制字符串颜色转成Color对象
  Color toColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension ElColorExtension on Color {
  /// 判断一个颜色是否是暗色
  // 通常我们以 128 作为分界点，但这个值对于 Element 主题系统来讲实在太低了，
  // 例如：默认的 primary 颜色的 hsp 高达 141，而 warning 颜色更是高达 171,
  // 如果将此值设置为默认的 128，那么很多与主题相关的文字颜色将都变成黑色。
  bool get isDark => hsp <= 178;

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

  /// 将当前颜色转换成 Material 颜色
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
    return Color.fromARGB(
      alpha,
      red + ((255 - red) * p).round(),
      green + ((255 - green) * p).round(),
      blue + ((255 - blue) * p).round(),
    );
  }

  /// 将颜色变得更暗
  /// * scale 0-100，值越大，颜色越深
  Color darken(int scale) {
    assert(scale >= 0 && scale <= 100);
    var p = 1 - scale / 100;
    return Color.fromARGB(
      alpha,
      (red * p).round(),
      (green * p).round(),
      (blue * p).round(),
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
  /// * color2 与之混合的颜色
  /// * scale 0-100，比值越小就越接近color1，比值越大就接近color2
  Color mix(Color color2, int scale) {
    assert(scale >= 0 && scale <= 100);
    var p = scale / 100;
    return Color.fromARGB(
      ((color2.alpha - alpha) * p + alpha).round(),
      ((color2.red - red) * p + red).round(),
      ((color2.green - green) * p + green).round(),
      ((color2.blue - blue) * p + blue).round(),
    );
  }

  /// 根据状态返回新的颜色
  Color on(bool flag, {int scale = 10, Color? color}) =>
      flag ? (color ?? deepen(scale)) : this;

  /// 根据事件构建新的颜色
  Color buildEventColor(
    BuildContext context, {
    ColorEventBuilder? tapBuilder,
    ColorEventBuilder? hoverBuilder,
  }) {
    if (tapBuilder != null) {
      if (context.isTap) {
        return tapBuilder(this);
      }
    }
    if (hoverBuilder != null) {
      if (context.isHover) {
        return hoverBuilder(this);
      }
    }
    return this;
  }

  /// 将当前颜色和另一种颜色进行线性插值
  Color lerp(Color otherColor, double t) {
    assert(Color.lerp(this, otherColor, t) != null);
    return Color.lerp(this, otherColor, t)!;
  }
}

typedef ColorEventBuilder = Color Function(Color color);

extension ElColorThemeExtension on Color {
  /// 根据当前颜色返回符合 Element 主题系统颜色。
  /// * 如果当前是亮色模式，则与白色进行混合，level 级别越高，颜色越接近白色
  /// * 如果当前是暗色模式，则与黑色进行混合，level 级别越高，颜色越接近黑色
  /// * reverse - 是否应用反转颜色
  Color elLight(BuildContext context, int level, bool reverse) {
    assert(level >= 1 && level <= 9, 'elLight 颜色级别范围必须是 1 - 9，但却得到: $level');
    if (!reverse) {
      return context.isDark ? _darken(level) : _brighten(level);
    } else {
      return context.isDark ? _brighten(level) : _darken(level);
    }
  }

  Color elLight1(BuildContext context, {bool reverse = false}) =>
      elLight(context, 1, reverse);

  Color elLight2(BuildContext context, {bool reverse = false}) =>
      elLight(context, 2, reverse);

  Color elLight3(BuildContext context, {bool reverse = false}) =>
      elLight(context, 3, reverse);

  Color elLight4(BuildContext context, {bool reverse = false}) =>
      elLight(context, 4, reverse);

  Color elLight5(BuildContext context, {bool reverse = false}) =>
      elLight(context, 5, reverse);

  Color elLight6(BuildContext context, {bool reverse = false}) =>
      elLight(context, 6, reverse);

  Color elLight7(BuildContext context, {bool reverse = false}) =>
      elLight(context, 7, reverse);

  Color elLight8(BuildContext context, {bool reverse = false}) =>
      elLight(context, 8, reverse);

  Color elLight9(BuildContext context, {bool reverse = false}) =>
      elLight(context, 9, reverse);

  /// 如果当前颜色是暗色，则应用暗色主题文字颜色，否则应用亮色主题文字颜色
  Color elTextColor(BuildContext context) => isDark
      ? context.darkTheme.colors.text
      : ElApp.of(context).theme.colors.text;

  /// 根据当前颜色生成 Element UI 9 种级别的渐变颜色
  List<Color> elLights(BuildContext context) {
    return [
      elLight1(context),
      elLight2(context),
      elLight3(context),
      elLight4(context),
      elLight5(context),
      elLight6(context),
      elLight7(context),
      elLight8(context),
      elLight9(context),
    ];
  }
}

extension _ColorExtension on Color {
  Color _darken(int level) => mix(const Color(0xff222222), level * 9);

  Color _brighten(int level) => mix(Colors.white, level * 10);
}
