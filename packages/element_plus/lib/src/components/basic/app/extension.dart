part of 'index.dart';

extension ElAppExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : lightTheme;

  /// Element UI 自适应动画主题，引用的值具有动画插值，但请注意两点：
  /// 1. 不要和隐式动画小部件一起使用，只要你在 build 方法中引用了 [elAnimatedTheme]，
  /// 当全局主题发生变化时就会每一帧 build 依赖它的小部件，这会影响隐式动画小部件的正常工作。
  /// 2. 不要使用依赖 [isDark] 变量的扩展函数，例如颜色扩展：elLight，因为当切换主题模式时，
  /// [isDark] 是立即发生变化，导致依赖 [isDark] 的颜色扩展会立刻转变至另一种模式，然后再慢慢进行线性插值。
  ///
  /// 这也是为什么需要保留 [elTheme]，很多组件内部都使用了隐式动画小部件，
  /// 它们使用 [elTheme] + [elDuration] 解决过渡一致性问题。

  // 对于使用者而言，如果你不考虑全局主题过渡动画，这样你可以忽视上面的问题。
  ElThemeData get elAnimatedTheme => ElTheme.of(this);

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

  /// Element UI 自适应全局动画曲线扩展方法
  Curve elCurve([Curve? curve]) =>
      _ThemeAnimationInheritedWidget.of(this).themeCurve ??
      curve ??
      Curves.linear;
}
