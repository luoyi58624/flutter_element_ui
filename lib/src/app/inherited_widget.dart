part of '../app.dart';


/// 响应式全局配置小部件
class _ElResponsive extends InheritedWidget {
  const _ElResponsive({
    required super.child,
    required this.data,
  });

  final ElResponsiveData data;

  static ElResponsiveData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElResponsive>()?.data ??
      const ElResponsiveData();

  @override
  bool updateShouldNotify(_ElResponsive oldWidget) => false;
}

/// 平台亮度小部件，抹平[MaterialApp]、[CupertinoApp]等不同主题系统获取暗黑主题的差异
class _ElBrightness extends InheritedWidget {
  const _ElBrightness({
    required super.child,
    this.brightness,
  });

  /// 当前平台的亮度模式, 如果不指定, 则跟随系统: [MediaQueryData.platformBrightness]
  final Brightness? brightness;

  /// 通过上下文获取当前[Brightness]，如果你没有注入此小部件，则跟随系统
  static Brightness of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElBrightness>()?.brightness ??
      MediaQuery.of(context).platformBrightness;

  @override
  bool updateShouldNotify(_ElBrightness oldWidget) => true;
}

/// Element UI 全局鼠标光标样式。
///
/// 提示：[MouseRegion]的重建不会触发内部的子组件build。
class _ElGlobalCursor extends StatelessWidget {
  const _ElGlobalCursor({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return MouseRegion(
        cursor: $el._cursor.value,
        child: child,
      );
    });
  }
}
