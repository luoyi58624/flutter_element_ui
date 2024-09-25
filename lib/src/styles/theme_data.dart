import 'package:flutter/material.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/styles/color_data.dart';

import 'other/code_preview.dart';

part '../generates/styles/theme_data.g.dart';

@ElModel.copy()
class ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData();

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData.dark();

  /// 主要颜色
  final Color primary;

  /// 成功颜色
  final Color success;

  /// 普通颜色
  final Color info;

  /// 警告颜色
  final Color warning;

  /// 错误颜色
  final Color error;

  /// 常规颜色主题：文本、图标、边框
  final ElColorData colors;

  /// 按钮全局样式
  final ElButtonThemeData buttonStyle;

  /// 超链接全局样式
  final ElLinkThemeData linkStyle;

  /// 输入框全局样式
  final ElInputThemeData inputStyle;

  /// 折叠菜单全局样式
  final ElCollapseThemeData collapseStyle;

  /// 卡片全局样式
  final ElCardThemeData cardStyle;

  /// 消息提示全局样式
  final ElModalThemeData modalStyle;

  /// 消息提示全局样式
  final ElMessageThemeData messageStyle;

  /// 轻提示全局样式
  final ElToastThemeData toastStyle;

  /// 提示框全局样式
  final ElTooltipThemeData tooltipStyle;

  /// 滑块全局样式
  final ElSliderThemeData sliderStyle;

  /// 导航头全局样式
  final ElHeaderStyle headerStyle;

  /// 侧边栏全局样式
  final ElAsideStyle asideStyle;

  /// 导航菜单全局样式
  final ElNavMenuThemeData navigationMenuStyle;

  /// 代码预览全局样式
  final ElCodePreviewStyle codePreviewStyle;

  const ElThemeData({
    this.primary = const Color(0xff409EFF),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.colors = const ElColorData(),
    this.buttonStyle = const ElButtonThemeData(),
    this.linkStyle = const ElLinkThemeData(
      color: ElLinkThemeData.hrefColor,
      activeColor: ElLinkThemeData.hrefColor,
    ),
    this.inputStyle = const ElInputThemeData(),
    this.collapseStyle = const ElCollapseThemeData(),
    this.cardStyle = const ElCardThemeData(
      color: Color(0xffffffff),
      elevation: 2,
    ),
    this.modalStyle = const ElModalThemeData(
      color: Color(0xffffffff),
      elevation: 2,
    ),
    this.messageStyle = const ElMessageThemeData(),
    this.toastStyle = const ElToastThemeData(),
    this.tooltipStyle = const ElTooltipThemeData(color: Color(0xFF616161)),
    this.sliderStyle = const ElSliderThemeData(
      inactiveColor: Color.fromRGBO(225, 226, 232, 1.0),
    ),
    this.headerStyle = const ElHeaderStyle(color: Color(0xffffffff)),
    this.asideStyle = const ElAsideStyle(color: Color(0xffffffff)),
    this.navigationMenuStyle = const ElNavMenuThemeData(
      activeTextColor: Color(0xff409eff),
    ),
    this.codePreviewStyle = const ElCodePreviewStyle(
      color: Color(0xFFD19A66),
      bgColor: Color.fromRGBO(49, 49, 49, 1.0),
    ),
  });

  const ElThemeData.dark({
    this.primary = const Color(0xff0ea5e9),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.colors = const ElColorData.dark(),
    this.buttonStyle = const ElButtonThemeData(),
    this.linkStyle = const ElLinkThemeData(
      color: ElLinkThemeData.darkHrefColor,
      activeColor: ElLinkThemeData.darkHrefColor,
    ),
    this.inputStyle = const ElInputThemeData(),
    this.collapseStyle = const ElCollapseThemeData(),
    this.cardStyle = const ElCardThemeData(
      color: Color(0xff3f3f46),
      elevation: 4,
    ),
    this.modalStyle = const ElModalThemeData(
      color: Color(0xff3f3f46),
      elevation: 4,
    ),
    this.messageStyle = const ElMessageThemeData(),
    this.toastStyle = const ElToastThemeData(),
    this.tooltipStyle = const ElTooltipThemeData(color: Color(0xFF757575)),
    this.sliderStyle = const ElSliderThemeData(
      inactiveColor: Color.fromRGBO(225, 226, 232, 1.0),
    ),
    this.headerStyle = const ElHeaderStyle(color: Color(0xff404040)),
    this.asideStyle = const ElAsideStyle(color: Color(0xff374151)),
    this.navigationMenuStyle = const ElNavMenuThemeData(
      activeTextColor: Color(0xff6ee7b7),
    ),
    this.codePreviewStyle = const ElCodePreviewStyle(
      color: Color(0xFFD19A66),
      bgColor: Color.fromRGBO(49, 49, 49, 1.0),
    ),
  });
}
