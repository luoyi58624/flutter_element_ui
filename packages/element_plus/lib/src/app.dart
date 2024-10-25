import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'global.dart';
import 'themes/config.dart';
import 'themes/theme.dart';

/// ElApp 注入的全局数据，你可以通过 [ElApp.of] 方法访问它们
class ElAppData {
  /// 当前的主题模式
  final Brightness brightness;

  /// 亮色主题配置
  final ElThemeData theme;

  /// 暗色主题配置
  final ElThemeData darkTheme;

  /// 全局配置
  final ElConfigThemeData config;

  /// 默认的滚动行为
  final ScrollBehavior scrollBehavior;

  /// 当 [brightness] 发生变化时，[ElApp] 会构建两次 build 方法：
  /// * 第一次构建前先设置全局动画时间: [config.themeDuration]，保证整体页面过渡一致性
  /// * 然后将此变量还原为 null，触发第二次构建，让小部件将使用自己的动画时间
  final Duration? themeDuration;

  /// 全局主题动画曲线
  final Curve? themeCurve;

  ElAppData({
    required this.brightness,
    required this.theme,
    required this.darkTheme,
    required this.config,
    required this.scrollBehavior,
    this.themeDuration,
    this.themeCurve,
  });
}

class ElApp extends StatefulWidget {
  /// Element UI 全局配置小部件，使用方式：
  /// ```dart
  /// ElApp(
  ///   child: MaterialApp(
  ///     builder: ElApp.builder(),
  ///   ),
  /// );
  /// ```
  const ElApp({
    super.key,
    required this.child,
    this.brightness,
    this.theme,
    this.darkTheme,
    this.config = ElConfigThemeData.data,
    this.scrollBehavior = const ElScrollBehavior(),
  });

  /// 子组件
  final Widget child;

  /// 应用的主题模式，为 null 则表示跟随系统
  final Brightness? brightness;

  /// 亮色主题
  final ElThemeData? theme;

  /// 暗色主题
  final ElThemeData? darkTheme;

  /// 全局配置
  final ElConfigThemeData config;

  /// 自定义全局滚动行为，默认实现是 [ElScrollBehavior]，原生默认行为是 [ScrollBehavior]
  final ScrollBehavior scrollBehavior;

  /// 通过上下文 context 访问注入的全局主题配置
  static ElAppData of(BuildContext context) => _AppInheritedWidget.of(context);

  /// 构建 Element UI 默认文本主题、[Overlay] 浮层、滚动配置...
  static Widget Function(BuildContext, Widget?) builder(
          [TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        assert(child != null, 'ElApp builder child 参数不能为空');
        final $data = _AppInheritedWidget.of(context);

        // 创建默认遮罩小部件，否则使用依赖浮层元素 api 时会报错，例如：message、toast、loading
        Widget result = Overlay(initialEntries: [
          OverlayEntry(
            builder: (context) => child!,
          ),
        ]);

        // 在 Overlay 之上构建自定义小部件，可以避免 context 上下文bug
        if (builder != null) result = builder(context, result);

        return Material(
          animationDuration: $data.config.themeDuration,
          color: context.elTheme.bgColor,
          textStyle: context.elTheme.textTheme.style,
          child: ElAnimatedDefaultTextStyle(
            duration: context.elDuration(),
            curve: context.elCurve(),
            style: context.elTheme.textTheme.style,
            child: ScrollConfiguration(
              behavior: $data.scrollBehavior,
              child: result,
            ),
          ),
        );
      };

  @override
  State<ElApp> createState() => _ElAppState();
}

class _ElAppState extends State<ElApp> {
  Duration? _themeDuration;
  Curve? _themeCurve;
  Timer? _timer;

  @override
  void didUpdateWidget(covariant ElApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.brightness != oldWidget.brightness) {
      _changeTheme();
    }
  }

  /// 当主题发生变化时，会设置全局主题变更持续时间和动画曲线，这样可以同步整体页面动画过渡效果
  void _changeTheme() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _themeDuration = widget.config.themeDuration;
    _themeCurve = widget.config.themeCurve;
    _timer = setTimeout(() {
      if (mounted) {
        setState(() {
          _themeDuration = null;
          _themeCurve = null;
          _timer = null;
        });
      }
    }, max(500, widget.config.themeDuration.inMilliseconds));
  }

  bool get isDark => widget.brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    Brightness $brightness =
        widget.brightness ?? MediaQuery.platformBrightnessOf(context);

    return ElAnimatedTheme(
      duration: 1000.ms,
      data: $brightness == Brightness.dark
          ? widget.darkTheme ?? ElThemeData.darkTheme
          : widget.theme ?? ElThemeData.theme,
      child: _AppInheritedWidget(
        ElAppData(
          brightness: $brightness,
          theme: widget.theme ?? ElThemeData.theme,
          darkTheme: widget.darkTheme ?? ElThemeData.darkTheme,
          config: widget.config,
          scrollBehavior: widget.scrollBehavior,
          themeDuration: _themeDuration,
          themeCurve: _themeCurve,
        ),
        child: widget.child,
      ),
    );
  }
}

class _AppInheritedWidget extends InheritedWidget {
  const _AppInheritedWidget(
    this.data, {
    required super.child,
  });

  final ElAppData data;

  static ElAppData of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<_AppInheritedWidget>();
    assert(
        result != null,
        '当前上下文 context 没有找到 Element UI 全局主题配置，'
        '如果你已配置了 ElApp，请尝试使用 Builder 小部件转发 context。');
    return result!.data;
  }

  @override
  bool updateShouldNotify(_AppInheritedWidget oldWidget) {
    return true;
  }
}


// class ElAnimatedTheme extends ImplicitlyAnimatedWidget {
//   const ElAnimatedTheme({
//     super.key,
//     required this.data,
//     super.curve,
//     super.duration = kThemeAnimationDuration,
//     super.onEnd,
//     required this.child,
//   });
//
//   final ElThemeData data;
//   final Widget child;
//
//   @override
//   AnimatedWidgetBaseState<ElAnimatedTheme> createState() =>
//       _ElAnimatedThemeState();
// }
//
// class _ElAnimatedThemeState extends AnimatedWidgetBaseState<ElAnimatedTheme> {
//   ElThemeDataTween? _data;
//
//   @override
//   void forEachTween(TweenVisitor<dynamic> visitor) {
//     _data = visitor(_data, widget.data,
//             (dynamic value) => ElThemeDataTween(begin: value as ElThemeData))!
//         as ElThemeDataTween;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ElTheme(
//       data: _data!.evaluate(animation),
//       child: widget.child,
//     );
//   }
// }
