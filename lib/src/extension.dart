import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'styles/theme.dart';
import 'theme.dart';

extension ElThemeExtension on BuildContext {
  /// Element UI 全局配置数据
  ElConfigData get elConfig => ElTheme.of(this).config;

  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElColorThemeData get elTheme => isDark ? darkTheme : theme;
}

extension ThemeExtension on BuildContext {
  ElColorThemeData get theme => ElTheme.of(this).theme;

  ElColorThemeData get darkTheme => ElTheme.of(this).darkTheme;

  /// Element UI 主题类型颜色集合
  Map<String, Color> get themeTypeColors => {
        'primary': elTheme.primary,
        'success': elTheme.success,
        'info': elTheme.info,
        'warning': elTheme.warning,
        'error': elTheme.error,
      };
}

/// 颜色渐变因子
const int brightenRatio = 10;
const int darkenRatio = 8;

/// 模拟 Element UI 九种渐变明亮度颜色，如果是亮色模式，则颜色将逐渐变亮，如果是暗色模式，则颜色将逐渐变暗
extension ColorExtension on Color {
  Color _light(BuildContext context, int level, bool reverse) {
    final darkenColor = darken(level * darkenRatio);
    final brightenColor = brighten(level * brightenRatio);
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
