part of '../app.dart';

extension ElThemeExtension on BuildContext {
  /// Element UI 全局配置
  ElConfigData get elConfig => ElApp.of(this).config;

  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : theme;
}

// =============================================================================
// 没有以 el 开头命名的扩展函数很可能与其他库出现冲突，你可以先隐藏冲突的扩展函数，
// 然后新建一个文件将这些冲突的扩展函数进行简单的包装，最后使用你自己包装的 api 即可：
// ```dart
// extension MyExtension on BuildContext {
//   bool get $xs => xs;
//   bool get $isDark => isDark;
// }
// ```
// =============================================================================
extension ElResponsiveExtension on BuildContext {
  /// 极小设备，最大宽度默认320
  bool get xs => MediaQuery.sizeOf(this).width <= _ElResponsive.of(this).xs;

  /// 移动端设备，最大宽度默认640
  bool get sm => MediaQuery.sizeOf(this).width <= _ElResponsive.of(this).sm;

  /// 平板设备，最大宽度默认1024
  bool get md => MediaQuery.sizeOf(this).width <= _ElResponsive.of(this).md;

  /// 桌面设备，最大宽度默认1920
  bool get lg => MediaQuery.sizeOf(this).width <= _ElResponsive.of(this).lg;

  /// 大屏桌面设备，最大宽度默认2560
  bool get xl => MediaQuery.sizeOf(this).width <= _ElResponsive.of(this).xl;
}

extension ElBrightnessExtension on BuildContext {
  /// 当前平台亮度模式
  Brightness get brightness => _ElBrightness.of(this);

  /// 当前环境是否是暗黑模式
  bool get isDark => brightness == Brightness.dark;
}

