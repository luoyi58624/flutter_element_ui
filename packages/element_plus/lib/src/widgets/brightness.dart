import 'package:flutter/material.dart';

import '../app/index.dart';

class ElBrightness extends InheritedWidget {
  /// Element UI 主题模式小部件
  const ElBrightness({
    super.key,
    this.brightness,
    required super.child,
  });

  final Brightness? brightness;

  /// 从当前上下文访问当前应用的主题模式：light、dark，优先访问局部主题模式，若没有则取全局主题模式
  static Brightness of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElBrightness>()?.brightness ??
      ElApp.of(context).brightness;

  @override
  bool updateShouldNotify(ElBrightness oldWidget) => true;
}
