import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'styles/theme.dart';

part 'app/extension.dart';

part 'app/service.dart';

part 'app/theme.dart';

part 'app/inherited_widget.dart';

class ElApp extends StatelessWidget {
  /// Element UI 顶级小部件，它只负责注入一些全局配置，和 [MaterialApp] 以及其他顶级 App 不同，
  /// 它没有基于 [WidgetsApp] 进行包装，所以，你必须使用其他顶级 App 去构建完整的应用：
  /// ```dart
  /// ElApp(
  ///   child: MaterialApp(
  ///     home: HomePage(),
  ///   ),
  /// ),
  /// ```
  ///
  /// 注意：使用 [MaterialApp] 你肯定会遇到字体下方有黄色的双下划线的错误，
  /// 这个错误实际上是官方 "鼓励" 你必须在 [Material] 组件中使用文本组件，解决方案：
  /// ```
  /// MaterialApp(
  ///   builder: (context, child) => Material(
  ///     child: child!,
  ///   ),
  /// ),
  /// ```
  ElApp({
    super.key,
    required this.child,
    this.data,
    this.brightness,
    this.navigatorKey,
  }) {
    _elRootNavigatorKey = navigatorKey;
  }

  final Widget child;

  /// 自定义全局主题数据
  final ElAppData? data;

  /// 设置平台明亮、暗色主题模式，如果为空则跟随系统，Element UI 提供了扩展函数，
  /// 你可以通过 [context.isDark] 判断当前是否处于暗色模式
  final Brightness? brightness;

  /// 根节点导航key，如果你用到一些依赖路由的Api，请设置它
  final GlobalKey<NavigatorState>? navigatorKey;

  /// 默认的主题数据
  static final ElAppData _defaultAppData = ElAppData();

  /// 通过上下文获取全局主题
  static ElAppData of(BuildContext context) =>
      _AppInheritedWidget.maybeOf(context)?.data ?? _defaultAppData;

  @override
  Widget build(BuildContext context) {
    final $data = data ?? _defaultAppData;
    final $isDark = brightness == Brightness.dark;
    ElThemeData $theme = $isDark ? $data.darkTheme : $data.theme;
    TextStyle $style = $data.config.textStyle.copyWith(color: $theme.textColor);
    return _ElGlobalCursor(
      child: _ElResponsive(
        data: $data.responsive,
        child: _ElBrightness(
          brightness: brightness,
          child: DefaultTextStyle(
            style: $style,
            child: _AppInheritedWidget(
              elTheme: this,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

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

/// 全局主题注入实例
class _AppInheritedWidget extends InheritedWidget {
  const _AppInheritedWidget({required super.child, required this.elTheme});

  final ElApp elTheme;

  static ElApp? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_AppInheritedWidget>()
      ?.elTheme;

  @override
  bool updateShouldNotify(_AppInheritedWidget oldWidget) => true;
}
