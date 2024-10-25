// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static final ElThemeData theme = ElThemeData();

  /// 暗色默认主题
  static final ElThemeData darkTheme = ElThemeData.dark();

  /// 导航头默认样式
  late final ElHeaderThemeData headerTheme;

  /// 图标默认样式
  late final ElIconThemeData iconTheme;

  /// 侧边栏默认样式
  late final ElAsideThemeData asideTheme;

  /// 进度条默认样式
  late final ElProgressThemeData progressTheme;

  /// 滑块默认样式
  late final ElSliderThemeData sliderTheme;

  /// 标签容器默认样式
  late final ElTabsThemeData tabsTheme;

  /// 标签容器子标签默认样式
  late final ElTabThemeData tabTheme;

  /// 按钮默认样式
  late final ElButtonThemeData buttonTheme;

  /// 输入框默认样式
  late final ElInputThemeData inputTheme;

  /// 卡片默认样式
  late final ElCardThemeData cardTheme;

  /// 超链接默认样式
  late final ElLinkThemeData linkTheme;

  /// 提示框默认样式
  late final ElTooltipThemeData tooltipTheme;

  /// 标签默认样式
  late final ElTagThemeData tagTheme;

  /// 文本默认样式
  late final ElTextThemeData textTheme;

  /// 导航菜单默认样式
  late final ElNavMenuThemeData navMenuTheme;

  /// 代码预览默认样式
  late final ElCodePreviewThemeData codePreviewTheme;

  /// 折叠菜单默认样式
  late final ElCollapseThemeData collapseTheme;

  /// 消息提示默认样式
  late final ElMessageThemeData messageTheme;

  /// 模态框默认样式
  late final ElModalThemeData modalTheme;

  /// 轻提示默认样式
  late final ElToastThemeData toastTheme;

  /// 亮色主题构造器
  ElThemeData({
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
    ElHeaderThemeData? headerTheme,
    ElIconThemeData? iconTheme,
    ElAsideThemeData? asideTheme,
    ElProgressThemeData? progressTheme,
    ElSliderThemeData? sliderTheme,
    ElTabsThemeData? tabsTheme,
    ElTabThemeData? tabTheme,
    ElButtonThemeData? buttonTheme,
    ElInputThemeData? inputTheme,
    ElCardThemeData? cardTheme,
    ElLinkThemeData? linkTheme,
    ElTooltipThemeData? tooltipTheme,
    ElTagThemeData? tagTheme,
    ElTextThemeData? textTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElCollapseThemeData? collapseTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
  }) {
    this.headerTheme = ElHeaderThemeData.theme.merge(headerTheme);
    this.iconTheme = ElIconThemeData.theme.merge(iconTheme);
    this.asideTheme = ElAsideThemeData.theme.merge(asideTheme);
    this.progressTheme = ElProgressThemeData.theme.merge(progressTheme);
    this.sliderTheme = ElSliderThemeData.theme.merge(sliderTheme);
    this.tabsTheme = ElTabsThemeData.theme.merge(tabsTheme);
    this.tabTheme = ElTabThemeData.theme.merge(tabTheme);
    this.buttonTheme = ElButtonThemeData.theme.merge(buttonTheme);
    this.inputTheme = ElInputThemeData.theme.merge(inputTheme);
    this.cardTheme = ElCardThemeData.theme.merge(cardTheme);
    this.linkTheme = ElLinkThemeData.theme.merge(linkTheme);
    this.tooltipTheme = ElTooltipThemeData.theme.merge(tooltipTheme);
    this.tagTheme = ElTagThemeData.theme.merge(tagTheme);
    this.textTheme = ElTextThemeData.theme.merge(textTheme);
    this.navMenuTheme = ElNavMenuThemeData.theme.merge(navMenuTheme);
    this.codePreviewTheme =
        ElCodePreviewThemeData.theme.merge(codePreviewTheme);
    this.collapseTheme = ElCollapseThemeData.theme.merge(collapseTheme);
    this.messageTheme = ElMessageThemeData.theme.merge(messageTheme);
    this.modalTheme = ElModalThemeData.theme.merge(modalTheme);
    this.toastTheme = ElToastThemeData.theme.merge(toastTheme);
  }

  /// 暗色主题构造器，它是私有的，若要自定义主题请操作 [darkTheme] 实例
  ElThemeData.dark({
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
    ElHeaderThemeData? headerTheme,
    ElIconThemeData? iconTheme,
    ElAsideThemeData? asideTheme,
    ElProgressThemeData? progressTheme,
    ElSliderThemeData? sliderTheme,
    ElTabsThemeData? tabsTheme,
    ElTabThemeData? tabTheme,
    ElButtonThemeData? buttonTheme,
    ElInputThemeData? inputTheme,
    ElCardThemeData? cardTheme,
    ElLinkThemeData? linkTheme,
    ElTooltipThemeData? tooltipTheme,
    ElTagThemeData? tagTheme,
    ElTextThemeData? textTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElCollapseThemeData? collapseTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
  }) : super.dark() {
    this.headerTheme = ElHeaderThemeData.darkTheme.merge(headerTheme);
    this.iconTheme = ElIconThemeData.darkTheme.merge(iconTheme);
    this.asideTheme = ElAsideThemeData.darkTheme.merge(asideTheme);
    this.progressTheme = ElProgressThemeData.darkTheme.merge(progressTheme);
    this.sliderTheme = ElSliderThemeData.darkTheme.merge(sliderTheme);
    this.tabsTheme = ElTabsThemeData.darkTheme.merge(tabsTheme);
    this.tabTheme = ElTabThemeData.darkTheme.merge(tabTheme);
    this.buttonTheme = ElButtonThemeData.darkTheme.merge(buttonTheme);
    this.inputTheme = ElInputThemeData.darkTheme.merge(inputTheme);
    this.cardTheme = ElCardThemeData.darkTheme.merge(cardTheme);
    this.linkTheme = ElLinkThemeData.darkTheme.merge(linkTheme);
    this.tooltipTheme = ElTooltipThemeData.darkTheme.merge(tooltipTheme);
    this.tagTheme = ElTagThemeData.darkTheme.merge(tagTheme);
    this.textTheme = ElTextThemeData.darkTheme.merge(textTheme);
    this.navMenuTheme = ElNavMenuThemeData.darkTheme.merge(navMenuTheme);
    this.codePreviewTheme =
        ElCodePreviewThemeData.darkTheme.merge(codePreviewTheme);
    this.collapseTheme = ElCollapseThemeData.darkTheme.merge(collapseTheme);
    this.messageTheme = ElMessageThemeData.darkTheme.merge(messageTheme);
    this.modalTheme = ElModalThemeData.darkTheme.merge(modalTheme);
    this.toastTheme = ElToastThemeData.darkTheme.merge(toastTheme);
  }

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
    ElHeaderThemeData? headerTheme,
    ElIconThemeData? iconTheme,
    ElAsideThemeData? asideTheme,
    ElProgressThemeData? progressTheme,
    ElSliderThemeData? sliderTheme,
    ElTabsThemeData? tabsTheme,
    ElTabThemeData? tabTheme,
    ElButtonThemeData? buttonTheme,
    ElInputThemeData? inputTheme,
    ElCardThemeData? cardTheme,
    ElLinkThemeData? linkTheme,
    ElTooltipThemeData? tooltipTheme,
    ElTagThemeData? tagTheme,
    ElTextThemeData? textTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCodePreviewThemeData? codePreviewTheme,
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
      headerTheme: this.headerTheme.merge(headerTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      textTheme: this.textTheme.merge(textTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
    );
  }
}
