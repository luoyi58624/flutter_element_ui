import 'package:flutter/widgets.dart';

/// 响应式全局配置小部件
class ElResponsive extends InheritedWidget {
  const ElResponsive({
    super.key,
    required super.child,
    required this.data,
  });

  final ElResponsiveData data;

  static ElResponsiveData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElResponsive>()?.data ??
      const ElResponsiveData();

  @override
  bool updateShouldNotify(ElResponsive oldWidget) => false;
}

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

  ElResponsiveData copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return ElResponsiveData(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }
}
