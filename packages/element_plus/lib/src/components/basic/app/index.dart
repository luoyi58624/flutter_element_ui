import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../global.dart';
import '../../../themes/config.dart';
import '../../../themes/theme.dart';
import '../scrollbar.dart';

part 'extension.dart';

part 'theme_animation.dart';

class ElApp extends StatelessWidget {
  /// Element UI 全局配置小部件
  /// ```dart
  /// ElApp(
  ///   child: MaterialApp(
  ///     navigatorKey: el.navigatorKey,
  ///     builder: ElApp.builder(),
  ///   ),
  /// );
  /// ```
  const ElApp({
    super.key,
    required this.child,
    this.brightness,
    this.theme = ElThemeData.theme,
    this.darkTheme = ElThemeData.darkTheme,
    this.config = ElConfigThemeData.data,
  });

  final Widget child;

  /// 主题模式，如果为 null，则跟随系统
  final Brightness? brightness;

  /// 亮色主题
  final ElThemeData theme;

  /// 暗色主题
  final ElThemeData darkTheme;

  /// 全局配置
  final ElConfigThemeData config;

  /// 访问 ElApp 注入的全局配置信息
  static ElAppData of(BuildContext context) => _AppInheritedWidget.of(context);

  /// 提供给顶级 App builder 构建器，这里的内容必须构建在顶级 App 下面
  static Widget Function(BuildContext, Widget?) builder(
          [TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        // 构建默认的 Overlay 遮罩小部件，防止使用 message、toast 等 api 时报错
        Widget result = Overlay(initialEntries: [
          OverlayEntry(
            builder: (context) => child!,
          ),
        ]);
        if (builder != null) {
          result = builder(context, result);
        }

        // 应用 Element UI 滚动条策略
        return ScrollConfiguration(
          behavior: const ElScrollBehavior(),
          child: result,
        );
      };

  @override
  Widget build(BuildContext context) {
    final $brightness = brightness ?? MediaQuery.of(context).platformBrightness;
    ElThemeData $data = $brightness.isDark ? darkTheme : theme;

    return _AppInheritedWidget(
      ElAppData(
        brightness: $brightness,
        theme: theme,
        darkTheme: darkTheme,
        config: config,
      ),
      child: _ThemeAnimation(
        data: $data,
        child: ElAnimatedTheme(
          duration: config.themeDuration,
          data: $data,
          child: Builder(builder: (context) {
            return ElDefaultTextStyle(
              style: context.elAnimatedTheme.textTheme.textStyle,
              child: child,
            );
          }),
        ),
      ),
    );
  }
}

class ElAppData {
  final Brightness brightness;
  final ElThemeData theme;
  final ElThemeData darkTheme;
  final ElConfigThemeData config;

  const ElAppData({
    required this.brightness,
    required this.theme,
    required this.darkTheme,
    required this.config,
  });
}

class _AppInheritedWidget extends InheritedWidget {
  const _AppInheritedWidget(
    this.data, {
    required super.child,
  });

  final ElAppData data;

  static ElAppData of(BuildContext context) {
    final _AppInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_AppInheritedWidget>();
    assert(result != null,
        'ElApp.of(context) 没有找到，你是否配置了 ElApp 小部件？如果已配置，请使用 Builder 小部件转发 context 对象');
    return result!.data;
  }

  @override
  bool updateShouldNotify(_AppInheritedWidget oldWidget) {
    return true;
  }
}
