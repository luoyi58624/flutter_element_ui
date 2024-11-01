// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    textTheme: ElTextThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    asideTheme: ElAsideThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    toastTheme: ElToastThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    textTheme: ElTextThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
  );

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

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
    required this.textTheme,
    required this.headerTheme,
    required this.sliderTheme,
    required this.asideTheme,
    required this.inputTheme,
    required this.tabsTheme,
    required this.linkTheme,
    required this.iconTheme,
    required this.tooltipTheme,
    required this.buttonTheme,
    required this.progressTheme,
    required this.codePreviewTheme,
    required this.navMenuTheme,
    required this.cardTheme,
    required this.tagTheme,
    required this.closeButtonTheme,
    required this.collapseTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.textTheme,
    required this.headerTheme,
    required this.sliderTheme,
    required this.asideTheme,
    required this.inputTheme,
    required this.tabsTheme,
    required this.linkTheme,
    required this.iconTheme,
    required this.tooltipTheme,
    required this.buttonTheme,
    required this.progressTheme,
    required this.codePreviewTheme,
    required this.navMenuTheme,
    required this.cardTheme,
    required this.tagTheme,
    required this.closeButtonTheme,
    required this.collapseTheme,
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
    ElTextThemeData? textTheme,
    ElHeaderThemeData? headerTheme,
    ElSliderThemeData? sliderTheme,
    ElAsideThemeData? asideTheme,
    ElInputThemeData? inputTheme,
    ElTabsThemeData? tabsTheme,
    ElLinkThemeData? linkTheme,
    ElIconThemeData? iconTheme,
    ElTooltipThemeData? tooltipTheme,
    ElButtonThemeData? buttonTheme,
    ElProgressThemeData? progressTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCardThemeData? cardTheme,
    ElTagThemeData? tagTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElCollapseThemeData? collapseTheme,
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
      textTheme: this.textTheme.merge(textTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
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
      borderColor: other.borderColor,
      textTheme: other.textTheme,
      headerTheme: other.headerTheme,
      sliderTheme: other.sliderTheme,
      asideTheme: other.asideTheme,
      inputTheme: other.inputTheme,
      tabsTheme: other.tabsTheme,
      linkTheme: other.linkTheme,
      iconTheme: other.iconTheme,
      tooltipTheme: other.tooltipTheme,
      buttonTheme: other.buttonTheme,
      progressTheme: other.progressTheme,
      codePreviewTheme: other.codePreviewTheme,
      navMenuTheme: other.navMenuTheme,
      cardTheme: other.cardTheme,
      tagTheme: other.tagTheme,
      closeButtonTheme: other.closeButtonTheme,
      collapseTheme: other.collapseTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
    );
  }
}
