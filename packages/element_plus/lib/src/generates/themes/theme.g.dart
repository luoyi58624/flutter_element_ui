// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    collapseTheme: ElCollapseThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    textTheme: ElTextThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
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
    collapseTheme: ElCollapseThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
  );

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

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
    required this.collapseTheme,
    required this.buttonTheme,
    required this.textTheme,
    required this.linkTheme,
    required this.iconTheme,
    required this.progressTheme,
    required this.cardTheme,
    required this.tooltipTheme,
    required this.tagTheme,
    required this.navMenuTheme,
    required this.inputTheme,
    required this.sliderTheme,
    required this.tabsTheme,
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
    required this.collapseTheme,
    required this.buttonTheme,
    required this.textTheme,
    required this.linkTheme,
    required this.iconTheme,
    required this.progressTheme,
    required this.cardTheme,
    required this.tooltipTheme,
    required this.tagTheme,
    required this.navMenuTheme,
    required this.inputTheme,
    required this.sliderTheme,
    required this.tabsTheme,
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
    ElCollapseThemeData? collapseTheme,
    ElButtonThemeData? buttonTheme,
    ElTextThemeData? textTheme,
    ElLinkThemeData? linkTheme,
    ElIconThemeData? iconTheme,
    ElProgressThemeData? progressTheme,
    ElCardThemeData? cardTheme,
    ElTooltipThemeData? tooltipTheme,
    ElTagThemeData? tagTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElInputThemeData? inputTheme,
    ElSliderThemeData? sliderTheme,
    ElTabsThemeData? tabsTheme,
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
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      textTheme: this.textTheme.merge(textTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
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
      collapseTheme: other.collapseTheme,
      buttonTheme: other.buttonTheme,
      textTheme: other.textTheme,
      linkTheme: other.linkTheme,
      iconTheme: other.iconTheme,
      progressTheme: other.progressTheme,
      cardTheme: other.cardTheme,
      tooltipTheme: other.tooltipTheme,
      tagTheme: other.tagTheme,
      navMenuTheme: other.navMenuTheme,
      inputTheme: other.inputTheme,
      sliderTheme: other.sliderTheme,
      tabsTheme: other.tabsTheme,
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
