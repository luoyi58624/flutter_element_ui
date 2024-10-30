part of 'index.dart';

extension ElAppExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : lightTheme;

  /// Element UI 自适应动画主题，引用的值具有动画插值，请注意两点：
  /// 1. 不要用于隐式动画小部件，因为隐式动画小部件本身就会对值进行线性插值，同时使用一定会造成状态不同步问题；
  /// 2. 不要使用依赖 [isDark] 变量的扩展函数，bool 类型不具备线性插值，例如 Element UI 提供的颜色扩展；
  ///
  /// 这也是为什么需要单独保留 [elTheme]，针对以上限制，请使用 [elTheme] + [elDuration] 组合。
  ///
  /// 还有一点请注意：当你决定使用 [elTheme] 实现隐式动画时，就千万不要再引用 [elAnimatedTheme]，
  /// 如果小部件任何一个地方引用了 [elAnimatedTheme]，当主题发生变化时会不断构建依赖的小部件，
  /// 这不仅会造成性能浪费，而且会影响隐式动画小部件的正常工作。

  // Flutter 的动画主题设计很复杂，这几乎无法避免，例如 Material，它的设计真的非常复杂，
  // 说实话，我建议你不要考虑全局过渡动画，如果不考虑全局过渡动画，这样你可以忽视上面的所有问题，
  // 如果想对 hover、tap 等状态应用过渡，那就用隐式动画小部件，动画时间使用 elDuration 进行包裹。
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
