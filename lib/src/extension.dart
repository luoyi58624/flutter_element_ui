part of flutter_element_ui;

extension ElContextExtension on BuildContext {
  /// Element UI 全局配置数据
  ElConfigData get elConfig => ElTheme.of(this).config;

  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? darkTheme : theme;
}

/// 字体排版扩展
extension ElTypographyContextExtension on BuildContext {
  /// 标题1 - 28px
  TextStyle get h1 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: 28,
        color: elTheme.titleColor,
      );

  /// 标题2 - 24px
  TextStyle get h2 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: 24,
        color: elTheme.titleColor,
      );

  /// 标题3 - 20px
  TextStyle get h3 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: 20,
        color: elTheme.titleColor,
      );

  /// 标题4 - 18px
  TextStyle get h4 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: 18,
        color: elTheme.titleColor,
      );

  /// 标题5 - 16px
  TextStyle get h5 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: 16,
        color: elTheme.titleColor,
      );

  /// 标题6 - 14px
  TextStyle get h6 => TextStyle(
        fontWeight: FontUtil.bold,
        fontSize: 14,
        color: elTheme.titleColor,
      );

  /// 普通段落文本 - 15px
  TextStyle get p => TextStyle(
        fontWeight: FontUtil.normal,
        fontSize: 15,
        color: elTheme.textColor,
      );
}

extension _ElContextExtension on BuildContext {
  ElThemeData get theme => ElTheme.of(this).theme;

  ElThemeData get darkTheme => ElTheme.of(this).darkTheme;

  Map<ElThemeType, Color> get themeTypeColors => {
        ElThemeType.primary: elTheme.primary,
        ElThemeType.success: elTheme.success,
        ElThemeType.info: elTheme.info,
        ElThemeType.warning: elTheme.warning,
        ElThemeType.error: elTheme.error,
      };
}

/// 模拟 Element UI 九种渐变明亮度颜色，如果是亮色模式，则颜色将逐渐变亮，如果是暗色模式，则颜色将逐渐变暗
extension _ElColorExtension on Color {
  /// Element UI 一级渐变颜色
  Color elLight1(BuildContext context) => context.isDark ? darken(8) : brighten(10);

  /// Element UI 二级渐变颜色
  Color elLight2(BuildContext context) => context.isDark ? darken(16) : brighten(20);

  /// Element UI 三级渐变颜色
  Color elLight3(BuildContext context) => context.isDark ? darken(24) : brighten(30);

  /// Element UI 四级渐变颜色
  Color elLight4(BuildContext context) => context.isDark ? darken(32) : brighten(40);

  /// Element UI 五级渐变颜色
  Color elLight5(BuildContext context) => context.isDark ? darken(40) : brighten(50);

  /// Element UI 六级渐变颜色
  Color elLight6(BuildContext context) => context.isDark ? darken(48) : brighten(60);

  /// Element UI 七级渐变颜色
  Color elLight7(BuildContext context) => context.isDark ? darken(56) : brighten(70);

  /// Element UI 八级渐变颜色
  Color elLight8(BuildContext context) => context.isDark ? darken(80) : brighten(80);

  /// Element UI 九级渐变颜色
  Color elLight9(BuildContext context) => context.isDark ? darken(90) : brighten(90);

  /// hover 悬停颜色
  Color elHover(BuildContext context) => elLight2(context);

  /// tap 按下颜色
  Color elTap(BuildContext context) => context.isDark ? brighten(20) : darken(20);

  /// 应用主题透明背景颜色
  Color elThemeLightBg(BuildContext context) => elLight9(context);

  /// 应用主题透明边框颜色
  Color elThemeLightBorder(BuildContext context) => elLight6(context);
}
