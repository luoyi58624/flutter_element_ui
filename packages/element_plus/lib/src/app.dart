import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'global.dart';
import 'themes/components/basic/text.dart';
import 'themes/config.dart';
import 'themes/theme.dart';

class ElApp extends StatefulWidget {
  /// Element UI 全局配置小部件
  const ElApp({
    super.key,
    required this.child,
    this.brightness,
    this.theme,
    this.darkTheme,
    this.config,
  });

  final Widget child;

  /// 当前主题模式，默认通过 [Theme] 访问
  final Brightness? brightness;

  /// 自定义亮色主题
  final ElThemeData? theme;

  /// 自定义暗色主题
  final ElThemeData? darkTheme;

  /// 全局配置
  final ElConfigThemeData? config;

  /// 通过上下文 context 访问注入的全局主题配置
  static AppData of(BuildContext context) =>
      _AppInheritedWidget.maybeOf(context) ?? const AppData();

  /// 构建 Element UI 默认文本主题、[Overlay] 浮层、滚动配置...
  static Widget Function(BuildContext, Widget?) builder(
          [TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        final $data = ElApp.of(context);

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
          child: ElAnimatedTextTheme(
            duration: context.elDuration(),
            curve: context.elCurve(),
            data: ElTextThemeData(
              style: context.elTheme.textTheme.style,
            ),
            child: ScrollConfiguration(
              behavior: const ElScrollBehavior(),
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

  ElConfigThemeData get config => widget.config ?? ElConfigThemeData.data;

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
    _themeDuration = config.themeDuration;
    _themeCurve = config.themeCurve;
    _timer = setTimeout(() {
      if (mounted) {
        setState(() {
          _themeDuration = null;
          _themeCurve = null;
          _timer = null;
        });
      }
    }, max(500, config.themeDuration.inMilliseconds));
  }

  @override
  Widget build(BuildContext context) {
    return _AppInheritedWidget(
      AppData(
        theme: widget.theme ?? ElThemeData.theme,
        darkTheme: widget.darkTheme ?? ElThemeData.darkTheme,
        config: config,
        themeDuration: _themeDuration,
        themeCurve: _themeCurve,
      ),
      child: widget.child,
    );
  }
}

class _AppInheritedWidget extends InheritedWidget {
  const _AppInheritedWidget(
    this.data, {
    required super.child,
  });

  final AppData data;

  static AppData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_AppInheritedWidget>()?.data;

  @override
  bool updateShouldNotify(_AppInheritedWidget oldWidget) {
    return true;
  }
}

/// ElApp 注入的全局数据，你可以通过 [ElApp.of] 方法访问它们
class AppData {
  final Brightness? brightness;

  /// 亮色主题配置
  final ElThemeData theme;

  /// 暗色主题配置
  final ElThemeData darkTheme;

  /// 全局配置
  final ElConfigThemeData config;

  /// 当 [brightness] 发生变化时，[ElApp] 会构建两次 build 方法：
  /// * 第一次构建前先设置全局动画时间: [config.themeDuration]，保证整体页面过渡一致性
  /// * 然后将此变量还原为 null，触发第二次构建，让小部件将使用自己的动画时间
  final Duration? themeDuration;

  /// 全局主题动画曲线
  final Curve? themeCurve;

  const AppData({
    this.brightness,
    this.theme = ElThemeData.theme,
    this.darkTheme = ElThemeData.darkTheme,
    this.config = ElConfigThemeData.data,
    this.themeDuration,
    this.themeCurve,
  });
}
