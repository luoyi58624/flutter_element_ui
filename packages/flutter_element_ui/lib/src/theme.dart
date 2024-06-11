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

class ElTheme extends StatelessWidget {
  /// Element UI 全局主题小部件，这是可选的，但如果你要用到
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(
  ///     child: child!,
  ///   ),
  /// );
  /// ```
  ElTheme({
    super.key,
    required this.child,
    this.textStyle,
    this.brightness,
    ElThemeData? theme,
    ElThemeData? darkTheme,
    ElConfigData? config,
    ElResponsiveData? responsive,
  }) {
    _theme = theme ?? ElThemeData.theme;
    _darkTheme = darkTheme ?? ElThemeData.darkTheme;
    _config = config ?? ElConfigData.config;
    _responsive = responsive ?? ElResponsiveData.responsive;
  }

  final Widget child;

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
  late final ElThemeData _theme;
  late final ElThemeData _darkTheme;
  late final ElConfigData _config;
  late final ElResponsiveData _responsive;

  /// 亮色主题
  static ElThemeData theme(BuildContext context) => _ElTheme.maybeOf(context)?._theme ?? ElThemeData.theme;

  /// 暗色主题
  static ElThemeData darkTheme(BuildContext context) => _ElTheme.maybeOf(context)?._darkTheme ?? ElThemeData.darkTheme;

  /// 全局配置
  static ElConfigData config(BuildContext context) => _ElTheme.maybeOf(context)?._config ?? ElConfigData.config;

  /// 响应式配置
  static ElResponsiveData responsive(BuildContext context) =>
      _ElTheme.maybeOf(context)?._responsive ?? ElResponsiveData.responsive;

  @override
  Widget build(BuildContext context) {
    return ElBrightness(
      brightness: brightness,
      child: Builder(builder: (context) {
        final color = context.isDark ? _darkTheme.textColor : _theme.textColor;
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
