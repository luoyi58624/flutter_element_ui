import 'dart:async';
import 'dart:math';

import 'package:flutter/widgets.dart';

import '../global.dart';

final _globalThemeDuration = Obs<Duration?>(null);
final _globalThemeCurve = Obs<Curve?>(null);
Timer? _timer;

/// 全局主题样式
class GlobalThemeStyle extends StatelessWidget {
  const GlobalThemeStyle({super.key, required this.child});

  final Widget child;

  /// 改变主题前设置全局主题动画时间，这样可以令应用中所有动画小部件的过渡动画保持一致，
  /// * fun 实现切换主题的回调函数
  /// * delay 重置动画最小延迟时间，默认500毫秒
  // static void changeTheme(VoidCallback fun, [int? delay]) {
  //   if (_timer != null) {
  //     _timer!.cancel();
  //     _timer = null;
  //   }
  //   _globalThemeDuration.value = context.elConfig.themeDuration;
  //   _globalThemeCurve.value = el.themeCurve;
  //   fun();
  //   _timer = () {
  //     _globalThemeDuration.value = null;
  //     _globalThemeCurve.value = null;
  //     _timer = null;
  //   }.delay(max(delay ?? 500, context.elConfig.themeDuration.inMilliseconds));
  // }

  /// 通过上下文获取全局主题过渡持续时间
  static Duration? duration(BuildContext context) =>
      _GlobalThemeInheritedWidget.maybeOf(context)?.duration;

  /// 通过上下文获取全局主题过渡曲线动画
  static Curve? curve(BuildContext context) =>
      _GlobalThemeInheritedWidget.maybeOf(context)?.curve;

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(builder: (context) {
      return _GlobalThemeInheritedWidget(
        _globalThemeDuration.value,
        _globalThemeCurve.value,
        child: child,
      );
    });
  }
}

class _GlobalThemeInheritedWidget extends InheritedWidget {
  const _GlobalThemeInheritedWidget(
    this.duration,
    this.curve, {
    required super.child,
  });

  final Duration? duration;
  final Curve? curve;

  static _GlobalThemeInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_GlobalThemeInheritedWidget>();

  @override
  bool updateShouldNotify(_GlobalThemeInheritedWidget oldWidget) => true;
}
