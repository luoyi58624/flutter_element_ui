import 'package:flutter/widgets.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'styles/theme.dart';
import 'theme.dart';

// ===============================================================
// 扩展函数虽然很方便, 但很容易引起冲突，而且我个人非常讨厌一些来历不明的各种方法，
// 所以除了以 El 开头命名的扩展，我不会对外提供任何扩展，若有需要请自行封装。
// ===============================================================
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

/// 模拟 Element UI 九种渐变明亮度颜色，如果是亮色模式，则颜色将逐渐变亮，如果是暗色模式，则颜色将逐渐变暗
extension ColorExtension on Color {
  /// Element UI 一级渐变颜色
  Color elLight1(
    BuildContext context, {
    bool reverse = false,
  }) =>
      !reverse
          ? (context.isDark ? darken(8) : brighten(10))
          : (context.isDark ? brighten(10) : darken(8));

  /// Element UI 二级渐变颜色
  Color elLight2(
    BuildContext context, {
    bool reverse = false,
  }) =>
      !reverse
          ? (context.isDark ? darken(16) : brighten(20))
          : (context.isDark ? brighten(20) : darken(16));

  /// Element UI 三级渐变颜色
  Color elLight3(
    BuildContext context, {
    bool reverse = false,
  }) =>
      !reverse
          ? (context.isDark ? darken(24) : brighten(30))
          : (context.isDark ? brighten(30) : darken(24));

  /// Element UI 四级渐变颜色
  Color elLight4(
    BuildContext context, {
    bool reverse = false,
  }) =>
      !reverse
          ? (context.isDark ? darken(32) : brighten(40))
          : (context.isDark ? brighten(40) : darken(32));

  /// Element UI 五级渐变颜色
  Color elLight5(
    BuildContext context, {
    bool reverse = false,
  }) =>
      !reverse
          ? (context.isDark ? darken(40) : brighten(50))
          : (context.isDark ? brighten(50) : darken(40));

  /// Element UI 六级渐变颜色
  Color elLight6(
    BuildContext context, {
    bool reverse = false,
  }) =>
      !reverse
          ? (context.isDark ? darken(48) : brighten(60))
          : (context.isDark ? brighten(60) : darken(48));

  /// Element UI 七级渐变颜色
  Color elLight7(
    BuildContext context, {
    bool reverse = false,
  }) =>
      !reverse
          ? (context.isDark ? darken(56) : brighten(70))
          : (context.isDark ? brighten(70) : darken(56));

  /// Element UI 八级渐变颜色
  Color elLight8(
    BuildContext context, {
    bool reverse = false,
  }) =>
      !reverse
          ? (context.isDark ? darken(64) : brighten(80))
          : (context.isDark ? brighten(80) : darken(64));

  /// Element UI 九级渐变颜色
  Color elLight9(
    BuildContext context, {
    bool reverse = false,
  }) =>
      !reverse
          ? (context.isDark ? darken(72) : brighten(90))
          : (context.isDark ? brighten(90) : darken(72));

  /// hover 悬停颜色，颜色会变得更浅
  Color elHover(BuildContext context) => elLight2(context);

  /// tap 按下颜色，颜色会变得更深
  Color elTap(BuildContext context) => elLight3(context, reverse: true);

  /// 应用主题透明背景颜色
  Color elThemeLightBg(BuildContext context) => elLight9(context);

  /// 应用主题透明边框颜色
  Color elThemeLightBorder(BuildContext context) => elLight6(context);

  /// 如果当前颜色是暗色，则应用暗色主题文字颜色，否则应用亮色主题文字颜色
  Color elTextColor(BuildContext context) =>
      isDark ? context.darkTheme.textColor : context.theme.textColor;
}
