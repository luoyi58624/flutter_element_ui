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

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 标签容器子标签默认样式
  final ElTabThemeData tabTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 亮色主题构造器，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
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
    this.textTheme = ElTextThemeData.theme,
    this.buttonTheme = ElButtonThemeData.theme,
    this.linkTheme = ElLinkThemeData.theme,
    this.tabTheme = ElTabThemeData.theme,
    this.inputTheme = ElInputThemeData.theme,
    this.headerTheme = ElHeaderThemeData.theme,
    this.tooltipTheme = ElTooltipThemeData.theme,
    this.sliderTheme = ElSliderThemeData.theme,
    this.progressTheme = ElProgressThemeData.theme,
    this.navMenuTheme = ElNavMenuThemeData.theme,
    this.tagTheme = ElTagThemeData.theme,
    this.codePreviewTheme = ElCodePreviewThemeData.theme,
    this.cardTheme = ElCardThemeData.theme,
    this.iconTheme = ElIconThemeData.theme,
    this.tabsTheme = ElTabsThemeData.theme,
    this.collapseTheme = ElCollapseThemeData.theme,
    this.messageTheme = ElMessageThemeData.theme,
    this.modalTheme = ElModalThemeData.theme,
    this.toastTheme = ElToastThemeData.theme,
  });

  /// 暗色主题构造器，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
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
    this.textTheme = ElTextThemeData.darkTheme,
    this.buttonTheme = ElButtonThemeData.darkTheme,
    this.linkTheme = ElLinkThemeData.darkTheme,
    this.tabTheme = ElTabThemeData.darkTheme,
    this.inputTheme = ElInputThemeData.darkTheme,
    this.headerTheme = ElHeaderThemeData.darkTheme,
    this.tooltipTheme = ElTooltipThemeData.darkTheme,
    this.sliderTheme = ElSliderThemeData.darkTheme,
    this.progressTheme = ElProgressThemeData.darkTheme,
    this.navMenuTheme = ElNavMenuThemeData.darkTheme,
    this.tagTheme = ElTagThemeData.darkTheme,
    this.codePreviewTheme = ElCodePreviewThemeData.darkTheme,
    this.cardTheme = ElCardThemeData.darkTheme,
    this.iconTheme = ElIconThemeData.darkTheme,
    this.tabsTheme = ElTabsThemeData.darkTheme,
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
    ElTextThemeData? textTheme,
    ElButtonThemeData? buttonTheme,
    ElLinkThemeData? linkTheme,
    ElTabThemeData? tabTheme,
    ElInputThemeData? inputTheme,
    ElHeaderThemeData? headerTheme,
    ElTooltipThemeData? tooltipTheme,
    ElSliderThemeData? sliderTheme,
    ElProgressThemeData? progressTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElTagThemeData? tagTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElCardThemeData? cardTheme,
    ElIconThemeData? iconTheme,
    ElTabsThemeData? tabsTheme,
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
      textTheme: this.textTheme.merge(textTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
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
      textTheme: other.textTheme,
      buttonTheme: other.buttonTheme,
      linkTheme: other.linkTheme,
      tabTheme: other.tabTheme,
      inputTheme: other.inputTheme,
      headerTheme: other.headerTheme,
      tooltipTheme: other.tooltipTheme,
      sliderTheme: other.sliderTheme,
      progressTheme: other.progressTheme,
      navMenuTheme: other.navMenuTheme,
      tagTheme: other.tagTheme,
      codePreviewTheme: other.codePreviewTheme,
      cardTheme: other.cardTheme,
      iconTheme: other.iconTheme,
      tabsTheme: other.tabsTheme,
      collapseTheme: other.collapseTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
    );
  }
}
