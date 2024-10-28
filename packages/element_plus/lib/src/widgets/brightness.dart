import 'package:flutter/material.dart';

class ElBrightness extends InheritedWidget {
  /// 平台亮度小部件，默认情况下，Element UI 会从 [Theme] 小部件中访问当前主题模式
  const ElBrightness({
    super.key,
    this.brightness,
    required super.child,
  });

  /// 自定义当前的主题模式，如果你想对 Element UI 局部组件应用 light \ dark 主题模式，
  /// 只需要包裹 [ElBrightness] 小部件即可
  final Brightness? brightness;

  /// 从当前上下文获取主题模式
  static Brightness of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElBrightness>()?.brightness ??
      Theme.of(context).brightness;

  @override
  bool updateShouldNotify(ElBrightness oldWidget) => true;
}
