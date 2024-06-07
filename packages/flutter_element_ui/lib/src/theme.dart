import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

import 'builders/hover.dart';
import 'components/basic/brightness.dart';
import 'components/basic/scrollbar.dart';
import 'styles/theme.dart';

class ElTheme extends StatelessWidget {
  /// 注入 Element UI 主题系统
  ElTheme({
    super.key,
    required this.child,
    ElThemeData? theme,
    ElThemeData? darkTheme,
    ElConfigData? config,
    ElResponsiveData? responsive,
    this.brightness,
    this.textStyle,
  }) {
    _theme = theme ?? ElThemeData.theme;
    _darkTheme = darkTheme ?? ElThemeData.darkTheme;
    _config = config ?? ElConfigData.config;
    _responsive = responsive ?? ElResponsiveData.responsive;
  }

  final Widget child;
  late final ElThemeData _theme;
  late final ElThemeData _darkTheme;
  late final ElConfigData _config;
  late final ElResponsiveData _responsive;

  /// 指定 Element UI 小部件应用的主题模式，如果为空，则跟随平台系统
  final Brightness? brightness;

  /// 全局默认文字主题
  final TextStyle? textStyle;

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
    return ElDefaultScrollbar(
      child: ElGlobalHover(
        child: ElBrightness(
          brightness: brightness,
          child: Builder(builder: (context) {
            final color = context.isDark ? _darkTheme.textColor : _theme.textColor;
            TextStyle $textStyle = (textStyle ?? const TextStyle()).copyWith(color: color);
            return DefaultTextStyle(
              style: $textStyle,
              child: ElIconTheme(
                size: 18,
                color: color,
                child: _ElTheme(elTheme: this, child: child),
              ),
            );
          }),
        ),
      ),
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
