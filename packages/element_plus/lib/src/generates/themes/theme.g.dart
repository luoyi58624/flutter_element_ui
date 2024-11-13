// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    eventTheme: ElEventThemeData.theme,
    asideTheme: ElAsideThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    textTheme: ElTextThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    toastTheme: ElToastThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    eventTheme: ElEventThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
  );

  /// 事件默认配置
  final ElEventThemeData eventTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

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
    required this.eventTheme,
    required this.asideTheme,
    required this.headerTheme,
    required this.inputTheme,
    required this.sliderTheme,
    required this.linkTheme,
    required this.textTheme,
    required this.buttonTheme,
    required this.iconTheme,
    required this.tabsTheme,
    required this.navMenuTheme,
    required this.codePreviewTheme,
    required this.closeButtonTheme,
    required this.tooltipTheme,
    required this.cardTheme,
    required this.progressTheme,
    required this.tagTheme,
    required this.collapseTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.eventTheme,
    required this.asideTheme,
    required this.headerTheme,
    required this.inputTheme,
    required this.sliderTheme,
    required this.linkTheme,
    required this.textTheme,
    required this.buttonTheme,
    required this.iconTheme,
    required this.tabsTheme,
    required this.navMenuTheme,
    required this.codePreviewTheme,
    required this.closeButtonTheme,
    required this.tooltipTheme,
    required this.cardTheme,
    required this.progressTheme,
    required this.tagTheme,
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
    ElEventThemeData? eventTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElInputThemeData? inputTheme,
    ElSliderThemeData? sliderTheme,
    ElLinkThemeData? linkTheme,
    ElTextThemeData? textTheme,
    ElButtonThemeData? buttonTheme,
    ElIconThemeData? iconTheme,
    ElTabsThemeData? tabsTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElTooltipThemeData? tooltipTheme,
    ElCardThemeData? cardTheme,
    ElProgressThemeData? progressTheme,
    ElTagThemeData? tagTheme,
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
      eventTheme: this.eventTheme.merge(eventTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      textTheme: this.textTheme.merge(textTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
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
      eventTheme: other.eventTheme,
      asideTheme: other.asideTheme,
      headerTheme: other.headerTheme,
      inputTheme: other.inputTheme,
      sliderTheme: other.sliderTheme,
      linkTheme: other.linkTheme,
      textTheme: other.textTheme,
      buttonTheme: other.buttonTheme,
      iconTheme: other.iconTheme,
      tabsTheme: other.tabsTheme,
      navMenuTheme: other.navMenuTheme,
      codePreviewTheme: other.codePreviewTheme,
      closeButtonTheme: other.closeButtonTheme,
      tooltipTheme: other.tooltipTheme,
      cardTheme: other.cardTheme,
      progressTheme: other.progressTheme,
      tagTheme: other.tagTheme,
      collapseTheme: other.collapseTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
    );
  }
}
