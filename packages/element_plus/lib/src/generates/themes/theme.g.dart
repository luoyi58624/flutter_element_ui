// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    sliderTheme: ElSliderThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    textTheme: ElTextThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    asideTheme: ElAsideThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    toastTheme: ElToastThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    sliderTheme: ElSliderThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
  );

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 亮色主题构造器，构建器是私有的，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    super.bgColor,
    super.borderColor,
    required this.sliderTheme,
    required this.inputTheme,
    required this.tooltipTheme,
    required this.cardTheme,
    required this.buttonTheme,
    required this.linkTheme,
    required this.tagTheme,
    required this.textTheme,
    required this.navMenuTheme,
    required this.iconTheme,
    required this.collapseTheme,
    required this.tabsTheme,
    required this.progressTheme,
    required this.closeButtonTheme,
    required this.codePreviewTheme,
    required this.asideTheme,
    required this.headerTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.sliderTheme,
    required this.inputTheme,
    required this.tooltipTheme,
    required this.cardTheme,
    required this.buttonTheme,
    required this.linkTheme,
    required this.tagTheme,
    required this.textTheme,
    required this.navMenuTheme,
    required this.iconTheme,
    required this.collapseTheme,
    required this.tabsTheme,
    required this.progressTheme,
    required this.closeButtonTheme,
    required this.codePreviewTheme,
    required this.asideTheme,
    required this.headerTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
  }) : super.dark();

  /// 接收一组可选参数，返回新的对象
  ElThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    Color? bgColor,
    Color? borderColor,
    ElSliderThemeData? sliderTheme,
    ElInputThemeData? inputTheme,
    ElTooltipThemeData? tooltipTheme,
    ElCardThemeData? cardTheme,
    ElButtonThemeData? buttonTheme,
    ElLinkThemeData? linkTheme,
    ElTagThemeData? tagTheme,
    ElTextThemeData? textTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElIconThemeData? iconTheme,
    ElCollapseThemeData? collapseTheme,
    ElTabsThemeData? tabsTheme,
    ElProgressThemeData? progressTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
  }) {
    return ElThemeData._(
      primary: primary ?? super.primary,
      success: success ?? super.success,
      info: info ?? super.info,
      warning: warning ?? super.warning,
      error: error ?? super.error,
      bgColor: bgColor ?? super.bgColor,
      borderColor: borderColor ?? super.borderColor,
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      textTheme: this.textTheme.merge(textTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
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
      borderColor: other.borderColor,
      sliderTheme: other.sliderTheme,
      inputTheme: other.inputTheme,
      tooltipTheme: other.tooltipTheme,
      cardTheme: other.cardTheme,
      buttonTheme: other.buttonTheme,
      linkTheme: other.linkTheme,
      tagTheme: other.tagTheme,
      textTheme: other.textTheme,
      navMenuTheme: other.navMenuTheme,
      iconTheme: other.iconTheme,
      collapseTheme: other.collapseTheme,
      tabsTheme: other.tabsTheme,
      progressTheme: other.progressTheme,
      closeButtonTheme: other.closeButtonTheme,
      codePreviewTheme: other.codePreviewTheme,
      asideTheme: other.asideTheme,
      headerTheme: other.headerTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
    );
  }
}
