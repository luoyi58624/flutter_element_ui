import 'package:flutter/widgets.dart';

/// 以整个应用尺寸作为响应式断点
extension ResponsiveExtension on BuildContext {
  /// 极小设备，最大宽度默认320
  bool get xs => MediaQuery.sizeOf(this).width <= responsiveData.xs;

  /// 移动端设备，最大宽度默认640
  bool get sm => MediaQuery.sizeOf(this).width <= responsiveData.sm;

  /// 平板设备，最大宽度默认1024
  bool get md => MediaQuery.sizeOf(this).width <= responsiveData.md;

  /// 桌面设备，最大宽度默认1920
  bool get lg => MediaQuery.sizeOf(this).width <= responsiveData.lg;

  /// 大屏桌面设备，最大宽度默认2560
  bool get xl => MediaQuery.sizeOf(this).width <= responsiveData.xl;
}

/// 以单个 Widget 尺寸作为响应式断点，通常配合 [LayoutBuilder] 进行使用
extension BoxResponsiveExtension on BoxConstraints {
  /// 极小设备，最大宽度默认320
  bool get xs => maxWidth <= responsiveData.xs;

  /// 移动端设备，最大宽度默认640
  bool get sm => maxWidth <= responsiveData.sm;

  /// 平板设备，最大宽度默认1024
  bool get md => maxWidth <= responsiveData.md;

  /// 桌面设备，最大宽度默认1920
  bool get lg => maxWidth <= responsiveData.lg;

  /// 大屏桌面设备，最大宽度默认2560
  bool get xl => maxWidth <= responsiveData.xl;
}

/// 响应式实例对象
const ResponsiveData responsiveData = ResponsiveData();

/// 响应式配置
class ResponsiveData {
  /// 特小号设备最大尺寸
  final double xs;

  /// 移动设备最大尺寸
  final double sm;

  /// 平板设备最大尺寸
  final double md;

  /// 桌面设备最大尺寸
  final double lg;

  /// 大屏桌面设备最大尺寸
  final double xl;

  const ResponsiveData({
    this.xs = 320,
    this.sm = 640,
    this.md = 1024,
    this.lg = 1920,
    this.xl = 2560,
  });
}
