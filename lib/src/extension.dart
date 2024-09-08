import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'package:flutter_element_ui/src/extensions/context.dart';
import 'package:flutter_element_ui/src/styles/config_data.dart';
import 'package:flutter_element_ui/src/theme.dart';

import 'styles/theme_data.dart';
import 'widgets/global_theme_duration.dart';

extension ElBuildContextExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : theme;

  /// Element UI 全局配置
  ElConfigData get elConfig => ElThemeInheritedWidget.of(this).config;

  /// Element UI 主题颜色集合
  Map<String, Color> get elThemeColors => {
        'primary': elTheme.primary,
        'success': elTheme.success,
        'info': elTheme.info,
        'warning': elTheme.warning,
        'error': elTheme.error,
      };

  /// 全局默认主题过渡持续时间。
  ///
  /// 应用场景：当你使用诸如 [AnimationController] 等动画小部件时，如果直接应用了 300 毫秒的过渡动画，
  /// 当更改全局主题（切换黑暗模式）时，就可能会出现动画过渡不协调问题，此时解决办法是：
  /// ```dart
  /// AnimationController(
  ///   duration: context.elThemeDuration ?? 300.ms
  /// ),
  /// ```
  ///
  /// 当切换主题时，请调用 [el.changeTheme] 方法，此方法接收 [VoidCallback] 函数，
  /// 在执行自定义逻辑前会帮你设置全局过渡时间和全局过渡动画曲线。
  Duration? get elThemeDuration => GlobalThemeStyle.duration(this);

  /// 全局默认主题过渡动画曲线。
  Curve? get elThemeCurve => GlobalThemeStyle.curve(this);
}

extension ElColorExtension on Color {
  ///
  Color elLight1(BuildContext context, {bool reverse = false}) =>
      _light(context, 1, reverse);

  Color elLight2(BuildContext context, {bool reverse = false}) =>
      _light(context, 2, reverse);

  Color elLight3(BuildContext context, {bool reverse = false}) =>
      _light(context, 3, reverse);

  Color elLight4(BuildContext context, {bool reverse = false}) =>
      _light(context, 4, reverse);

  Color elLight5(BuildContext context, {bool reverse = false}) =>
      _light(context, 5, reverse);

  Color elLight6(BuildContext context, {bool reverse = false}) =>
      _light(context, 6, reverse);

  Color elLight7(BuildContext context, {bool reverse = false}) =>
      _light(context, 7, reverse);

  Color elLight8(BuildContext context, {bool reverse = false}) =>
      _light(context, 8, reverse);

  Color elLight9(BuildContext context, {bool reverse = false}) =>
      _light(context, 9, reverse);

  /// 如果当前颜色是暗色，则应用暗色主题文字颜色，否则应用亮色主题文字颜色
  Color elTextColor(BuildContext context) =>
      isDark ? context.darkTheme.textColor : context.theme.textColor;
}

/// 模拟 Element UI 九种渐变明亮度颜色
extension _ColorExtension on Color {
  /// 将黑色和主题色进行混合，权重越小，越接近黑色，权重越大，越接近主题色
  Color _darkenColor(int level) => mix(Colors.black, level * 8);

  /// 将白色和主题色进行混合，权重越小，越接近白色，权重越大，越接近主题色
  Color _brightenColor(int level) => mix(Colors.white, level * 10);

  /// 适应当前应用的主题默认，生成不同级别的颜色
  /// * reverse - 是否应用反转颜色
  Color _light(BuildContext context, int level, bool reverse) {
    if (!reverse) {
      return context.isDark ? _darkenColor(level) : _brightenColor(level);
    } else {
      return context.isDark ? _brightenColor(level) : _darkenColor(level);
    }
  }
}
