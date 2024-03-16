part of flutter_element_ui;

/// Color对象扩展
extension ElColorUtil on Color {
  /// Color对象转16进制字符串格式颜色
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';

  /// 返回一个颜色的hsp (颜色的感知亮度)
  int get hsp {
    final int r = red, g = green, b = blue;
    double hsp = math.sqrt(0.299 * (r * r) + 0.587 * (g * g) + 0.114 * (b * b));
    return hsp.ceilToDouble().toInt();
  }

  /// 判断一个颜色是否是暗色
  bool get isDark => hsp <= 150;

  /// 将颜色变得更亮
  /// * scale 0-100，值越大，颜色越亮
  Color brighten(int scale) {
    assert(scale > 0 && scale <= 100);
    var p = scale / 100;
    return Color.fromARGB(alpha, red + ((255 - red) * p).round(), green + ((255 - green) * p).round(), blue + ((255 - blue) * p).round());
  }

  /// 将颜色变得更暗
  /// * scale 0-100，值越大，颜色越深
  Color darken(int scale) {
    assert(scale > 0 && scale <= 100);
    var f = 1 - scale / 100;
    return Color.fromARGB(alpha, (red * f).round(), (green * f).round(), (blue * f).round());
  }
}
