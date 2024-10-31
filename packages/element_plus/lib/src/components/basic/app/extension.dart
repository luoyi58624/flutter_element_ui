part of 'index.dart';

extension ElAppExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : lightTheme;

  /// Element UI 全局配置
  ElConfigData get elConfig => ElApp.of(this).config;

  /// Element UI 自适应全局主题动画时间扩展方法，此方法用于保证隐式动画小部件状态一致性：
  /// ```dart
  /// AnimatedContainer(
  ///   duration: context.elDuration(300.ms),
  /// ),
  /// ```
  Duration elDuration([Duration? duration]) =>
      _ThemeAnimationInheritedWidget.of(this).themeDuration ??
      duration ??
      Duration.zero;
}
