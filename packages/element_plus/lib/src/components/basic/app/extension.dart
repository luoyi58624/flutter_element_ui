part of 'index.dart';

extension ElAppExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : lightTheme;

  /// Element UI 全局配置
  ElConfigData get elConfig => ElApp.of(this).config;

  /// 此方法用于保证隐式动画小部件状态一致性，当更新全局主题时，此方法将返回 [Duration.zero]，
  /// 用于禁止所有隐式动画小部件的过渡，然后在短时间后重置状态，使用方式：
  /// ```dart
  /// AnimatedContainer(
  ///   duration: context.elDuration(300.ms),
  /// ),
  /// ```
  ///
  /// 如果你使用 [MaterialApp]，请将 themeAnimationDuration 属性设置为 [Duration.zero]，
  /// 因为 Element UI 没有对主题实现 lerp 线性插值（之前有，但后来移除掉了），原因如下：
  /// 1. 实现全局主题过渡让代码复杂度提升数倍，你很难把控与隐式动画小部件一起工作，因为 [AnimatedTheme] 也是一个隐式动画小部件；
  /// 2. 全局主题过渡对性能产生非常大的影响，因为它意味着从顶级 App 开始，每一帧都在不断 build 所有子树；
  ///
  /// 第一点是最致命的，所以对全局主题进行线性插值毫无意义，你所得到的仅限于切换黑暗模式有一个渐变效果。
  Duration elDuration([Duration? duration]) =>
      _SwitchThemeAnimationInheritedWidget.of(this).themeDuration ??
      duration ??
      Duration.zero;
}
