import 'package:flutter/widgets.dart';

/// 以整个应用尺寸作为响应式断点
extension ElResponsiveExtension on BuildContext {
  /// 极小设备，最大宽度默认320
  bool get xs => MediaQuery.sizeOf(this).width <= _responsiveData.xs;

  /// 移动端设备，最大宽度默认640
  bool get sm => MediaQuery.sizeOf(this).width <= _responsiveData.sm;

  /// 平板设备，最大宽度默认1024
  bool get md => MediaQuery.sizeOf(this).width <= _responsiveData.md;

  /// 桌面设备，最大宽度默认1920
  bool get lg => MediaQuery.sizeOf(this).width <= _responsiveData.lg;

  /// 大屏桌面设备，最大宽度默认2560
  bool get xl => MediaQuery.sizeOf(this).width <= _responsiveData.xl;
}

/// 以单个 Widget 尺寸作为响应式断点，通常配合 [LayoutBuilder] 进行使用
extension ElBoxResponsiveExtension on BoxConstraints {
  /// 极小设备，最大宽度默认320
  bool get xs => maxWidth <= _responsiveData.xs;

  /// 移动端设备，最大宽度默认640
  bool get sm => maxWidth <= _responsiveData.sm;

  /// 平板设备，最大宽度默认1024
  bool get md => maxWidth <= _responsiveData.md;

  /// 桌面设备，最大宽度默认1920
  bool get lg => maxWidth <= _responsiveData.lg;

  /// 大屏桌面设备，最大宽度默认2560
  bool get xl => maxWidth <= _responsiveData.xl;
}

/// 不允许对默认的响应式配置做自定义操作，因为会破坏 Element UI 组件逻辑，
/// 如果上述断点不适合你的业务，请屏蔽它们自行封装
const ElResponsiveData _responsiveData = ElResponsiveData();

/// 响应式配置
class ElResponsiveData {
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

  const ElResponsiveData({
    this.xs = 320,
    this.sm = 640,
    this.md = 1024,
    this.lg = 1920,
    this.xl = 2560,
  });
}
