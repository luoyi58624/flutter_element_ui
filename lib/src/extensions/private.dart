import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/color.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';

import '../app.dart';
import '../styles/theme.dart';
import '../utils/color.dart';

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
  Color _light(BuildContext context, int level, bool reverse) {
    final darkenColor = Colors.black.mix(this, level * 8);
    final brightenColor = Colors.white.mix(this, level * 10);
    if (!reverse) {
      return context.isDark ? darkenColor : brightenColor;
    } else {
      return context.isDark ? brightenColor : darkenColor;
    }
  }

  Color _light1(BuildContext context, {bool reverse = false}) =>
      _light(context, 1, reverse);

  Color _light2(BuildContext context, {bool reverse = false}) =>
      _light(context, 2, reverse);

  Color _light3(BuildContext context, {bool reverse = false}) =>
      _light(context, 3, reverse);

  Color _light4(BuildContext context, {bool reverse = false}) =>
      _light(context, 4, reverse);

  Color _light5(BuildContext context, {bool reverse = false}) =>
      _light(context, 5, reverse);

  Color _light6(BuildContext context, {bool reverse = false}) =>
      _light(context, 6, reverse);

  Color _light7(BuildContext context, {bool reverse = false}) =>
      _light(context, 7, reverse);

  Color _light8(BuildContext context, {bool reverse = false}) =>
      _light(context, 8, reverse);

  Color _light9(BuildContext context, {bool reverse = false}) =>
      _light(context, 9, reverse);

  // /// 默认按钮背景颜色：hover、active
  // Color get buttonBgHover => _light9;
  //
  // /// 默认按钮边框悬停颜色
  // Color get buttonBorderHover => _light7;
  //
  // /// 默认按钮背景激活颜色
  // Color get buttonBgActive => Colors.black.mix(this, 10);
  //
  // /// 默认按钮背景激活颜色
  // Color get buttonBorderActive => Colors.black.mix(this, 10);

  /// hover 悬停颜色，颜色会变得更浅
  Color elHover(BuildContext context) => _light1(context);

  /// tap 按下颜色，颜色会变得更深
  Color elTap(BuildContext context) => _light2(context, reverse: true);

  /// 应用主题透明背景颜色
  Color elThemeLightBg(BuildContext context) => _light9(context);

  /// 应用主题透明边框颜色
  Color elThemeLightBorder(BuildContext context) => _light6(context);

  /// 如果当前颜色是暗色，则应用暗色主题文字颜色，否则应用亮色主题文字颜色
  Color elTextColor(BuildContext context) =>
      isDark ? context.darkTheme.textColor : context.theme.textColor;
}
