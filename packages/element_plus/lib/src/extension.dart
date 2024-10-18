import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'themes/config.dart';
import 'themes/theme.dart';

extension ElThemeExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : lightTheme;

  /// Element UI 全局配置
  ElConfigData get elConfig => ElApp.of(this).config;

  /// Element UI 过渡动画时间扩展方法，当使用动画小部件时，如果直接应用过渡动画，
  /// 当切换主题模式时，就会出现动画过渡不协调问题，此扩展方法便是解决该问题：
  /// ```dart
  /// AnimatedContainer(
  ///   duration: context.elDuration(Duration(milliseconds: 200)),
  /// ),
  /// ```
  Duration elDuration([Duration? duration]) =>
      ElApp.of(this).themeDuration ?? duration ?? Duration.zero;

  /// Element UI 过渡动画曲线扩展方法
  Curve elCurve([Curve? curve]) =>
      ElApp.of(this).themeCurve ?? curve ?? Curves.linear;
}

extension ElColorThemeExtension on Color {
  Color elLight1(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 1, reverse);

  Color elLight2(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 2, reverse);

  Color elLight3(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 3, reverse);

  Color elLight4(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 4, reverse);

  Color elLight5(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 5, reverse);

  Color elLight6(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 6, reverse);

  Color elLight7(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 7, reverse);

  Color elLight8(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 8, reverse);

  Color elLight9(BuildContext context, {bool reverse = false}) =>
      _elLight(context, 9, reverse);

  /// 如果当前颜色是暗色，则应用暗色主题文字颜色，否则应用亮色主题文字颜色
  Color elTextColor(BuildContext context) =>
      isDark ? context.darkTheme.textColor : ElApp.of(context).theme.textColor;

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

  Color _brighten(int level) => mix(const Color(0xffffffff), level * 10);

  /// 根据当前颜色返回符合 Element 主题系统颜色。
  /// * 如果当前是亮色模式，则与白色进行混合，level 级别越高，颜色越接近白色
  /// * 如果当前是暗色模式，则与黑色进行混合，level 级别越高，颜色越接近黑色
  /// * reverse - 是否应用反转颜色
  Color _elLight(BuildContext context, int level, bool reverse) {
    assert(level >= 1 && level <= 9, 'elLight 颜色级别范围必须是 1 - 9，但却得到: $level');
    if (!reverse) {
      return context.isDark ? _darken(level) : _brighten(level);
    } else {
      return context.isDark ? _brighten(level) : _darken(level);
    }
  }
}
