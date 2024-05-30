part of flutter_element_ui;

class ElApp extends StatelessWidget {
  /// Element UI 顶级小部件，你也可以使用其他 App 构建应用，只需要插入[ElTheme]小部件即可：
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(child: child!),
  /// );
  /// ```
  const ElApp({
    super.key,
    required this.routerConfig,
    this.theme,
    this.darkTheme,
    this.config,
    this.brightness,
    this.textStyle,
    this.builder,
  });

  /// Element UI 是面向桌面端的组件库，你应当使用声明式路由去构建应用程序，例如官方推出的[go_router]，
  /// 如果你非要使用命令式导航，请使用[MaterialApp]
  final RouterConfig<Object> routerConfig;

  /// 亮色主题
  final ElThemeData? theme;

  /// 暗色主题
  final ElThemeData? darkTheme;

  /// 全局配置
  final ElConfigData? config;

  /// 指定暗色、亮色主题模式，如果为空，则跟随平台系统
  final Brightness? brightness;

  /// 全局[TextStyle]
  final TextStyle? textStyle;

  /// 在导航器上方插入自定义小部件
  final TransitionBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return ElTheme(
      theme: theme ?? ElThemeData(),
      darkTheme: darkTheme ?? ElThemeData.dark(),
      config: config ?? ElConfigData(),
      brightness: brightness,
      textStyle: textStyle,
      child: WidgetsApp.router(
        color: Colors.transparent,
        routerConfig: routerConfig,
        builder: builder,
      ),
    );
  }
}
