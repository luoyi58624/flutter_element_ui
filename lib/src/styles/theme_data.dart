import 'package:flutter/material.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/styles/color_data.dart';

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
  final ElButtonStyle buttonStyle;

  /// 超链接全局样式
  final ElLinkStyle linkStyle;

  /// 输入框全局样式
  final ElInputStyle inputStyle;

  /// 折叠菜单全局样式
  final ElCollapseStyle collapseStyle;

  /// 卡片全局样式
  final ElCardStyle cardStyle;

  /// 消息提示全局样式
  final ElModalStyle modalStyle;

  /// 消息提示全局样式
  final ElMessageStyle messageStyle;

  /// 轻提示全局样式
  final ElToastStyle toastStyle;

  /// 提示框全局样式
  final ElTooltipStyle tooltipStyle;

  /// 滑块全局样式
  final ElSliderStyle sliderStyle;

  /// 导航头全局样式
  final ElHeaderStyle headerStyle;

  /// 侧边栏全局样式
  final ElAsideStyle asideStyle;

  /// 导航菜单全局样式
  final ElNavMenuStyle navigationMenuStyle;

  const ElThemeData({
    this.primary = const Color(0xff409EFF),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.colors = const ElColorData(),
    this.buttonStyle = const ElButtonStyle(),
    this.linkStyle = const ElLinkStyle(
      color: ElLinkStyle.hrefColor,
      activeColor: ElLinkStyle.hrefColor,
    ),
    this.inputStyle = const ElInputStyle(),
    this.collapseStyle = const ElCollapseStyle(),
    this.cardStyle = const ElCardStyle(
      color: Color(0xffffffff),
      elevation: 2,
    ),
    this.modalStyle = const ElModalStyle(
      color: Color(0xffffffff),
      elevation: 2,
    ),
    this.messageStyle = const ElMessageStyle(),
    this.toastStyle = const ElToastStyle(),
    this.tooltipStyle = const ElTooltipStyle(color: Color(0xFF616161)),
    this.sliderStyle = const ElSliderStyle(
      inactiveColor: Color.fromRGBO(225, 226, 232, 1.0),
    ),
    this.headerStyle = const ElHeaderStyle(color: Color(0xffffffff)),
    this.asideStyle = const ElAsideStyle(color: Color(0xffffffff)),
    this.navigationMenuStyle = const ElNavMenuStyle(
      activeTextColor: Color(0xff409eff),
    ),
  });

  const ElThemeData.dark({
    this.primary = const Color(0xff0ea5e9),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.colors = const ElColorData.dark(),
    this.buttonStyle = const ElButtonStyle(),
    this.linkStyle = const ElLinkStyle(
      color: ElLinkStyle.darkHrefColor,
      activeColor: ElLinkStyle.darkHrefColor,
    ),
    this.inputStyle = const ElInputStyle(),
    this.collapseStyle = const ElCollapseStyle(),
    this.cardStyle = const ElCardStyle(
      color: Color(0xff3f3f46),
      elevation: 4,
    ),
    this.modalStyle = const ElModalStyle(
      color: Color(0xff3f3f46),
      elevation: 4,
    ),
    this.messageStyle = const ElMessageStyle(),
    this.toastStyle = const ElToastStyle(),
    this.tooltipStyle = const ElTooltipStyle(color: Color(0xFF757575)),
    this.sliderStyle = const ElSliderStyle(
      inactiveColor: Color.fromRGBO(225, 226, 232, 1.0),
    ),
    this.headerStyle = const ElHeaderStyle(color: Color(0xff404040)),
    this.asideStyle = const ElAsideStyle(color: Color(0xff374151)),
    this.navigationMenuStyle = const ElNavMenuStyle(
      activeTextColor: Color(0xff6ee7b7),
    ),
  });
}
