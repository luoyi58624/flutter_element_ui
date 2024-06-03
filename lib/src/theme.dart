part of flutter_element_ui;

class ElTheme extends StatelessWidget {
  /// 注入 Element UI 主题系统
  ElTheme({
    super.key,
    required this.child,
    ElConfigData? config,
    ElThemeData? theme,
    ElThemeData? darkTheme,
    this.brightness,
    this.textStyle,
  }) {
    _config = config ?? ElConfigData.config;
    _theme = theme ?? ElThemeData.theme;
    _darkTheme = darkTheme ?? ElThemeData.darkTheme;
  }

  final Widget child;
  late final ElConfigData _config;
  late final ElThemeData _theme;
  late final ElThemeData _darkTheme;

  /// 指定 Element UI 小部件应用的主题模式，如果为空，则跟随平台系统
  final Brightness? brightness;

  /// 全局[TextStyle]
  final TextStyle? textStyle;

  /// 全局配置
  static ElConfigData config(BuildContext context) => _ElTheme.maybeOf(context)?._config ?? ElConfigData.config;

  /// 亮色主题
  static ElThemeData theme(BuildContext context) => _ElTheme.maybeOf(context)?._theme ?? ElThemeData.theme;

  /// 暗色主题
  static ElThemeData darkTheme(BuildContext context) => _ElTheme.maybeOf(context)?._darkTheme ?? ElThemeData.darkTheme;

  @override
  Widget build(BuildContext context) {
    // 移除 Flutter 对桌面平台默认绘制的滚动条，此行为非常有必要，否则当你使用其他自定义滚动条时会发生重叠
    return NoDefaultScrollbarWidget(
      // 平台亮度小部件，通过 context.isDark 判断当前是否是暗黑模式，
      // 该小部件抹平了 MaterialApp、CupertinoApp 等各种顶级 App 主题系统的暗黑模式判断，
      // 如果你不需要此扩展函数，请在导入 element_ui 时隐藏 BrightnessContextExtension
      child: BrightnessWidget(
        brightness: brightness,
        child: Builder(builder: (context) {
          TextStyle style = textStyle ?? const TextStyle();
          return DefaultTextStyle(
            style: style.copyWith(
              color: context.isDark ? _darkTheme.textColor : _theme.textColor,
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

  static ElTheme? maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<_ElTheme>()?.elTheme;

  @override
  bool updateShouldNotify(_ElTheme oldWidget) => true;
}
