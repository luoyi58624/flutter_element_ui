import 'package:flutter/material.dart';

import 'global.dart';
import 'themes/config.dart';
import 'themes/theme.dart';
import 'components/basic/scrollbar.dart';

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

  final Brightness? brightness;

  /// 亮色主题
  final ElThemeData theme;

  /// 暗色主题
  final ElThemeData darkTheme;

  /// 全局配置
  final ElConfigThemeData config;

  static AppData of(BuildContext context) => AppInheritedWidget.of(context);

  static Widget Function(BuildContext, Widget?) builder(
          [TransitionBuilder? builder]) =>
      (BuildContext context, Widget? child) {
        // 构建默认的 Overlay 遮罩小部件，防止使用 message、toast 等 api 时报错
        Widget result = Overlay(initialEntries: [
          OverlayEntry(
            builder: (context) => child!,
          ),
        ]);
        if (builder != null) result = builder(context, result);
        return ScrollConfiguration(
          behavior: const ElScrollBehavior(),
          child: result,
        );
      };

  @override
  Widget build(BuildContext context) {
    final $brightness = brightness ?? MediaQuery.of(context).platformBrightness;
    ElThemeData $data = $brightness.isDark ? darkTheme : theme;

    return AppInheritedWidget(
      AppData(
        brightness: $brightness,
        theme: theme,
        darkTheme: darkTheme,
        config: config,
      ),
      child: ThemeAnimation(
        data: $data,
        child: ElAnimatedTheme(
          duration: config.themeDuration,
          data: $data,
          child: child,
        ),
      ),
    );
  }
}

class AppData {
  final Brightness brightness;
  final ElThemeData theme;
  final ElThemeData darkTheme;
  final ElConfigThemeData config;

  const AppData({
    required this.brightness,
    required this.theme,
    required this.darkTheme,
    required this.config,
  });
}

class AppInheritedWidget extends InheritedWidget {
  const AppInheritedWidget(
    this.data, {
    super.key,
    required super.child,
  });

  final AppData data;

  static AppData of(BuildContext context) {
    final AppInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<AppInheritedWidget>();
    assert(result != null,
        'ElApp.of(context) 没有找到，你是否配置了 ElApp 小部件？如果已配置，请使用 Builder 小部件转发 context 对象');
    return result!.data;
  }

  @override
  bool updateShouldNotify(AppInheritedWidget oldWidget) {
    return true;
  }
}
