part of flutter_element_ui;

class ElApp extends StatelessWidget {
  /// Element UI 顶级小部件，此小部件并不强制你必须使用，你完全可以使用其他 App 构建应用，在这种情况下，所有小部件将应用默认的主题系统，
  /// 如果你需要自定义全局主题，只需在任意 App 下插入[ElTheme]小部件即可：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(child: child!),
  /// );
  /// ```
  const ElApp({
    super.key,
    this.home,
    this.title,
    this.theme,
    this.darkTheme,
    this.config,
    this.brightness,
    this.textStyle,
    this.builder,
  }) : routerConfig = null;

  /// 以声明式路由构建App
  const ElApp.router({
    super.key,
    required this.routerConfig,
    this.title,
    this.theme,
    this.darkTheme,
    this.config,
    this.brightness,
    this.textStyle,
    this.builder,
  }) : home = null;

  final Widget? home;

  /// Element UI 是面向桌面端的组件库，你应当使用声明式路由去构建应用程序，例如官方推出的[go_router]，
  /// 如果你非要使用命令式导航，请使用[MaterialApp]
  final RouterConfig<Object>? routerConfig;

  final String? title;

  /// 亮色主题
  final ElThemeData? theme;

  /// 暗色主题
  final ElThemeData? darkTheme;

  /// 全局配置
  final ElConfigData? config;

  /// 指定 Element UI 小部件应用的主题模式，如果为空，则跟随平台系统
  final Brightness? brightness;

  /// 全局[TextStyle]
  final TextStyle? textStyle;

  /// 在导航器上方插入自定义小部件
  final TransitionBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return ElTheme(
      theme: theme,
      darkTheme: darkTheme,
      config: config ?? ElConfigData(),
      brightness: brightness,
      textStyle: textStyle,
      child: WidgetsApp.router(
        color: Colors.transparent,
        routerConfig: routerConfig,
        builder: DragScrollbarDisabledHover.builder(builder),
      ),
    );
  }
}
