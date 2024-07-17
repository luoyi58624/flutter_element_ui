import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';

import '../app.dart';
import '../components/others/brightness.dart';
import '../components/others/responsive.dart';
import '../styles/theme.dart';

extension ElAppExtension on BuildContext {
  /// Element UI 全局配置
  ElConfigData get elConfig => ElApp.of(this).config;

  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : theme;
}

extension ElBrightnessExtension on BuildContext {
  /// 当前平台亮度模式
  Brightness get brightness => ElBrightness.of(this);

  /// 当前环境是否是暗黑模式
  bool get isDark => brightness == Brightness.dark;
}

extension ElResponsiveExtension on BuildContext {
  /// 极小设备，最大宽度默认320
  bool get xs => MediaQuery.sizeOf(this).width <= ElResponsive.of(this).xs;

  /// 移动端设备，最大宽度默认640
  bool get sm => MediaQuery.sizeOf(this).width <= ElResponsive.of(this).sm;

  /// 平板设备，最大宽度默认1024
  bool get md => MediaQuery.sizeOf(this).width <= ElResponsive.of(this).md;

  /// 桌面设备，最大宽度默认1920
  bool get lg => MediaQuery.sizeOf(this).width <= ElResponsive.of(this).lg;

  /// 大屏桌面设备，最大宽度默认2560
  bool get xl => MediaQuery.sizeOf(this).width <= ElResponsive.of(this).xl;
}
