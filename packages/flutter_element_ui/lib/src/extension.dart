import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/components/basic/brightness.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'styles/theme.dart';
import 'theme.dart';

// ===============================================================
// 扩展函数虽然可以让你更方便地使用Api, 但是很容易与其他扩展函数引起冲突，所以我尽量只提供少量、必需的扩展函数;
// Element UI 公开的扩展函数均以 El 命名开头，以 Extension 作为结尾，如果发现冲突，请使用 hide 关键字隐藏;
// ===============================================================

extension ElThemeExtension on BuildContext {
  /// Element UI 全局配置数据
  ElConfigData get elConfig => ElTheme.of(this).config;

  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElColorThemeData get elTheme => isDark ? darkTheme : theme;
}

extension ElBrightnessExtension on BuildContext {
  /// 当前环境是否是暗黑模式，默认跟随系统
  bool get isDark => ElBrightness.isDark(this);
}

extension ElResponsiveExtension on BuildContext {
  /// 移动端设备
  bool get sm => MediaQuery.sizeOf(this).width < ElTheme.of(this).responsive.sm;

  /// 平板设备
  bool get md => MediaQuery.sizeOf(this).width < ElTheme.of(this).responsive.md;

  /// 桌面设备
  bool get lg => MediaQuery.sizeOf(this).width < ElTheme.of(this).responsive.lg;

  /// 大屏桌面设备
  bool get xl => MediaQuery.sizeOf(this).width < ElTheme.of(this).responsive.xl;
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
