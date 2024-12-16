part of 'index.dart';

extension ElResponsiveExtension on BuildContext {
  bool get xs => MediaQuery.sizeOf(this).width <= ElResponsive.of(this).xs;

  bool get sm => MediaQuery.sizeOf(this).width <= ElResponsive.of(this).sm;

  bool get md => MediaQuery.sizeOf(this).width <= ElResponsive.of(this).md;

  bool get lg => MediaQuery.sizeOf(this).width <= ElResponsive.of(this).lg;

  bool get xl => MediaQuery.sizeOf(this).width <= ElResponsive.of(this).xl;
}

/// 小部件响应式断点配置
class ElResponsive extends InheritedWidget {
  const ElResponsive(
    this.data, {
    super.key,
    required super.child,
  });

  final ElResponsiveData data;

  /// 从当前上下文 context 获取的响应式断点配置
  static ElResponsiveData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElResponsive>()?.data ??
      const ElResponsiveData();

  @override
  bool updateShouldNotify(ElResponsive oldWidget) => data != oldWidget.data;
}

@ElModel.copy()
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

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
