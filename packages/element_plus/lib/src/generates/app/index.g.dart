// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../app/index.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    linkTheme: ElLinkThemeData.theme,
    textTheme: ElTextThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    layoutTheme: ElLayoutThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    treeTheme: ElTreeThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    eventTheme: ElEventThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    ringTheme: ElRingThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    linkTheme: ElLinkThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    layoutTheme: ElLayoutThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    treeTheme: ElTreeThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    ringTheme: ElRingThemeData.darkTheme,
  );

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 布局样式
  final ElLayoutThemeData layoutTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// ElTree 主题数据
  final ElTreeThemeData treeTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 事件默认配置
  final ElEventThemeData eventTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 轮廓环默认样式
  final ElRingThemeData ringTheme;

  /// 亮色主题构造器，构建器是私有的，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    required this.linkTheme,
    required this.textTheme,
    required this.navMenuTheme,
    required this.inputTheme,
    required this.layoutTheme,
    required this.codePreviewTheme,
    required this.iconTheme,
    required this.tooltipTheme,
    required this.toastTheme,
    required this.tabsTheme,
    required this.sliderTheme,
    required this.messageTheme,
    required this.buttonTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.treeTheme,
    required this.collapseTheme,
    required this.tagTheme,
    required this.progressTheme,
    required this.eventTheme,
    required this.closeButtonTheme,
    required this.ringTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.linkTheme,
    required this.textTheme,
    required this.navMenuTheme,
    required this.inputTheme,
    required this.layoutTheme,
    required this.codePreviewTheme,
    required this.iconTheme,
    required this.tooltipTheme,
    required this.toastTheme,
    required this.tabsTheme,
    required this.sliderTheme,
    required this.messageTheme,
    required this.buttonTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.treeTheme,
    required this.collapseTheme,
    required this.tagTheme,
    required this.progressTheme,
    required this.eventTheme,
    required this.closeButtonTheme,
    required this.ringTheme,
  }) : super.dark();

  /// 接收一组可选参数，返回新的对象
  ElThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    ElLinkThemeData? linkTheme,
    ElTextThemeData? textTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElInputThemeData? inputTheme,
    ElLayoutThemeData? layoutTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElIconThemeData? iconTheme,
    ElTooltipThemeData? tooltipTheme,
    ElToastThemeData? toastTheme,
    ElTabsThemeData? tabsTheme,
    ElSliderThemeData? sliderTheme,
    ElMessageThemeData? messageTheme,
    ElButtonThemeData? buttonTheme,
    ElModalThemeData? modalTheme,
    ElCardThemeData? cardTheme,
    ElTreeThemeData? treeTheme,
    ElCollapseThemeData? collapseTheme,
    ElTagThemeData? tagTheme,
    ElProgressThemeData? progressTheme,
    ElEventThemeData? eventTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElRingThemeData? ringTheme,
  }) {
    return ElThemeData._(
      primary: primary ?? super.primary,
      success: success ?? super.success,
      info: info ?? super.info,
      warning: warning ?? super.warning,
      error: error ?? super.error,
      linkTheme: this.linkTheme.merge(linkTheme),
      textTheme: this.textTheme.merge(textTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      layoutTheme: this.layoutTheme.merge(layoutTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      treeTheme: this.treeTheme.merge(treeTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      eventTheme: this.eventTheme.merge(eventTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      ringTheme: this.ringTheme.merge(ringTheme),
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
      linkTheme: other.linkTheme,
      textTheme: other.textTheme,
      navMenuTheme: other.navMenuTheme,
      inputTheme: other.inputTheme,
      layoutTheme: other.layoutTheme,
      codePreviewTheme: other.codePreviewTheme,
      iconTheme: other.iconTheme,
      tooltipTheme: other.tooltipTheme,
      toastTheme: other.toastTheme,
      tabsTheme: other.tabsTheme,
      sliderTheme: other.sliderTheme,
      messageTheme: other.messageTheme,
      buttonTheme: other.buttonTheme,
      modalTheme: other.modalTheme,
      cardTheme: other.cardTheme,
      treeTheme: other.treeTheme,
      collapseTheme: other.collapseTheme,
      tagTheme: other.tagTheme,
      progressTheme: other.progressTheme,
      eventTheme: other.eventTheme,
      closeButtonTheme: other.closeButtonTheme,
      ringTheme: other.ringTheme,
    );
  }
}

// **************************************************************************
// ElModelGenerator
// **************************************************************************

extension ElConfigDataExtension on ElConfigData {
  /// 接收一组可选参数，返回新的对象
  ElConfigData copyWith({
    double? size,
    BorderRadius? radius,
    BorderRadius? cardRadius,
    double? borderWidth,
  }) {
    return ElConfigData(
      size: size ?? this.size,
      radius: radius ?? this.radius,
      cardRadius: cardRadius ?? this.cardRadius,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElConfigData merge([ElConfigData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
      radius: other.radius,
      cardRadius: other.cardRadius,
      borderWidth: other.borderWidth,
    );
  }
}
