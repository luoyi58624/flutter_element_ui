part of 'index.dart';

extension ElAppExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : lightTheme;

  /// Element UI 全局配置
  ElConfigData get elConfig => ElConfig.of(this);

  /// 访问当前配置的尺寸预设
  String get elSize => ElSize.of(this).size;

  /// 此方法用于保证隐式动画小部件状态一致性，当更新全局主题时，此方法将返回 [Duration.zero]，
  /// 用于禁止所有隐式动画小部件的过渡，然后在一定时间后重置状态，使用方式：
  /// ```dart
  /// AnimatedContainer(
  ///   duration: context.elDuration(300.ms),
  /// ),
  /// ```
  ///
  /// 如果你使用 [MaterialApp]，请将 themeAnimationDuration 属性设置为 [Duration.zero]，
  /// 因为 Element UI 没有对全局主题实现 lerp 线性插值（以前有，但后来移除了），原因如下：
  /// 1. 实现全局主题过渡让代码复杂度提升数倍，你很难把控与隐式动画小部件一起工作；
  /// 2. 全局主题过渡非常影响性能，因为它意味着从顶级 App 开始，每一帧都在对依赖它的所有子树进行线性插值；
  Duration elDuration([Duration? duration]) =>
      _SwitchThemeAnimationInheritedWidget.of(this).themeDuration ??
      duration ??
      Duration.zero;
}
