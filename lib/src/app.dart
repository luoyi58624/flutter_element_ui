part of flutter_element_ui;

class ElApp extends StatelessWidget {
  /// Element UI 顶级小部件，如果你不使用[ElApp]构建应用，使用[MaterialApp]或其他顶级App构建应用，那么你需要自己注入一些组件：
  /// * 同步暗黑模式，需要注入[BrightnessWidget]
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => BrightnessWidget(
  ///     brightness: Theme.of(context).brightness,
  ///     child: child!,
  ///   ),
  /// );
  /// ```
  /// * 设置自定义主题，需要注入[ElTheme]
  /// ```dart
  /// MaterialApp(
  ///   builder: (context, child) => ElTheme(
  ///     theme: ElThemeData(),
  ///     darkTheme: ElThemeData.dark(),
  ///     child: child!,
  ///   ),
  /// );
  /// ```
  const ElApp({
    super.key,
    required this.routerConfig,
    this.themeMode = ThemeMode.system,
    this.theme,
    this.darkTheme,
    this.config,
    this.builder,
  });

  /// Element UI 是面向桌面端的组件库，你应当使用声明式路由去构建应用程序，例如官方推出的[go_router]，
  /// 如果你非要使用命令式导航，请使用[MaterialApp]
  final RouterConfig<Object> routerConfig;

  /// 当前主题模式，默认跟随系统
  final ThemeMode themeMode;

  /// 亮色主题
  final ElThemeData? theme;

  /// 暗色主题
  final ElThemeData? darkTheme;

  /// 全局配置
  final ElConfigData? config;

  /// 在导航器上方插入自定义小部件
  final TransitionBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return ElTheme(
      theme: theme,
      darkTheme: darkTheme,
      config: config,
      child: BrightnessWidget(
        brightness: themeMode == ThemeMode.system
            ? null
            : themeMode == ThemeMode.light
                ? Brightness.light
                : Brightness.dark,
        child: WidgetsApp.router(
          color: Colors.transparent,
          routerConfig: routerConfig,
          builder: builder,
        ),
      ),
    );
  }
}
