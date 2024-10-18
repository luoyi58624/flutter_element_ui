// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData2 extends ElBaseThemeData {
  /// 亮色默认主题
  static const ElThemeData2 theme = ElThemeData2();

  /// 暗色默认主题
  static const ElThemeData2 darkTheme = ElThemeData2.dark();

  /// 输入框全局样式
  final ElInputThemeData inputTheme;

  /// 滑块全局样式
  final ElSliderThemeData sliderTheme;

  /// 超链接全局样式
  final ElLinkThemeData linkTheme;

  /// 标签容器全局样式
  final ElTabsThemeData tabsTheme;

  /// 标签容器子标签全局样式
  final ElTabThemeData tabTheme;

  /// 代码预览全局样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 卡片全局样式
  final ElCardThemeData cardTheme;

  /// 进度条全局样式
  final ElProgressThemeData progressTheme;

  /// 折叠菜单全局样式
  final ElCollapseThemeData collapseTheme;

  /// 标签全局样式
  final ElTagThemeData tagTheme;

  /// 侧边栏全局样式
  final ElAsideThemeData asideTheme;

  /// 导航头全局样式
  final ElHeaderThemeData headerTheme;

  /// 按钮全局样式
  final ElButtonThemeData buttonTheme;

  const ElThemeData2({
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
    this.inputTheme = ElInputThemeData.theme,
    this.sliderTheme = ElSliderThemeData.theme,
    this.linkTheme = ElLinkThemeData.theme,
    this.tabsTheme = ElTabsThemeData.theme,
    this.tabTheme = ElTabThemeData.theme,
    this.codePreviewTheme = ElCodePreviewThemeData.theme,
    this.cardTheme = ElCardThemeData.theme,
    this.progressTheme = ElProgressThemeData.theme,
    this.collapseTheme = ElCollapseThemeData.theme,
    this.tagTheme = ElTagThemeData.theme,
    this.asideTheme = ElAsideThemeData.theme,
    this.headerTheme = ElHeaderThemeData.theme,
    this.buttonTheme = ElButtonThemeData.theme,
  });

  const ElThemeData2.dark({
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
    this.inputTheme = ElInputThemeData.darkTheme,
    this.sliderTheme = ElSliderThemeData.darkTheme,
    this.linkTheme = ElLinkThemeData.darkTheme,
    this.tabsTheme = ElTabsThemeData.darkTheme,
    this.tabTheme = ElTabThemeData.darkTheme,
    this.codePreviewTheme = ElCodePreviewThemeData.darkTheme,
    this.cardTheme = ElCardThemeData.darkTheme,
    this.progressTheme = ElProgressThemeData.darkTheme,
    this.collapseTheme = ElCollapseThemeData.darkTheme,
    this.tagTheme = ElTagThemeData.darkTheme,
    this.asideTheme = ElAsideThemeData.darkTheme,
    this.headerTheme = ElHeaderThemeData.darkTheme,
    this.buttonTheme = ElButtonThemeData.darkTheme,
  }) : super.dark();
}

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElThemeDataExtension on ElThemeData {
  /// 接收一组可选参数，返回新的对象
  ElThemeData copyWith({
    ElButtonThemeData? buttonTheme,
    ElLinkThemeData? linkTheme,
    ElInputThemeData? inputTheme,
    ElCollapseThemeData? collapseTheme,
    ElProgressThemeData? progressTheme,
    ElCardThemeData? cardTheme,
    ElModalThemeData? modalTheme,
    ElMessageThemeData? messageTheme,
    ElToastThemeData? toastTheme,
    ElTooltipThemeData? tooltipTheme,
    ElSliderThemeData? sliderTheme,
    ElHeaderThemeData? headerTheme,
    ElAsideThemeData? asideTheme,
    ElNavMenuThemeData? navigationMenuTheme,
    ElTabsThemeData? tabsTheme,
    ElTabThemeData? tabTheme,
    ElTagThemeData? tagTheme,
    ElCodePreviewThemeData? codePreviewTheme,
  }) {
    return ElThemeData(
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      navigationMenuTheme: this.navigationMenuTheme.merge(navigationMenuTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElThemeData merge([ElThemeData? other]) {
    if (other == null) return this;
    return copyWith(
      buttonTheme: other.buttonTheme,
      linkTheme: other.linkTheme,
      inputTheme: other.inputTheme,
      collapseTheme: other.collapseTheme,
      progressTheme: other.progressTheme,
      cardTheme: other.cardTheme,
      modalTheme: other.modalTheme,
      messageTheme: other.messageTheme,
      toastTheme: other.toastTheme,
      tooltipTheme: other.tooltipTheme,
      sliderTheme: other.sliderTheme,
      headerTheme: other.headerTheme,
      asideTheme: other.asideTheme,
      navigationMenuTheme: other.navigationMenuTheme,
      tabsTheme: other.tabsTheme,
      tabTheme: other.tabTheme,
      tagTheme: other.tagTheme,
      codePreviewTheme: other.codePreviewTheme,
    );
  }
}
