// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData();

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData.dark();

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 标签容器子标签默认样式
  final ElTabThemeData tabTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 亮色主题构造器
  const ElThemeData({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    super.bgColor,
    super.regularTextColor,
    super.secondaryTextColor,
    super.placeholderTextColor,
    super.borderColor,
    this.asideTheme = ElAsideThemeData.theme,
    this.sliderTheme = ElSliderThemeData.theme,
    this.navMenuTheme = ElNavMenuThemeData.theme,
    this.headerTheme = ElHeaderThemeData.theme,
    this.cardTheme = ElCardThemeData.theme,
    this.inputTheme = ElInputThemeData.theme,
    this.iconTheme = ElIconThemeData.theme,
    this.tabsTheme = ElTabsThemeData.theme,
    this.codePreviewTheme = ElCodePreviewThemeData.theme,
    this.tabTheme = ElTabThemeData.theme,
    this.buttonTheme = ElButtonThemeData.theme,
    this.textTheme = ElTextThemeData.theme,
    this.progressTheme = ElProgressThemeData.theme,
    this.tooltipTheme = ElTooltipThemeData.theme,
    this.tagTheme = ElTagThemeData.theme,
    this.linkTheme = ElLinkThemeData.theme,
    this.collapseTheme = ElCollapseThemeData.theme,
    this.messageTheme = ElMessageThemeData.theme,
    this.modalTheme = ElModalThemeData.theme,
    this.toastTheme = ElToastThemeData.theme,
  });

  /// 暗色主题构造器
  const ElThemeData.dark({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    super.bgColor,
    super.regularTextColor,
    super.secondaryTextColor,
    super.placeholderTextColor,
    super.borderColor,
    this.asideTheme = ElAsideThemeData.darkTheme,
    this.sliderTheme = ElSliderThemeData.darkTheme,
    this.navMenuTheme = ElNavMenuThemeData.darkTheme,
    this.headerTheme = ElHeaderThemeData.darkTheme,
    this.cardTheme = ElCardThemeData.darkTheme,
    this.inputTheme = ElInputThemeData.darkTheme,
    this.iconTheme = ElIconThemeData.darkTheme,
    this.tabsTheme = ElTabsThemeData.darkTheme,
    this.codePreviewTheme = ElCodePreviewThemeData.darkTheme,
    this.tabTheme = ElTabThemeData.darkTheme,
    this.buttonTheme = ElButtonThemeData.darkTheme,
    this.textTheme = ElTextThemeData.darkTheme,
    this.progressTheme = ElProgressThemeData.darkTheme,
    this.tooltipTheme = ElTooltipThemeData.darkTheme,
    this.tagTheme = ElTagThemeData.darkTheme,
    this.linkTheme = ElLinkThemeData.darkTheme,
    this.collapseTheme = ElCollapseThemeData.darkTheme,
    this.messageTheme = ElMessageThemeData.darkTheme,
    this.modalTheme = ElModalThemeData.darkTheme,
    this.toastTheme = ElToastThemeData.darkTheme,
  }) : super.dark();

  /// 接收一组可选参数，返回新的对象
  ElThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    Color? bgColor,
    Color? regularTextColor,
    Color? secondaryTextColor,
    Color? placeholderTextColor,
    Color? borderColor,
    ElAsideThemeData? asideTheme,
    ElSliderThemeData? sliderTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElHeaderThemeData? headerTheme,
    ElCardThemeData? cardTheme,
    ElInputThemeData? inputTheme,
    ElIconThemeData? iconTheme,
    ElTabsThemeData? tabsTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElTabThemeData? tabTheme,
    ElButtonThemeData? buttonTheme,
    ElTextThemeData? textTheme,
    ElProgressThemeData? progressTheme,
    ElTooltipThemeData? tooltipTheme,
    ElTagThemeData? tagTheme,
    ElLinkThemeData? linkTheme,
    ElCollapseThemeData? collapseTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
  }) {
    return ElThemeData(
      primary: primary ?? super.primary,
      success: success ?? super.success,
      info: info ?? super.info,
      warning: warning ?? super.warning,
      error: error ?? super.error,
      bgColor: bgColor ?? super.bgColor,
      regularTextColor: regularTextColor ?? super.regularTextColor,
      secondaryTextColor: secondaryTextColor ?? super.secondaryTextColor,
      placeholderTextColor: placeholderTextColor ?? super.placeholderTextColor,
      borderColor: borderColor ?? super.borderColor,
      asideTheme: this.asideTheme.merge(asideTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      textTheme: this.textTheme.merge(textTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElThemeData merge([ElThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      primary: other.primary,
      success: other.success,
      info: other.info,
      warning: other.warning,
      error: other.error,
      bgColor: other.bgColor,
      regularTextColor: other.regularTextColor,
      secondaryTextColor: other.secondaryTextColor,
      placeholderTextColor: other.placeholderTextColor,
      borderColor: other.borderColor,
      asideTheme: other.asideTheme,
      sliderTheme: other.sliderTheme,
      navMenuTheme: other.navMenuTheme,
      headerTheme: other.headerTheme,
      cardTheme: other.cardTheme,
      inputTheme: other.inputTheme,
      iconTheme: other.iconTheme,
      tabsTheme: other.tabsTheme,
      codePreviewTheme: other.codePreviewTheme,
      tabTheme: other.tabTheme,
      buttonTheme: other.buttonTheme,
      textTheme: other.textTheme,
      progressTheme: other.progressTheme,
      tooltipTheme: other.tooltipTheme,
      tagTheme: other.tagTheme,
      linkTheme: other.linkTheme,
      collapseTheme: other.collapseTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
    );
  }
}
