import 'dart:ui';

import 'package:flutter/widgets.dart';

import 'styles/theme.dart';
import 'theme.dart';

class ElApp extends StatelessWidget {
  /// Element UI 顶级小部件，此小部件并不强制你必须使用，你完全可以使用其他 App 构建应用，
  /// 在这种情况下，所有小部件将应用默认的主题系统，如果你需要自定义全局主题，
  /// 只需在任意 App 下插入[ElTheme]小部件即可：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(child: child!),
  /// );
  /// ```
  const ElApp({
    super.key,
    this.home,
    this.title,
    this.theme,
    this.darkTheme,
    this.config,
    this.responsive,
    this.brightness,
    this.builder,
  }) : routerConfig = null;

  /// 以声明式路由构建App
  const ElApp.router({
    super.key,
    required this.routerConfig,
    this.title,
    this.theme,
    this.darkTheme,
    this.config,
    this.responsive,
    this.brightness,
    this.builder,
  }) : home = null;

  final Widget? home;

  /// Element UI 是面向桌面端的组件库
  final RouterConfig<Object>? routerConfig;

  final String? title;

  /// 亮色主题
  final ElThemeData? theme;

  /// 暗色主题
  final ElThemeData? darkTheme;

  /// 全局配置
  final ElConfigData? config;

  /// 响应式配置
  final ElResponsiveData? responsive;

  /// 指定 Element UI 小部件应用的主题模式，如果为空，则跟随平台系统
  final Brightness? brightness;

  /// 在导航器上方插入自定义小部件
  final TransitionBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return ElTheme(
      theme: theme,
      darkTheme: darkTheme,
      config: config,
      responsive: responsive,
      brightness: brightness,
      child: WidgetsApp.router(
        color: const Color(0x00000000),
        routerConfig: routerConfig,
      ),
    );
  }
}
