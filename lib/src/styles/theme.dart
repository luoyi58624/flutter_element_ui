import 'package:flutter/painting.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_ui/src/extensions/color.dart';

part '../generates/styles/theme.g.dart';

/// 根据平台亮度应用的主题对象
@ElModel(copyWith: true)
class ElThemeData {
  /// 亮色默认主题
  static ElThemeData lightTheme = ElThemeData();

  /// 暗色默认主题
  static ElThemeData darkTheme = ElThemeData.dark();

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

  /// 头部背景颜色
  Color headerColor;

  /// 侧边栏背景色
  Color asideBgColor;

  /// 卡片背景色
  Color cardColor;

  /// 模态框、弹出层背景色
  Color modalColor;

  /// 文字主要颜色
  Color textColor;
  Color textSecondary;
  Color textPlaceholder;

  /// icon颜色
  Color iconColor;

  /// 边框颜色
  Color borderColor;

  /// 边框悬停颜色
  Color get borderHoverColor => borderColor.deepen(16);

  /// 菜单栏激活文字颜色
  Color menuActiveColor;

  /// 滑块激活颜色，默认跟随主题
  Color? sliderActiveColor;

  /// 滑块未激活颜色
  Color sliderInactiveColor;

  /// 文字提示浮窗背景颜色
  Color tooltipColor;

  /// 卡片海拔高度，设置较低的海拔能让应用更加扁平化，设置较高的海拔则让应用更具层级感
  double cardElevation;

  /// 模态弹窗海拔高度
  double modalElevation;

  /// 默认的亮色主题构造函数
  ElThemeData({
    this.primary = const Color(0xff409EFF),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.bgColor = const Color(0xfffafafa),
    this.headerColor = const Color(0xffffffff),
    this.cardColor = const Color(0xffffffff),
    this.modalColor = const Color(0xffffffff),
    this.textColor = const Color(0xff303133),
    this.textSecondary = const Color(0xff909399),
    this.textPlaceholder = const Color(0xffC0C4CC),
    this.iconColor = const Color(0xff404040),
    this.borderColor = const Color(0xffDCDFE6),
    this.asideBgColor = const Color(0xffffffff),
    this.menuActiveColor = const Color(0xff409eff),
    Color? sliderActiveColor,
    this.sliderInactiveColor = const Color.fromRGBO(225, 226, 232, 1.0),
    this.tooltipColor = const Color(0xFF616161),
    this.cardElevation = 0,
    this.modalElevation = 2,
  }) {
    this.sliderActiveColor = sliderActiveColor ?? primary;
  }

  /// 默认的暗色主题构造函数
  ElThemeData.dark({
    this.primary = const Color(0xff0ea5e9),
    this.success = const Color(0xff14b8a6),
    this.info = const Color(0xff64748B),
    this.warning = const Color(0xfffbbf24),
    this.error = const Color(0xfffb7185),
    this.bgColor = const Color(0xff2b2b2b),
    this.headerColor = const Color(0xff404040),
    this.cardColor = const Color(0xff3f3f46),
    this.modalColor = const Color(0xff3f3f46),
    this.textColor = const Color(0xfff2f2f2),
    this.textSecondary = const Color(0xff909399),
    this.textPlaceholder = const Color(0xffC0C4CC),
    this.iconColor = const Color(0xfff6f6f6),
    this.borderColor = const Color(0xffa3a3a3),
    // this.asideBgColor = const Color(0xff565c64),
    // this.menuActiveColor = const Color(0xffffd04b),
    this.asideBgColor = const Color(0xff374151),
    this.menuActiveColor = const Color(0xff6ee7b7),
    Color? sliderActiveColor,
    this.sliderInactiveColor = const Color.fromRGBO(225, 226, 232, 1.0),
    this.tooltipColor = const Color(0xFF757575),
    this.cardElevation = 2,
    this.modalElevation = 4,
  }) {
    this.sliderActiveColor = sliderActiveColor ?? primary;
  }
}
