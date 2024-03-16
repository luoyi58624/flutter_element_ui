part of flutter_element_ui;

/// Element UI 所有组件主题类型
enum ElThemeType {
  primary,
  success,
  info,
  warning,
  error,
}

/// Element UI 主题对象
class ElThemeData {
  static const Color white = Color(0xffffffff);
  static const Color black = Color(0xff000000);

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

  /// 全局背景白色
  Color bgColor;

  /// 全局文字颜色
  Color textColor;

  /// 默认的icon亮色颜色
  Color iconColor;

  /// 默认的icon大小
  double iconSize;

  /// 组件全局圆角值
  double radius;

  /// 默认的边框颜色
  Color defaultBorderColor;

  /// 菜单栏背景色
  Color menuBackground;

  /// 菜单栏激活文字颜色
  Color menuActiveColor;

  /// 默认的亮色主题构造函数
  ElThemeData({
    this.primary = const Color(0xff409eff),
    this.success = const Color(0xff67c23a),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffe6a23c),
    this.error = const Color(0xfff56c6c),
    this.bgColor = const Color(0xffffffff),
    this.textColor = const Color(0xff1f1f1f),
    this.iconColor = const Color(0xff1f1f1f),
    this.iconSize = 18,
    this.radius = 4,
    this.defaultBorderColor = const Color(0xffdcdfe6),
    this.menuBackground = const Color(0xff565c64),
    this.menuActiveColor = const Color(0xffffd04b),
  });

  /// 默认的暗色主题构造函数
  ElThemeData.dark({
    this.primary = const Color(0xff409eff),
    this.success = const Color(0xff67c23a),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffe6a23c),
    this.error = const Color(0xfff56c6c),
    this.bgColor = const Color(0xff000000),
    this.textColor = const Color(0xfff6f6f6),
    this.iconColor = const Color(0xfff6f6f6),
    this.iconSize = 18,
    this.radius = 4,
    this.defaultBorderColor = const Color(0xffdcdfe6),
    this.menuBackground = const Color(0xff565c64),
    this.menuActiveColor = const Color(0xffffd04b),
  });

  /// 合并主题颜色，并返回新的主题对象
  ElThemeData copyWith(ElThemeData? theme) {
    primary = theme?.primary ?? primary;
    success = theme?.success ?? success;
    info = theme?.info ?? info;
    warning = theme?.warning ?? warning;
    error = theme?.error ?? error;
    bgColor = theme?.bgColor ?? bgColor;
    textColor = theme?.textColor ?? textColor;
    iconColor = theme?.iconColor ?? iconColor;
    iconSize = theme?.iconSize ?? iconSize;
    radius = theme?.radius ?? radius;
    defaultBorderColor = theme?.defaultBorderColor ?? defaultBorderColor;
    menuBackground = theme?.menuBackground ?? menuBackground;
    menuActiveColor = theme?.menuActiveColor ?? menuActiveColor;
    return this;
  }
}
