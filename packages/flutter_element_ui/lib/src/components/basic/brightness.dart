import 'dart:ui';

import 'package:flutter/widgets.dart';

extension ElBrightnessExtension on BuildContext {
  /// 当前环境是否是暗黑模式，如果你没有获取到[Brightness]，则跟随系统
  bool get isDark => ElBrightness.isDark(this);
}

/// 平台亮度小部件，抹平[MaterialApp]、[CupertinoApp]等不同主题系统获取暗黑主题的差异
///
/// 示例：
/// ```dart
/// // MaterialApp下判断是否是暗黑主题
/// Theme.of(context).brightness == Brightness.dark;
///
/// // CupertinoApp下判断是否是暗黑主题
/// CupertinoTheme.of(context).brightness == Brightness.dark;
///
/// // 使用小部件判断当前是否是暗黑主题
/// ElBrightness.isDark(context);
/// ```
///
/// 使用：
/// ```dart
/// MaterialApp(
///   builder: (context, child) => ElBrightness(
///     brightness: Theme.of(context).brightness,
///     child: child!,
///   ),
/// );
///
/// CupertinoApp(
///   builder: (context, child) => ElBrightness(
///     brightness: CupertinoTheme.of(context).brightness,
///     child: child!,
///   ),
/// );
/// ```
class ElBrightness extends InheritedWidget {
  const ElBrightness({
    super.key,
    required super.child,
    this.brightness,
  });

  /// 当前平台的亮度模式, 如果不指定, 则跟随系统: [MediaQueryData.platformBrightness]
  final Brightness? brightness;

  /// 判断当前是否是黑暗模式
  static bool isDark(BuildContext context) => of(context) == Brightness.dark;

  /// 通过上下文获取[Brightness]，如果你没有注入此小部件，则跟随系统
  static Brightness of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElBrightness>()?.brightness ??
      MediaQuery.of(context).platformBrightness;

  @override
  bool updateShouldNotify(ElBrightness oldWidget) => true;
}
