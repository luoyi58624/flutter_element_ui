// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    inputTheme: ElInputThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    asideTheme: ElAsideThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    textTheme: ElTextThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    toastTheme: ElToastThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    inputTheme: ElInputThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
  );

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

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
    required this.inputTheme,
    required this.headerTheme,
    required this.asideTheme,
    required this.linkTheme,
    required this.textTheme,
    required this.iconTheme,
    required this.navMenuTheme,
    required this.codePreviewTheme,
    required this.sliderTheme,
    required this.closeButtonTheme,
    required this.tooltipTheme,
    required this.cardTheme,
    required this.tagTheme,
    required this.progressTheme,
    required this.tabsTheme,
    required this.buttonTheme,
    required this.collapseTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.inputTheme,
    required this.headerTheme,
    required this.asideTheme,
    required this.linkTheme,
    required this.textTheme,
    required this.iconTheme,
    required this.navMenuTheme,
    required this.codePreviewTheme,
    required this.sliderTheme,
    required this.closeButtonTheme,
    required this.tooltipTheme,
    required this.cardTheme,
    required this.tagTheme,
    required this.progressTheme,
    required this.tabsTheme,
    required this.buttonTheme,
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
    ElInputThemeData? inputTheme,
    ElHeaderThemeData? headerTheme,
    ElAsideThemeData? asideTheme,
    ElLinkThemeData? linkTheme,
    ElTextThemeData? textTheme,
    ElIconThemeData? iconTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElSliderThemeData? sliderTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElTooltipThemeData? tooltipTheme,
    ElCardThemeData? cardTheme,
    ElTagThemeData? tagTheme,
    ElProgressThemeData? progressTheme,
    ElTabsThemeData? tabsTheme,
    ElButtonThemeData? buttonTheme,
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
      inputTheme: this.inputTheme.merge(inputTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      textTheme: this.textTheme.merge(textTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
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
      inputTheme: other.inputTheme,
      headerTheme: other.headerTheme,
      asideTheme: other.asideTheme,
      linkTheme: other.linkTheme,
      textTheme: other.textTheme,
      iconTheme: other.iconTheme,
      navMenuTheme: other.navMenuTheme,
      codePreviewTheme: other.codePreviewTheme,
      sliderTheme: other.sliderTheme,
      closeButtonTheme: other.closeButtonTheme,
      tooltipTheme: other.tooltipTheme,
      cardTheme: other.cardTheme,
      tagTheme: other.tagTheme,
      progressTheme: other.progressTheme,
      tabsTheme: other.tabsTheme,
      buttonTheme: other.buttonTheme,
      collapseTheme: other.collapseTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
    );
  }
}
