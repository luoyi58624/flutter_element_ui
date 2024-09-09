import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';

extension ElColorExtension on Color {
  /// 适应当前应用的主题默认，生成不同级别的颜色
  /// * reverse - 是否应用反转颜色
  Color elLight(int level, bool reverse) {
    if (!reverse) {
      return el.context.isDark ? _darkenColor(level) : _brightenColor(level);
    } else {
      return el.context.isDark ? _brightenColor(level) : _darkenColor(level);
    }
  }

  Color elLight1({bool reverse = false}) => elLight(1, reverse);

  Color elLight2({bool reverse = false}) => elLight(2, reverse);

  Color elLight3({bool reverse = false}) => elLight(3, reverse);

  Color elLight4({bool reverse = false}) => elLight(4, reverse);

  Color elLight5({bool reverse = false}) => elLight(5, reverse);

  Color elLight6({bool reverse = false}) => elLight(6, reverse);

  Color elLight7({bool reverse = false}) => elLight(7, reverse);

  Color elLight8({bool reverse = false}) => elLight(8, reverse);

  Color elLight9({bool reverse = false}) => elLight(9, reverse);

  /// 如果当前颜色是暗色，则应用暗色主题文字颜色，否则应用亮色主题文字颜色
  Color get elTextColor =>
      isDark ? el.context.darkTheme.textColor : el.context.theme.textColor;
}

/// 模拟 Element UI 九种渐变明亮度颜色
extension _ColorExtension on Color {
  /// 将黑色和主题色进行混合，权重越小，越接近黑色，权重越大，越接近主题色
  Color _darkenColor(int level) => mix(Colors.black, level * 8);

  /// 将白色和主题色进行混合，权重越小，越接近白色，权重越大，越接近主题色
  Color _brightenColor(int level) => mix(Colors.white, level * 10);
}
