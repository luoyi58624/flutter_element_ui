import 'package:flutter/widgets.dart';

import '../app.dart';
import '../global.dart';
import '../styles/config_data.dart';
import '../styles/theme_data.dart';

extension ElThemeExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : theme;

  /// Element UI 全局配置
  ElConfigData get elConfig => ElApp.of(this).config;

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
  /// 当你使用 [AnimatedContainer] 动画小部件时，如果直接应用了 300 毫秒的过渡动画，
  /// 当切换黑暗模式时，就可能会出现动画过渡不协调问题，此时解决办法是：
  /// ```dart
  /// AnimatedContainer(
  ///   duration: context.elThemeDuration ?? 300.ms
  /// ),
  /// ```
  Duration? get elThemeDuration => ElApp.of(this).globalThemeDuration;

  /// 全局默认主题过渡动画曲线。
  Curve? get elThemeCurve => ElApp.of(this).globalThemeCurve;
}
