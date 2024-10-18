import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart';

import '../components/data/tag/index.dart';
import '../global.dart';

part '../generates/themes/theme.g.dart';

@$ElGlobalThemeModel()
class ElBaseThemeData {
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

  /// 全局背景色
  final Color bgColor;

  /// 图标默认颜色
  final Color iconColor;

  /// 默认文本颜色
  final Color textColor;

  /// 常规文本颜色
  final Color regularTextColor;

  /// 次要文本颜色
  final Color secondaryTextColor;

  /// 占位文本颜色
  final Color placeholderTextColor;

  /// 边框颜色
  final Color borderColor;

  /// 边框颜色与背景色进行混合形成的颜色
  Color get borderLightColor => borderColor.mix(bgColor, 50);

  const ElBaseThemeData({
    this.primary = const Color(0xff409EFF),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.bgColor = const Color(0xfffafafa),
    this.iconColor = const Color.fromRGBO(96, 98, 102, 1.0),
    this.textColor = const Color(0xff323232),
    this.regularTextColor = const Color(0xff606266),
    this.secondaryTextColor = const Color(0xff909399),
    this.placeholderTextColor = const Color(0xffA8ABB2),
    this.borderColor = const Color(0xffDCDFE6),
  });

  const ElBaseThemeData.dark({
    this.primary = const Color(0xff0ea5e9),
    this.success = const Color(0xff67C23A),
    this.info = const Color(0xff909399),
    this.warning = const Color(0xffE6A23C),
    this.error = const Color(0xffF56C6C),
    this.bgColor = const Color(0xff2b2b2b),
    this.iconColor = const Color(0xfff6f6f6),
    this.textColor = const Color(0xfff2f2f2),
    this.regularTextColor = const Color(0xffCFD3DC),
    this.secondaryTextColor = const Color(0xffA3A6AD),
    this.placeholderTextColor = const Color(0xff8D9095),
    this.borderColor = const Color(0xffa3a3a3),
  });
}

// =============================================================================
// 将生成的所有组件主题配置全都放在 ThemeData 中，优点是用户在使用局部主题时更方便、代码维护更简单，
// 缺点是用户如果配置多套主题就要重复配置很多选项，而这些选项跟主题无关，这里的解决方法是，
// 你可以封装一个主题生成函数，提取出不同的颜色主题，传递颜色主题返回完整的主题数据。
// =============================================================================
@$ElModel.copy()
class ElThemeData extends ElBaseThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData();

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData.dark();

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

  /// 标签容器全局样式
  final ElTabsThemeData tabsTheme;

  /// 标签容器全局样式
  final ElTabThemeData tabTheme;

  /// 标签全局样式
  final ElTagThemeData tagTheme;

  /// 代码预览全局样式
  final ElCodePreviewThemeData codePreviewTheme;

  const ElThemeData({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    super.bgColor,
    super.iconColor,
    super.textColor,
    super.regularTextColor,
    super.secondaryTextColor,
    super.placeholderTextColor,
    super.borderColor,
    this.buttonTheme = const ElButtonThemeData(),
    this.linkTheme = ElLinkThemeData.theme,
    this.inputTheme = const ElInputThemeData(),
    this.collapseTheme = const ElCollapseThemeData(),
    this.progressTheme = const ElProgressThemeData(),
    this.cardTheme = ElCardThemeData.theme,
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
    this.tabsTheme = const ElTabsThemeData(),
    this.tabTheme = const ElTabThemeData(),
    this.tagTheme = const ElTagThemeData(),
    this.codePreviewTheme = const ElCodePreviewThemeData(
      color: Color(0xFFD19A66),
      bgColor: Color.fromRGBO(49, 49, 49, 1.0),
    ),
  });

  const ElThemeData.dark({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    super.bgColor,
    super.iconColor,
    super.textColor,
    super.regularTextColor,
    super.secondaryTextColor,
    super.placeholderTextColor,
    super.borderColor,
    this.buttonTheme = const ElButtonThemeData(),
    this.linkTheme = ElLinkThemeData.darkTheme,
    this.inputTheme = const ElInputThemeData(),
    this.collapseTheme = const ElCollapseThemeData(),
    this.progressTheme = const ElProgressThemeData(),
    this.cardTheme = ElCardThemeData.darkTheme,
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
    this.tabsTheme = const ElTabsThemeData(),
    this.tabTheme = const ElTabThemeData(),
    this.tagTheme = const ElTagThemeData(),
    this.codePreviewTheme = const ElCodePreviewThemeData(
      color: Color(0xFFD19A66),
      bgColor: Color.fromRGBO(49, 49, 49, 1.0),
    ),
  }) : super.dark();
}
