part of 'index.dart';

extension ElAppExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme =>
      isDark ? ElApp.of(this).darkTheme : ElApp.of(this).theme;

  /// Element UI 自适应动画主题，引用的值具有动画插值
  ElThemeData get elAnimatedTheme => ElTheme.of(this);

  /// Element UI 全局配置
  ElConfigData get elConfig => ElApp.of(this).config;

  /// Element UI 自适应全局主题动画时间扩展方法，此方法用于隐式动画小部件：
  /// ```dart
  /// AnimatedContainer(
  ///   duration: context.elDuration(300.ms),
  /// ),
  /// ```
  Duration elDuration([Duration? duration]) =>
      _ThemeAnimationInheritedWidget.of(this).themeDuration ??
      duration ??
      Duration.zero;

  /// Element UI 自适应全局动画曲线扩展方法
  Curve elCurve([Curve? curve]) =>
      _ThemeAnimationInheritedWidget.of(this).themeCurve ??
      curve ??
      Curves.linear;
}
