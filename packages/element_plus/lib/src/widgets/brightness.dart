import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../app.dart';

extension ElBrightnessExtension on BuildContext {
  /// 获取当平台亮度模式
  Brightness? get brightness => ElBrightness.of(this);

  /// 当前环境是否是暗黑模式
  bool get isDark => brightness == Brightness.dark;
}

class ElBrightness extends InheritedWidget {
  /// 平台亮度小部件，此小部件用于局部主题
  const ElBrightness({
    super.key,
    this.brightness,
    required super.child,
  });

  /// 设置当前的主题模式，如果为 null 则跟随系统
  final Brightness? brightness;

  /// 从当前上下文获取当前的主题模式，如果为 null 则访问 [ElApp] 注入的全局主题
  static Brightness of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElBrightness>()?.brightness ??
      ElApp.of(context).brightness;

  @override
  bool updateShouldNotify(ElBrightness oldWidget) => true;
}
