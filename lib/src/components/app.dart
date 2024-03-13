part of flutter_element_ui;

class ElAppData extends InheritedWidget {
  const ElAppData({
    super.key,
    required super.child,
    required this.theme,
    required this.themeColors,
  });

  final ElTheme theme;
  final Map<ElThemeType, Color> themeColors;

  @override
  bool updateShouldNotify(ElAppData oldWidget) {
    return false;
  }
}

enum ElThemeType {
  primary,
  success,
  info,
  warning,
  error,
}

class ElTheme {
  Color textWhite;
  Color textBlack;
  Color primary;
  Color success;
  Color info;
  Color warning;
  Color error;

  /// 默认的边框颜色
  Color defaultBorderColor;

  ElTheme({
    this.textWhite = const Color(0xffffffff),
    this.textBlack = const Color(0xff000000),
    this.primary = const Color(0xff409eff),
    this.success = const Color(0xff67c23a),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffe6a23c),
    this.error = const Color(0xfff56c6c),
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
      defaultBorderColor: theme.defaultBorderColor,
    );
  }
}

class ElApp extends StatelessWidget {
  const ElApp({
    super.key,
    required this.child,
    this.title = 'Flutter Element UI',
    this.theme,
  });

  final Widget child;
  final String title;
  final ElTheme? theme;

  static ElAppData of(BuildContext context) {
    final ElAppData? result = context.dependOnInheritedWidgetOfExactType<ElAppData>();
    assert(result != null, 'No ElAppData found in context');
    return result!;
  }

  @override
  Widget build(BuildContext context) {
    final $theme = ElTheme.copyWith(theme);
    return WidgetsApp(
      color: $theme.primary,
      title: title,
      builder: (BuildContext context, Widget? navigator) {
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
      },
    );
  }
}
