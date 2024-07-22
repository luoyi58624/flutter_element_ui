import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/color.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';

import '../app.dart';
import '../styles/theme.dart';

// =========================================================
// 应用于 Element UI 内部私有扩展函数
// =========================================================

extension ThemeExtension on BuildContext {
  ElThemeData get theme => ElApp.of(this).theme;

  ElThemeData get darkTheme => ElApp.of(this).darkTheme;

  /// Element UI 主题类型颜色集合
  Map<String, Color> get themeTypeColors => {
        'primary': elTheme.primary,
        'success': elTheme.success,
        'info': elTheme.info,
        'warning': elTheme.warning,
        'error': elTheme.error,
      };
}

/// 模拟 Element UI 九种渐变明亮度颜色
extension ColorExtension on Color {
  Color _darkenColor(int level) => Colors.black.mix(this, level * 8);

  Color _brightenColor(int level) => Colors.white.mix(this, level * 10);

  Color _light(BuildContext context, int level, bool reverse) {
    if (!reverse) {
      return context.isDark ? _darkenColor(level) : _brightenColor(level);
    } else {
      return context.isDark ? _brightenColor(level) : _darkenColor(level);
    }
  }

  Color light1(BuildContext context, {bool reverse = false}) =>
      _light(context, 1, reverse);

  Color light2(BuildContext context, {bool reverse = false}) =>
      _light(context, 2, reverse);

  Color light3(BuildContext context, {bool reverse = false}) =>
      _light(context, 3, reverse);

  Color light4(BuildContext context, {bool reverse = false}) =>
      _light(context, 4, reverse);

  Color light5(BuildContext context, {bool reverse = false}) =>
      _light(context, 5, reverse);

  Color light6(BuildContext context, {bool reverse = false}) =>
      _light(context, 6, reverse);

  Color light7(BuildContext context, {bool reverse = false}) =>
      _light(context, 7, reverse);

  Color light8(BuildContext context, {bool reverse = false}) =>
      _light(context, 8, reverse);

  Color light9(BuildContext context, {bool reverse = false}) =>
      _light(context, 9, reverse);

  /// 如果当前颜色是暗色，则应用暗色主题文字颜色，否则应用亮色主题文字颜色
  Color elTextColor(BuildContext context) =>
      isDark ? context.darkTheme.textColor : context.theme.textColor;
}
