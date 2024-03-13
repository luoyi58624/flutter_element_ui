part of flutter_element_ui;

/// 颜色工具类
class _ColorUtil {
  /// 判断一个颜色是否是暗色
  static bool isDark(Color color) {
    return getColorHsp(color) <= 150;
  }

  /// 返回一个颜色的hsp (颜色的感知亮度)
  static int getColorHsp(Color color) {
    final int r = color.red, g = color.green, b = color.blue;
    double hsp = math.sqrt(0.299 * (r * r) + 0.587 * (g * g) + 0.114 * (b * b));
    return hsp.ceilToDouble().toInt();
  }

  /// 将颜色变得更亮
  /// * color
  /// * scale 0-100，值越大，颜色越亮
  static Color brighten(Color color, int scale) {
    return getLightnessColor(color, 1 + scale / 100);
  }

  /// 将颜色变得更暗
  /// * color
  /// * scale 0-100，值越大，颜色越深
  static Color darken(Color color, int scale) {
    return getLightnessColor(color, 1 - scale / 100);
  }

  /// 根据明亮度获取一个新的颜色，lightness以1为基准，小于1则颜色变暗，大于1则颜色变亮
  static Color getLightnessColor(Color color, double lightness) {
    final originalColor = HSLColor.fromColor(color);
    final newLightness = originalColor.lightness * lightness;
    final newColor = originalColor.withLightness(newLightness.clamp(0.0, 1.0));
    return newColor.toColor();
  }

  /// 16进制字符串格式颜色转Color对象
  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

extension HexColor on Color {
  /// Color对象转16进制字符串格式颜色
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
