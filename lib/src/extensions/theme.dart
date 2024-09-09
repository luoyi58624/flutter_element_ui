import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extensions/brightness.dart';

import '../app.dart';
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
  Duration? get elThemeDuration => ElApp.of(this).globalThemeDuration;

  /// 全局默认主题过渡动画曲线。
  Curve? get elThemeCurve => ElApp.of(this).globalThemeCurve;
}

/// BuildContext 扩展方法，仅限内部使用
extension BuildContextExtension on BuildContext {
  ElThemeData get theme => ElApp.of(this).theme;

  ElThemeData get darkTheme => ElApp.of(this).darkTheme;
}
