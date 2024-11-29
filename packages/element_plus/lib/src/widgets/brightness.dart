import 'package:element_extension/element_extension.dart';
import 'package:flutter/material.dart';

import '../app/index.dart';

extension ElBrightnessExtension on BuildContext {
  /// 获取当平台亮度模式
  Brightness get brightness => ElBrightness.of(this);

  /// 当前环境是否是暗黑模式
  bool get isDark => brightness.isDark;
}

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
