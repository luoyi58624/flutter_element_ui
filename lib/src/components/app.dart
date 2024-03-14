part of flutter_element_ui;

/// Element UI全局配置信息
class ElApp extends StatelessWidget {
  const ElApp({
    super.key,
    required this.child,
    this.theme,
  });

  /// [ElApp]不是一个应用脚手架，你可以应用任意的App脚手架
  final Widget child;

  /// 自定义主题
  final ElTheme? theme;

  /// 通过[ElApp.of]获取全局配置信息
  static ElAppData of(BuildContext context) {
    final ElAppData? result = context.dependOnInheritedWidgetOfExactType<ElAppData>();
    assert(result != null, 'No ElAppData found in context');
    return result!;
  }

  @override
  Widget build(BuildContext context) {
    final $theme = ElTheme.copyWith(theme);
    return ElAppData(
      theme: $theme,
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

/// Element UI全局配置信息
class ElAppData extends InheritedWidget {
  const ElAppData({
    super.key,
    required super.child,
    required this.theme,
    required this.themeColors,
  });

  final ElTheme theme;

  /// 核心主题颜色Map集合，仅包含[ElThemeType]中定义的主题颜色
  final Map<ElThemeType, Color> themeColors;

  @override
  bool updateShouldNotify(ElAppData oldWidget) {
    /// 当主题发生改变时，通知所有的依赖子组件更新界面
    return theme != oldWidget.theme;
  }
}

/// Element UI组件主题类型
enum ElThemeType {
  primary,
  success,
  info,
  warning,
  error,
}

/// Element UI主题对象
class ElTheme {
  /// 主要颜色
  Color primary;

  /// 成功颜色
  Color success;

  /// 普通颜色
  Color info;

  /// 警告颜色
  Color warning;

  /// 错误颜色
  Color error;

  /// 基础白色
  Color white;

  /// 基础黑色
  Color black;

  /// 白色文字
  Color textWhite;

  /// 黑色文字
  Color textBlack;

  /// 默认的边框颜色
  Color defaultBorderColor;

  ElTheme({
    this.primary = const Color(0xff409eff),
    this.success = const Color(0xff67c23a),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffe6a23c),
    this.error = const Color(0xfff56c6c),
    this.white = const Color(0xffffffff),
    this.black = const Color(0xff000000),
    this.textWhite = const Color(0xfff6f6f6),
    this.textBlack = const Color(0xff1f1f1f),
    this.defaultBorderColor = const Color(0xffdcdfe6),
  });

  static ElTheme copyWith(ElTheme? theme) {
    if (theme == null) return ElTheme();
    return ElTheme(
      primary: theme.primary,
      success: theme.success,
      info: theme.info,
      warning: theme.warning,
      error: theme.error,
      white: theme.white,
      black: theme.black,
      textWhite: theme.textWhite,
      textBlack: theme.textBlack,
      defaultBorderColor: theme.defaultBorderColor,
    );
  }
}
