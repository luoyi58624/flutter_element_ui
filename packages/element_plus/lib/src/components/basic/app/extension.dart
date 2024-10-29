part of 'index.dart';

extension ElAppExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme =>
      isDark ? ElApp.of(this).darkTheme : ElApp.of(this).theme;

  /// Element UI 自适应动画主题，引用的值具有动画特性，注意：它只适用于普通小部件，不适用于隐式动画小部件
  ElThemeData get elAnimatedTheme => ElTheme.of(this);

  /// Element UI 全局配置
  ElConfigThemeData get elConfig => ElApp.of(this).config;

  /// Element UI 全局主题动画时间扩展方法，此方法用于隐式动画小部件，例如：
  /// ```dart
  /// AnimatedContainer(
  ///   duration: context.elDuration(300.ms),
  /// ),
  /// ```
  ///
  /// 当切换全局主题时，[AnimatedContainer] 应用的值将是 [ElConfigThemeData] 配置的 themeDuration，
  /// 动画结束后会自动触发第二次重建，用于重置全局默认的持续时间，这时 [AnimatedContainer] 应用的值将是用户自定义的持续时间。
  Duration elDuration([Duration? duration]) =>
      _ThemeAnimationInheritedWidget.of(this).themeDuration ??
      duration ??
      Duration.zero;

  /// Element UI 动画曲线扩展方法
  Curve elCurve([Curve? curve]) =>
      _ThemeAnimationInheritedWidget.of(this).themeCurve ??
      curve ??
      Curves.linear;
}
