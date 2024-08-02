import 'package:flutter/material.dart';

import '../components/basic/scrollbar.dart';
import '../core.dart';
import '../styles/theme.dart';

extension ElAppExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? el.darkTheme : el.lightTheme;

  /// Element UI 主题颜色集合
  Map<String, Color> get elThemeColors => {
        'primary': elTheme.primary,
        'success': elTheme.success,
        'info': elTheme.info,
        'warning': elTheme.warning,
        'error': elTheme.error,
      };
}

extension ElBrightnessExtension on BuildContext {
  /// 当前环境是否是暗黑模式
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

extension ElResponsiveExtension on BuildContext {
  /// 极小设备，最大宽度默认320
  bool get xs => MediaQuery.sizeOf(this).width <= el.responsive.xs;

  /// 移动端设备，最大宽度默认640
  bool get sm => MediaQuery.sizeOf(this).width <= el.responsive.sm;

  /// 平板设备，最大宽度默认1024
  bool get md => MediaQuery.sizeOf(this).width <= el.responsive.md;

  /// 桌面设备，最大宽度默认1920
  bool get lg => MediaQuery.sizeOf(this).width <= el.responsive.lg;

  /// 大屏桌面设备，最大宽度默认2560
  bool get xl => MediaQuery.sizeOf(this).width <= el.responsive.xl;
}

extension ElWidgetExtension on Widget {
  /// 禁止使用祖先定义的默认的滚动条，如果你希望当前滚动小部件不使用滚动条，或者你正在使用自定义滚动条，
  /// 那么只需在小部件的末尾添加这个扩展方法即可
  Widget get noScrollBehavior => ScrollConfiguration(
        behavior: const ElNoScrollBehavior(),
        child: this,
      );
}
