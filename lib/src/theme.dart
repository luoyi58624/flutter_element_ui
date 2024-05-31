part of flutter_element_ui;

class ElTheme extends StatelessWidget {
  /// 注入 Element UI 主题系统
  const ElTheme({
    super.key,
    required this.child,
    required this.config,
    required this.theme,
    required this.darkTheme,
    this.brightness,
    this.textStyle,
  });

  final Widget child;

  /// 全局配置
  final ElConfigData config;

  /// 亮色主题
  final ElThemeData theme;

  /// 暗色主题
  final ElThemeData darkTheme;

  /// 指定暗色、亮色主题模式，如果为空，则跟随平台系统
  final Brightness? brightness;

  /// 全局[TextStyle]
  final TextStyle? textStyle;

  /// 通过上下文获取主题对象
  static ElTheme of(BuildContext context) => _ElTheme.of(context);

  @override
  Widget build(BuildContext context) {
    return NoDefaultScrollbarWidget(
      child: BrightnessWidget(
        brightness: brightness,
        child: Builder(builder: (context) {
          TextStyle style = textStyle ?? const TextStyle();
          return DefaultTextStyle(
            style: style.copyWith(
              color: context.isDark ? darkTheme.textColor : theme.textColor,
            ),
            child: _ElTheme(elTheme: this, child: child),
          );
        }),
      ),
    );
  }
}

class _ElTheme extends InheritedWidget {
  const _ElTheme({required super.child, required this.elTheme});

  final ElTheme elTheme;

  static ElTheme of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<_ElTheme>();
    assert(result != null, 'No _ElTheme found in context');
    return result!.elTheme;
  }

  @override
  bool updateShouldNotify(_ElTheme oldWidget) => true;
}
