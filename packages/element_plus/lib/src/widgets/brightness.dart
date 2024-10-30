import 'package:flutter/material.dart';

import '../components/basic/app/index.dart';

class ElBrightness extends InheritedWidget {
  /// Element UI 主题模式小部件
  const ElBrightness({
    super.key,
    this.brightness,
    required super.child,
  });

  final Brightness? brightness;

  /// 从当前上下文获取主题模式
  static Brightness of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElBrightness>()?.brightness ??
      ElApp.of(context).brightness;

  @override
  bool updateShouldNotify(ElBrightness oldWidget) => true;
}
