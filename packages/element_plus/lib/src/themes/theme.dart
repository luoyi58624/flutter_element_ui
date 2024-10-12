import 'package:element_plus/element_plus.dart';

import '../global.dart';

part '../generates/themes/theme.g.dart';

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
  final ElButtonThemeData buttonTheme;

  /// 超链接全局样式
  final ElLinkThemeData linkTheme;

  /// 输入框全局样式
  final ElInputThemeData inputTheme;

  /// 折叠菜单全局样式
  final ElCollapseThemeData collapseTheme;

  /// 进度条全局样式
  final ElProgressThemeData progressTheme;

  /// 卡片全局样式
  final ElCardThemeData cardTheme;

  /// 消息提示全局样式
  final ElModalThemeData modalTheme;

  /// 消息提示全局样式
  final ElMessageThemeData messageTheme;

  /// 轻提示全局样式
  final ElToastThemeData toastTheme;

  /// 提示框全局样式
  final ElTooltipThemeData tooltipTheme;

  /// 滑块全局样式
  final ElSliderThemeData sliderTheme;

  /// 导航头全局样式
  final ElHeaderThemeData headerTheme;

  /// 侧边栏全局样式
  final ElAsideThemeData asideTheme;

  /// 导航菜单全局样式
  final ElNavMenuThemeData navigationMenuTheme;

  /// 代码预览全局样式
  final ElCodePreviewThemeData codePreviewTheme;

  const ElThemeData({
    this.primary = const Color(0xff409EFF),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.colors = const ElColorData(),
    this.buttonTheme = const ElButtonThemeData(),
    this.linkTheme = const ElLinkThemeData(
      color: ElLinkThemeData.hrefColor,
      activeColor: ElLinkThemeData.hrefColor,
    ),
    this.inputTheme = const ElInputThemeData(),
    this.collapseTheme = const ElCollapseThemeData(),
    this.progressTheme = const ElProgressThemeData(),
    this.cardTheme = const ElCardThemeData(
      color: Color(0xffffffff),
      elevation: 2,
    ),
    this.modalTheme = const ElModalThemeData(
      color: Color(0xffffffff),
      elevation: 2,
    ),
    this.messageTheme = const ElMessageThemeData(),
    this.toastTheme = const ElToastThemeData(),
    this.tooltipTheme = const ElTooltipThemeData(color: Color(0xFF616161)),
    this.sliderTheme = const ElSliderThemeData(
      inactiveColor: Color.fromRGBO(225, 226, 232, 1.0),
    ),
    this.headerTheme = const ElHeaderThemeData(color: Color(0xffffffff)),
    this.asideTheme = const ElAsideThemeData(color: Color(0xffffffff)),
    this.navigationMenuTheme = const ElNavMenuThemeData(
      activeTextColor: Color(0xff409eff),
    ),
    this.codePreviewTheme = const ElCodePreviewThemeData(
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
    this.buttonTheme = const ElButtonThemeData(),
    this.linkTheme = const ElLinkThemeData(
      color: ElLinkThemeData.darkHrefColor,
      activeColor: ElLinkThemeData.darkHrefColor,
    ),
    this.inputTheme = const ElInputThemeData(),
    this.collapseTheme = const ElCollapseThemeData(),
    this.progressTheme = const ElProgressThemeData(),
    this.cardTheme = const ElCardThemeData(
      color: Color(0xff3f3f46),
      elevation: 4,
    ),
    this.modalTheme = const ElModalThemeData(
      color: Color(0xff3f3f46),
      elevation: 4,
    ),
    this.messageTheme = const ElMessageThemeData(),
    this.toastTheme = const ElToastThemeData(),
    this.tooltipTheme = const ElTooltipThemeData(color: Color(0xFF757575)),
    this.sliderTheme = const ElSliderThemeData(
      inactiveColor: Color.fromRGBO(225, 226, 232, 1.0),
    ),
    this.headerTheme = const ElHeaderThemeData(color: Color(0xff404040)),
    this.asideTheme = const ElAsideThemeData(color: Color(0xff374151)),
    this.navigationMenuTheme = const ElNavMenuThemeData(
      activeTextColor: Color(0xff6ee7b7),
    ),
    this.codePreviewTheme = const ElCodePreviewThemeData(
      color: Color(0xFFD19A66),
      bgColor: Color.fromRGBO(49, 49, 49, 1.0),
    ),
  });
}
