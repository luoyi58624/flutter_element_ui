// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    linkTheme: ElLinkThemeData.theme,
    textTheme: ElTextThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    asideTheme: ElAsideThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    toastTheme: ElToastThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    linkTheme: ElLinkThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
  );

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

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
    required this.linkTheme,
    required this.textTheme,
    required this.sliderTheme,
    required this.closeButtonTheme,
    required this.tooltipTheme,
    required this.codePreviewTheme,
    required this.tabsTheme,
    required this.progressTheme,
    required this.navMenuTheme,
    required this.buttonTheme,
    required this.inputTheme,
    required this.tagTheme,
    required this.iconTheme,
    required this.collapseTheme,
    required this.cardTheme,
    required this.asideTheme,
    required this.headerTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.linkTheme,
    required this.textTheme,
    required this.sliderTheme,
    required this.closeButtonTheme,
    required this.tooltipTheme,
    required this.codePreviewTheme,
    required this.tabsTheme,
    required this.progressTheme,
    required this.navMenuTheme,
    required this.buttonTheme,
    required this.inputTheme,
    required this.tagTheme,
    required this.iconTheme,
    required this.collapseTheme,
    required this.cardTheme,
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
    ElLinkThemeData? linkTheme,
    ElTextThemeData? textTheme,
    ElSliderThemeData? sliderTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElTooltipThemeData? tooltipTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElTabsThemeData? tabsTheme,
    ElProgressThemeData? progressTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElButtonThemeData? buttonTheme,
    ElInputThemeData? inputTheme,
    ElTagThemeData? tagTheme,
    ElIconThemeData? iconTheme,
    ElCollapseThemeData? collapseTheme,
    ElCardThemeData? cardTheme,
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
      linkTheme: this.linkTheme.merge(linkTheme),
      textTheme: this.textTheme.merge(textTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
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
      linkTheme: other.linkTheme,
      textTheme: other.textTheme,
      sliderTheme: other.sliderTheme,
      closeButtonTheme: other.closeButtonTheme,
      tooltipTheme: other.tooltipTheme,
      codePreviewTheme: other.codePreviewTheme,
      tabsTheme: other.tabsTheme,
      progressTheme: other.progressTheme,
      navMenuTheme: other.navMenuTheme,
      buttonTheme: other.buttonTheme,
      inputTheme: other.inputTheme,
      tagTheme: other.tagTheme,
      iconTheme: other.iconTheme,
      collapseTheme: other.collapseTheme,
      cardTheme: other.cardTheme,
      asideTheme: other.asideTheme,
      headerTheme: other.headerTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
    );
  }
}
