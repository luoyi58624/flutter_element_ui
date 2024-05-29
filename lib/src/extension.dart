part of flutter_element_ui;

extension ElContextExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : theme;

  /// Element UI 全局配置数据
  ElConfigData get elConfig => ElTheme.config(this);
}

extension _ElContextExtension on BuildContext {
  ElThemeData get theme => ElTheme.theme(this);

  ElThemeData get darkTheme => ElTheme.darkTheme(this);

  Map<ElThemeType, Color> get themeColors => {
        ElThemeType.primary: elTheme.primary,
        ElThemeType.success: elTheme.success,
        ElThemeType.info: elTheme.info,
        ElThemeType.warning: elTheme.warning,
        ElThemeType.error: elTheme.error,
      };
}
