import 'dart:ui';

import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import 'basic/button.dart';
import 'basic/text.dart';

part '../generates/styles/theme.g.dart';

/// Element UI 主题类型
enum ElThemeType {
  primary,
  success,
  info,
  warning,
  error,
}

/// Element UI 主题对象
@ElModel(copyWith: true)
class ElThemeData {
  static ElThemeData theme = ElThemeData();
  static ElThemeData darkTheme = ElThemeData.dark();

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
  ElThemeData({
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
    iconColors = List.generate(6, (index) => iconColor.brighten(8 * (index + 1)));
  }

  /// 默认的暗色主题构造函数
  ElThemeData.dark({
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
    iconColors = List.generate(6, (index) => iconColor.darken(4 * (index + 1)));
  }

  ElThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    Color? bgColor,
    Color? headerColor,
    Color? cardColor,
    Color? modalColor,
    Color? titleColor,
    Color? textColor,
    Color? iconColor,
    Color? borderColor,
    Color? menuBackground,
    Color? menuActiveColor,
    double? cardElevation,
    double? modalElevation,
  }) {
    return ElThemeData(
      primary: primary ?? this.primary,
      success: success ?? this.success,
      info: info ?? this.info,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      bgColor: bgColor ?? this.bgColor,
      headerColor: headerColor ?? this.headerColor,
      cardColor: cardColor ?? this.cardColor,
      modalColor: modalColor ?? this.modalColor,
      titleColor: titleColor ?? this.titleColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      borderColor: borderColor ?? this.borderColor,
      menuBackground: menuBackground ?? this.menuBackground,
      menuActiveColor: menuActiveColor ?? this.menuActiveColor,
      cardElevation: cardElevation ?? this.cardElevation,
      modalElevation: modalElevation ?? this.modalElevation,
    );
  }
}

/// Element UI 全局配置，定义了所有组件的默认配置信息，每个组件的主题样式提取都遵循以下规则：
/// 全局预设主题 -> 局部默认主题 -> 组件自身主题
///
/// 每一层主题都是基于上一级的默认配置进行合并，通过以上规则，你可以非常轻松地自定义所有组件样式风格
@ElModel(copyWith: true)
class ElConfigData {
  static ElConfigData config = ElConfigData();

  /// 默认的icon大小
  double iconSize;

  /// 文本全局样式
  late ElTextStyle textStyle;

  /// 按钮全局样式
  late ElButtonStyle buttonStyle;

  /// 输入框全局圆角值
  double inputRadius;

  /// 卡片全局圆角值
  double cardRadius;

  ElConfigData({
    this.iconSize = 20,
    ElTextStyle? textStyle,
    ElButtonStyle? buttonStyle,
    this.cardRadius = 6,
    this.inputRadius = 6,
  }) {
    this.textStyle = ElTextStyle.style.merge(textStyle);
    this.buttonStyle = ElButtonStyle.style.merge(buttonStyle);
  }
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
