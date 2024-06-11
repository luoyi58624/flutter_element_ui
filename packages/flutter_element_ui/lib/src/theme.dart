import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extension.dart';

import 'builders/hover.dart';
import 'components/basic/brightness.dart';
import 'components/basic/icon.dart';
import 'components/basic/scrollbar.dart';
import 'styles/theme.dart';

/// Element UI 颜色主题类型集合
const List<String> elThemeTypes = ['primary', 'success', 'info', 'warning', 'error'];

/// Element UI 全局主题
class ElThemeData {
  ElColorThemeData? theme;
  ElColorThemeData? darkTheme;
  ElConfigData? config;
  ElResponsiveData? responsive;

  ElThemeData({
    this.theme,
    this.darkTheme,
    this.config,
    this.responsive,
  });
}

class ElTheme extends StatelessWidget {
  /// Element UI 全局主题小部件，这是可选的，但如果你要用到
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(
  ///     child: child!,
  ///   ),
  /// );
  /// ```
  const ElTheme({
    super.key,
    required this.child,
    this.data,
    this.textStyle,
    this.brightness,
  });

  final Widget child;

  /// 主题数据，默认[defaultThemeData]
  final ElThemeData? data;

  /// 全局文字默认样式，Element UI 只处理文字颜色
  final TextStyle? textStyle;

  /// 定义平台应用的主题模式，如果为空则跟随系统，建议将该值和你的顶级 App 组件绑定，示例：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(
  ///      brightness: Theme.of(context).brightness,
  ///      child: child!,
  ///   ),
  /// );
  /// ```
  final Brightness? brightness;

  static ElThemeData defaultThemeData = ElThemeData(
    theme: ElColorThemeData.theme,
    darkTheme: ElColorThemeData.darkTheme,
    config: ElConfigData.config,
    responsive: ElResponsiveData.responsive,
  );

  /// 通过上下文获取全局主题
  static ElThemeData of(BuildContext context) => _ElTheme.maybeOf(context)?.data ?? defaultThemeData;

  // /// 亮色主题
  // static ElColorThemeData theme(BuildContext context) => _ElTheme.maybeOf(context)?._theme ?? ElColorThemeData.theme;
  //
  // /// 暗色主题
  // static ElColorThemeData darkTheme(BuildContext context) => _ElTheme.maybeOf(context)?._darkTheme ?? ElColorThemeData.darkTheme;
  //
  // /// 全局配置
  // static ElConfigData config(BuildContext context) => _ElTheme.maybeOf(context)?._config ?? ElConfigData.config;
  //
  // /// 响应式配置
  // static ElResponsiveData responsive(BuildContext context) =>
  //     _ElTheme.maybeOf(context)?._responsive ?? ElResponsiveData.responsive;

  @override
  Widget build(BuildContext context) {
    final $data = data ?? defaultThemeData;
    return ElBrightness(
      brightness: brightness,
      child: Builder(builder: (context) {
        final color = context.isDark ? $data.darkTheme.textColor : $data.theme.textColor;
        TextStyle $style = (textStyle ?? const TextStyle()).copyWith(color: color);
        return DefaultTextStyle(
          style: $style,
          child: ElIconTheme(
            size: 18,
            color: color,
            child: _ElTheme(
              elTheme: this,
              child: ScrollConfiguration(
                behavior: const ElScrollBehavior(),
                child: ElGlobalHover(
                  child: child,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// 全局主题注入实例
class _ElTheme extends InheritedWidget {
  const _ElTheme({required super.child, required this.elTheme});

  final ElTheme elTheme;

  static ElTheme? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_ElTheme>()?.elTheme;

  @override
  bool updateShouldNotify(_ElTheme oldWidget) => true;
}
