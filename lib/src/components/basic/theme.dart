part of flutter_element_ui;

class ElTheme extends InheritedWidget {
  ElTheme({
    super.key,
    required super.child,
    ElThemeData? theme,
    ElThemeData? darkTheme,
    ElConfigData? config,
  }) {
    _theme = theme ?? ElThemeData.theme;
    _darkTheme = darkTheme ?? ElThemeData.darkTheme;
    _config = config ?? ElConfigData.defaultConfig;
  }

  late final ElThemeData _theme;
  late final ElThemeData _darkTheme;
  late final ElConfigData _config;

  static ElTheme? _maybeOf(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ElTheme>();

  /// 通过上下文获取亮色主题
  static ElThemeData theme(BuildContext context) => _maybeOf(context)?._theme ?? ElThemeData.theme;

  /// 通过上下文获取暗色主题
  static ElThemeData darkTheme(BuildContext context) => _maybeOf(context)?._darkTheme ?? ElThemeData.darkTheme;

  /// 通过上下文获取全局配置
  static ElConfigData config(BuildContext context) => _maybeOf(context)?._config ?? ElConfigData.defaultConfig;

  @override
  bool updateShouldNotify(ElTheme oldWidget) => true;
}
