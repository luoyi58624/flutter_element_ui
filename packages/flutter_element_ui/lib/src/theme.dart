import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'builders/hover.dart';
import 'components/basic/brightness.dart';
import 'components/basic/icon.dart';
import 'components/basic/scrollbar.dart';
import 'styles/theme.dart';

/// Element UI 颜色主题类型集合
const List<String> elThemeTypes = [
  'primary',
  'success',
  'info',
  'warning',
  'error'
];

/// Element UI 全局主题
class ElThemeData {
  late final ElColorThemeData theme;
  late final ElColorThemeData darkTheme;
  late final ElConfigData config;
  late final ElResponsiveData responsive;

  ElThemeData({
    ElColorThemeData? theme,
    ElColorThemeData? darkTheme,
    ElConfigData? config,
    ElResponsiveData? responsive,
  }) {
    this.theme = theme ?? ElColorThemeData.theme;
    this.darkTheme = darkTheme ?? ElColorThemeData.darkTheme;
    this.config = config ?? ElConfigData.config;
    this.responsive = responsive ?? ElResponsiveData.responsive;
  }
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
    this.behavior,
  });

  final Widget child;

  /// 主题数据，默认[defaultThemeData]
  final ElThemeData? data;

  /// 全局文字默认样式，Element UI只应用文字颜色
  ///
  /// 注意：Flutter Material组件会基于 ThemeData 的 textTheme 再创建一层 DefaultTextStyle，
  /// 如果你的应用程序以 Material 为主，设置全局默认文本主题时最好应用 Material 的文本主题，
  /// 包括下方的 brightness 属性，最好一律从 Theme.of 继承
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

  /// 自定义全局滚动行为
  final ScrollBehavior? behavior;

  static ElThemeData defaultThemeData = ElThemeData(
    theme: ElColorThemeData.theme,
    darkTheme: ElColorThemeData.darkTheme,
    config: ElConfigData.config,
    responsive: ElResponsiveData.responsive,
  );

  /// 通过上下文获取全局主题
  static ElThemeData of(BuildContext context) =>
      _ElTheme.maybeOf(context)?.data ?? defaultThemeData;

  @override
  Widget build(BuildContext context) {
    final $data = data ?? defaultThemeData;
    return ElBrightness(
      brightness: brightness,
      child: Builder(builder: (context) {
        final color =
            context.isDark ? $data.darkTheme.textColor : $data.theme.textColor;
        TextStyle $style =
            (textStyle ?? const TextStyle()).copyWith(color: color);
        return DefaultTextStyle(
          style: $style,
          child: ElIconTheme(
            size: 18,
            color: color,
            child: _ElTheme(
              elTheme: this,
              child: ScrollConfiguration(
                behavior: behavior ?? const ElScrollBehavior(),
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

  static ElTheme? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_ElTheme>()?.elTheme;

  @override
  bool updateShouldNotify(_ElTheme oldWidget) => true;
}
