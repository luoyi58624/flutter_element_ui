part of 'index.dart';

extension ElResponsiveExtension on BuildContext {
  bool get xs => MediaQuery.sizeOf(this).width <= ElApp.of(this).responsive.xs;

  bool get sm => MediaQuery.sizeOf(this).width <= ElApp.of(this).responsive.sm;

  bool get md => MediaQuery.sizeOf(this).width <= ElApp.of(this).responsive.md;

  bool get lg => MediaQuery.sizeOf(this).width <= ElApp.of(this).responsive.lg;

  bool get xl => MediaQuery.sizeOf(this).width <= ElApp.of(this).responsive.xl;
}

class ElResponsiveData {
  /// 默认的响应式断点配置
  const ElResponsiveData({
    this.xs = 320,
    this.sm = 640,
    this.md = 1024,
    this.lg = 1920,
    this.xl = 2560,
  });

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
}
