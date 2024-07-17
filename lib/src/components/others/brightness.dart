import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// 平台亮度小部件，抹平[MaterialApp]、[CupertinoApp]等不同主题系统获取暗黑主题的差异
class ElBrightness extends InheritedWidget {
  const ElBrightness({
    super.key,
    required super.child,
    this.brightness,
  });

  /// 当前平台的亮度模式, 如果不指定, 则跟随系统: [MediaQueryData.platformBrightness]
  final Brightness? brightness;

  /// 通过上下文获取当前[Brightness]，如果你没有注入此小部件，则跟随系统
  static Brightness of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElBrightness>()?.brightness ??
      MediaQuery.of(context).platformBrightness;

  @override
  bool updateShouldNotify(ElBrightness oldWidget) => true;
}
