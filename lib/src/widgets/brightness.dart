import 'package:flutter/material.dart';

class BrightnessWidget extends InheritedWidget {
  /// 平台亮度小部件，通过此小部件用于抹平不同主题设计系统访问主题的差异，例如：
  /// ```dart
  /// Theme.of(context).brightness == Brightness.dark;
  /// CupertinoTheme.of(context).brightness == Brightness.dark;
  /// ```
  const BrightnessWidget({
    super.key,
    required super.child,
    this.brightness,
  });

  final Brightness? brightness;

  static Brightness of(BuildContext context) {
    final BrightnessWidget? result =
        context.dependOnInheritedWidgetOfExactType<BrightnessWidget>();
    return result?.brightness ?? MediaQuery.of(context).platformBrightness;
  }

  @override
  bool updateShouldNotify(BrightnessWidget oldWidget) => true;
}
