part of flutter_element_ui;

/// Element UI全局配置信息
class ElAppData extends InheritedWidget {
  const ElAppData({
    super.key,
    required super.child,
    required this.theme,
    required this.darkTheme,
    required this.themeColors,
  });

  final ElThemeData theme;
  final ElThemeData darkTheme;

  /// 核心主题颜色Map集合，仅包含[ElThemeType]中定义的主题颜色
  final Map<ElThemeType, Color> themeColors;

  @override
  bool updateShouldNotify(ElAppData oldWidget) {
    /// 当主题发生改变时，通知所有的依赖子组件更新界面
    return theme != oldWidget.theme || darkTheme != oldWidget.darkTheme;
  }
}

/// Element UI全局配置信息
class ElApp extends StatelessWidget {
  const ElApp({
    super.key,
    required this.child,
    this.theme,
    this.darkTheme,
  });

  /// [ElApp]只是提供全局组件配置信息，它不是一个应用脚手架，你应当搭配其他App脚手架，例如官方的[MaterialApp]
  final Widget child;

  /// 自定义主题
  final ElThemeData? theme;

  /// 自定义暗色主题
  final ElThemeData? darkTheme;

  /// 通过[ElApp.of]获取全局配置信息
  static ElAppData of(BuildContext context) {
    final ElAppData? result = context.dependOnInheritedWidgetOfExactType<ElAppData>();
    assert(result != null, 'No ElAppData found in context');
    return result!;
  }

  @override
  Widget build(BuildContext context) {
    final $theme = ElThemeData()..copyWith(theme);
    final $darkTheme = ElThemeData.dark()..copyWith(darkTheme);
    return ElAppData(
      theme: $theme,
      darkTheme: $darkTheme,
      themeColors: {
        ElThemeType.primary: $theme.primary,
        ElThemeType.success: $theme.success,
        ElThemeType.info: $theme.info,
        ElThemeType.warning: $theme.warning,
        ElThemeType.error: $theme.error,
      },
      child: child,
    );
  }
}
