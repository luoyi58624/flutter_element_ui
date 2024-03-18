part of flutter_element_ui;

/// Element UI 全局配置注入，注意：它就是 Element UI 的顶级入口
class ElConfigProvider extends StatelessWidget {
  /// [ElConfigProvider]仅提供全局主题注入，你需要使用 MaterialApp、CupertinoApp、FluentApp、MacosApp 等顶级入口组件创建应用。
  ///
  /// 示例:
  /// ``` dart
  /// MaterialApp.router(
  ///   routerConfig: router,
  ///   builder: (context, child) => ElConfigProvider(
  ///     child: child!,
  ///   ),
  /// );
  /// ```
  ///
  /// 当然，以上App全部都是基于 WidgetsApp 构建，如果你想要构建更纯粹的桌面端应用程序，只想使用 Element UI 提供的组件，
  /// 那么你可以直接使用 WidgetsApp 创建应用。
  ///
  /// 示例：
  /// ``` dart
  /// WidgetsApp.router(
  ///   color: const Color(0xffffffff),
  ///   routerConfig: router,
  ///   builder: (context, child) => ElConfigProvider(
  ///     child: child!,
  ///   ),
  /// );
  /// ```
  const ElConfigProvider({
    super.key,
    required this.child,
    this.theme,
    this.darkTheme,
    this.useDark,
    this.config,
  });

  final Widget child;

  /// 自定义亮色主题，默认：[ElThemeData]
  final ElThemeData? theme;

  /// 自定义暗色主题，默认：[ElThemeData.dark]
  final ElThemeData? darkTheme;

  /// 强制应用进入黑暗模式或亮色模式，如果为null，则默认跟随系统
  final bool? useDark;

  /// 自定义组件全局配置
  final ElConfigData? config;

  @override
  Widget build(BuildContext context) {
    final $theme = theme ?? ElThemeData();
    final $darkTheme = darkTheme ?? ElThemeData.dark();
    final $currentTheme = useDark == null
        ? (MediaQuery.of(context).platformBrightness == Brightness.light ? $theme : $darkTheme)
        : useDark!
            ? $darkTheme
            : $theme;
    final $config = config ?? ElConfigData();
    return ElAppData(
      theme: $theme,
      darkTheme: $darkTheme,
      currentTheme: $currentTheme,
      config: $config,
      themeColors: {
        ElThemeType.primary: $currentTheme.primary,
        ElThemeType.success: $currentTheme.success,
        ElThemeType.info: $currentTheme.info,
        ElThemeType.warning: $currentTheme.warning,
        ElThemeType.error: $currentTheme.error,
      },
      child: DefaultTextStyle(
        style: TextStyle(color: $currentTheme.textColor),
        child: ElDefaultIconStyle(
          color: $currentTheme.textColor,
          child: child,
        ),
      ),
    );
  }
}

/// Element UI全局配置信息
class ElAppData extends InheritedWidget {
  const ElAppData({
    super.key,
    required super.child,
    required this.theme,
    required this.darkTheme,
    required this.currentTheme,
    required this.config,
    required this.themeColors,
  });

  /// 保存当前亮色主题配置
  final ElThemeData theme;

  /// 保存当前暗色主题配置
  final ElThemeData darkTheme;

  /// Element UI 当前应用的主题
  final ElThemeData currentTheme;

  /// 自定义组件全局配置
  final ElConfigData config;

  /// 核心主题颜色Map集合，仅包含[ElThemeType]中定义的主题颜色
  final Map<ElThemeType, Color> themeColors;

  /// 通过[ElApp.of]获取全局配置信息
  static ElAppData of(BuildContext context) {
    final ElAppData? result = context.dependOnInheritedWidgetOfExactType<ElAppData>();
    assert(result != null, 'No ElAppData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElAppData oldWidget) {
    return currentTheme != oldWidget.currentTheme || config != oldWidget.config;
  }
}
