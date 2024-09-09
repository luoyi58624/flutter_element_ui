import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';

import '../app.dart';

extension ElColorExtension on Color {
  /// 适应当前应用的主题默认，生成不同级别的颜色
  /// * reverse - 是否应用反转颜色
  Color elLight(BuildContext context, int level, bool reverse) {
    if (!reverse) {
      return context.isDark ? _darkenColor(level) : _brightenColor(level);
    } else {
      return context.isDark ? _brightenColor(level) : _darkenColor(level);
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
  Color elTextColor(BuildContext context) =>
      isDark ? context.darkTheme.textColor : ElApp.of(context).theme.textColor;
}

/// 模拟 Element UI 九种渐变明亮度颜色
extension _ColorExtension on Color {
  /// 将黑色和主题色进行混合，权重越小，越接近黑色，权重越大，越接近主题色
  Color _darkenColor(int level) => mix(Colors.black, level * 8);

  /// 将白色和主题色进行混合，权重越小，越接近白色，权重越大，越接近主题色
  Color _brightenColor(int level) => mix(Colors.white, level * 10);
}
