// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    iconTheme: ElIconThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    asideTheme: ElAsideThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    textTheme: ElTextThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    toastTheme: ElToastThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    iconTheme: ElIconThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
  );

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

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
    required this.iconTheme,
    required this.closeButtonTheme,
    required this.tabsTheme,
    required this.inputTheme,
    required this.headerTheme,
    required this.sliderTheme,
    required this.tagTheme,
    required this.codePreviewTheme,
    required this.linkTheme,
    required this.tooltipTheme,
    required this.asideTheme,
    required this.navMenuTheme,
    required this.buttonTheme,
    required this.textTheme,
    required this.cardTheme,
    required this.progressTheme,
    required this.collapseTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.iconTheme,
    required this.closeButtonTheme,
    required this.tabsTheme,
    required this.inputTheme,
    required this.headerTheme,
    required this.sliderTheme,
    required this.tagTheme,
    required this.codePreviewTheme,
    required this.linkTheme,
    required this.tooltipTheme,
    required this.asideTheme,
    required this.navMenuTheme,
    required this.buttonTheme,
    required this.textTheme,
    required this.cardTheme,
    required this.progressTheme,
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
    ElIconThemeData? iconTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElTabsThemeData? tabsTheme,
    ElInputThemeData? inputTheme,
    ElHeaderThemeData? headerTheme,
    ElSliderThemeData? sliderTheme,
    ElTagThemeData? tagTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElLinkThemeData? linkTheme,
    ElTooltipThemeData? tooltipTheme,
    ElAsideThemeData? asideTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElButtonThemeData? buttonTheme,
    ElTextThemeData? textTheme,
    ElCardThemeData? cardTheme,
    ElProgressThemeData? progressTheme,
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
      iconTheme: this.iconTheme.merge(iconTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      textTheme: this.textTheme.merge(textTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
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
      iconTheme: other.iconTheme,
      closeButtonTheme: other.closeButtonTheme,
      tabsTheme: other.tabsTheme,
      inputTheme: other.inputTheme,
      headerTheme: other.headerTheme,
      sliderTheme: other.sliderTheme,
      tagTheme: other.tagTheme,
      codePreviewTheme: other.codePreviewTheme,
      linkTheme: other.linkTheme,
      tooltipTheme: other.tooltipTheme,
      asideTheme: other.asideTheme,
      navMenuTheme: other.navMenuTheme,
      buttonTheme: other.buttonTheme,
      textTheme: other.textTheme,
      cardTheme: other.cardTheme,
      progressTheme: other.progressTheme,
      collapseTheme: other.collapseTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
    );
  }
}
