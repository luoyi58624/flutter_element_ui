import 'package:flutter/material.dart';

import 'components/basic/typography.dart';
import 'components/others/brightness.dart';
import 'components/others/responsive.dart';
import 'styles/theme.dart';
import 'service.dart';

/// Element UI 全局主题数据
class ElAppData {
  /// 亮色主题
  late final ElThemeData theme;

  /// 暗色主题
  late final ElThemeData darkTheme;

  /// 组件配置
  late final ElConfigData config;

  /// 响应式断点配置
  final ElResponsiveData responsive;

  /// 文本排版配置
  late final ElTypographyData typography;

  ElAppData({
    ElThemeData? theme,
    ElThemeData? darkTheme,
    ElConfigData? config,
    this.responsive = const ElResponsiveData(),
    ElTypographyData? typography,
  }) {
    this.theme = theme ?? ElThemeData.lightTheme;
    this.darkTheme = darkTheme ?? ElThemeData.darkTheme;
    this.config = config ?? ElConfigData.data;
    this.typography = typography ?? ElTypographyData.data;
  }
}

class ElApp extends StatelessWidget {
  /// Element UI 顶级小部件，为了尽可能地减少上手成本，它只负责注入一些全局配置，
  /// 没有对 [WidgetsApp] 进行包装，所以你可以配合任意顶级 App 去构建应用：
  /// ```dart
  /// ElApp(
  ///   child: MaterialApp(
  ///     home: HomePage(),
  ///   ),
  /// ),
  /// ```
  ///
  /// 注意：使用 [MaterialApp] 你肯定会遇到字体下方有黄色的双下划线的错误，
  /// 这个错误实际上是官方希望你在 [Material] 组件中使用文本组件，解决方案：
  /// ```
  /// MaterialApp(
  ///   builder: (context, child) => Material(
  ///     child: child!,
  ///   ),
  /// ),
  /// ```
  const ElApp({
    super.key,
    required this.child,
    this.data,
    this.brightness,
  });

  final Widget child;

  /// 自定义全局主题数据
  final ElAppData? data;

  /// 设置平台明亮、暗色主题模式，如果为空则跟随系统
  final Brightness? brightness;

  /// 默认的主题数据
  static final ElAppData _defaultAppData = ElAppData();

  /// 通过上下文获取全局主题
  static ElAppData of(BuildContext context) =>
      _AppInheritedWidget.maybeOf(context) ?? _defaultAppData;

  @override
  Widget build(BuildContext context) {
    final $data = data ?? _defaultAppData;
    final $isDark = brightness == Brightness.dark;
    ElThemeData $theme = $isDark ? $data.darkTheme : $data.theme;
    TextStyle $style = $data.config.textStyle.copyWith(color: $theme.textColor);
    return ElGlobalCursor(
      child: ElResponsive(
        data: $data.responsive,
        child: ElBrightness(
          brightness: brightness,
          child: DefaultTextStyle(
            style: $style,
            child: ElTypographyInheritedWidget(
              data: ElTypographyData.data.merge($style),
              child: _AppInheritedWidget(
                data: $data,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 全局主题注入实例
class _AppInheritedWidget extends InheritedWidget {
  const _AppInheritedWidget({required super.child, required this.data});

  final ElAppData data;

  static ElAppData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_AppInheritedWidget>()?.data;

  @override
  bool updateShouldNotify(_AppInheritedWidget oldWidget) => true;
}
