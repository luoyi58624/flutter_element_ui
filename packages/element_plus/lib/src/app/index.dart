import 'dart:async';

import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'extension.dart';

part 'config.dart';

part 'size_preset.dart';

part 'responsive.dart';

part 'theme.dart';

part 'theme_animation.dart';

part '../generates/app/index.g.dart';

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
    this.theme,
    this.darkTheme,
    this.config,
    this.responsive = const ElResponsiveData(),
    this.size = El.medium,
    this.globalFontWeight = 0,
  });

  final Widget child;

  /// 应用的主题模式，如果为 null，则跟随系统
  final Brightness? brightness;

  /// 亮色主题
  final ElThemeData? theme;

  /// 暗色主题
  final ElThemeData? darkTheme;

  /// 全局配置
  final ElConfigData? config;

  /// 响应式断点配置
  final ElResponsiveData responsive;

  /// 全局组件尺寸预设，默认 [El.medium]
  final String size;

  /// 定义全局字体粗细级别
  final double globalFontWeight;

  /// 访问 ElApp 注入的全局配置信息
  static ElAppData of(BuildContext context) => _AppInheritedWidget.of(context);

  @override
  Widget build(BuildContext context) {
    final $brightness = brightness ?? MediaQuery.platformBrightnessOf(context);

    return _AppInheritedWidget(
      ElAppData(
        brightness: $brightness,
        theme: ElThemeData.theme.merge(theme),
        darkTheme: ElThemeData.darkTheme.merge(darkTheme),
        config: ElConfigData.globalData.merge(config),
        responsive: responsive,
      ),
      child: ElSize(
        size,
        child: Builder(builder: (context) {
          return _SwitchThemeAnimation(
            data: context.elTheme,
            child: child,
          );
        }),
      ),
    );
  }
}

class ElAppData {
  final Brightness brightness;
  final ElThemeData theme;
  final ElThemeData darkTheme;
  final ElConfigData config;
  final ElResponsiveData responsive;

  const ElAppData({
    required this.brightness,
    required this.theme,
    required this.darkTheme,
    required this.config,
    required this.responsive,
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
