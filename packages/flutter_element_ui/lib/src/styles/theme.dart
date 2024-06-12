import 'dart:ui';

import 'package:flutter_element_annotation/flutter_element_annotation.dart';

import 'basic/button.dart';

part '../generates/styles/theme.g.dart';

/// Element UI 主题对象
@ElModel(copyWith: true)
class ElColorThemeData {
  static ElColorThemeData theme = ElColorThemeData();
  static ElColorThemeData darkTheme = ElColorThemeData.dark();

  /// 描述当前主题系统是否是亮色、暗色
  @ElModelField(ignore: ElModel.all())
  final Brightness brightness;

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

  /// 全局背景色
  Color bgColor;

  /// 头部背景颜色，亮色模式下默认使用[primary]
  late Color headerColor;

  /// 卡片背景色，默认使用[bgColor]更深的颜色
  late Color cardColor;

  /// 模态弹窗背景色，亮色模式下默认使用[bgColor]
  late Color modalColor;

  /// 标题颜色
  Color titleColor;

  /// 文字颜色
  Color textColor;

  /// icon颜色
  Color iconColor;

  /// 边框颜色
  Color borderColor;

  /// 菜单栏背景色
  Color menuBackground;

  /// 菜单栏激活文字颜色
  Color menuActiveColor;

  /// 卡片海拔高度，设置较低的海拔能让应用更加扁平化，设置较高的海拔则让应用更具层级感
  double cardElevation;

  /// 模态弹窗海拔高度
  double modalElevation;

  /// 根据图标颜色自动创建一组次级颜色: 0 - 5
  @ElModelField(ignore: ElModel.all())
  late final List<Color> iconColors;

  /// 默认的亮色主题构造函数
  ElColorThemeData({
    this.brightness = Brightness.light,
    this.primary = const Color(0xff409eff),
    this.success = const Color(0xff67c23a),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffe6a23c),
    this.error = const Color(0xfff56c6c),
    this.bgColor = const Color(0xfffafafa),
    Color? headerColor,
    this.cardColor = const Color(0xffffffff),
    Color? modalColor,
    this.titleColor = const Color(0xff262626),
    this.textColor = const Color(0xff525252),
    this.iconColor = const Color(0xff1b1e23),
    this.borderColor = const Color(0xffdcdfe6),
    this.menuBackground = const Color(0xff565c64),
    this.menuActiveColor = const Color(0xffffd04b),
    this.cardElevation = 0,
    this.modalElevation = 2,
  }) {
    this.headerColor = headerColor ?? primary;
    this.modalColor = modalColor ?? bgColor;
  }

  /// 默认的暗色主题构造函数
  ElColorThemeData.dark({
    this.brightness = Brightness.dark,
    this.primary = const Color(0xff0ea5e9),
    this.success = const Color(0xff14b8a6),
    this.info = const Color(0xff64748B),
    this.warning = const Color(0xfffbbf24),
    this.error = const Color(0xfffb7185),
    this.bgColor = const Color(0xff2b2b2b),
    Color? headerColor = const Color(0xff404040),
    this.cardColor = const Color(0xffffffff),
    Color? modalColor = const Color(0xff3c3f41),
    this.titleColor = const Color(0xfffafafa),
    this.textColor = const Color(0xfff5f5f5),
    this.iconColor = const Color(0xfff6f6f6),
    this.borderColor = const Color(0xffa3a3a3),
    this.menuBackground = const Color(0xff374151),
    this.menuActiveColor = const Color(0xff6ee7b7),
    this.cardElevation = 2,
    this.modalElevation = 4,
  }) {
    this.headerColor = headerColor ?? primary;
    this.modalColor = modalColor ?? bgColor;
  }
}

/// Element UI 全局配置，定义了所有组件的默认配置信息
@ElModel(copyWith: true)
class ElConfigData {
  static ElConfigData config = ElConfigData();

  /// 默认的icon大小
  double iconSize;

  /// 按钮全局样式
  ElButtonStyle buttonStyle;

  /// 输入框全局圆角值
  double inputRadius;

  /// 卡片全局圆角值
  double cardRadius;

  ElConfigData({
    this.iconSize = 20,
    this.buttonStyle = const ElButtonStyle(),
    this.cardRadius = 6,
    this.inputRadius = 6,
  });
}

@ElModel(copyWith: true)
class ElResponsiveData {
  /// 默认的响应式配置
  static ElResponsiveData responsive = ElResponsiveData();

  /// 手机最大尺寸
  final double sm;

  /// 平板最大尺寸
  final double md;

  /// 桌面最大尺寸
  final double lg;

  /// 大屏桌面最大尺寸
  final double xl;

  ElResponsiveData({
    this.sm = 640,
    this.md = 1024,
    this.lg = 1920,
    this.xl = 2560,
  });
}
