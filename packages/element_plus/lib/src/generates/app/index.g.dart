// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../app/index.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    closeButtonTheme: ElCloseButtonThemeData.theme,
    textTheme: ElTextThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    layoutTheme: ElLayoutThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    ringTheme: ElRingThemeData.theme,
    treeTheme: ElTreeThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    eventTheme: ElEventThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    layoutTheme: ElLayoutThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    ringTheme: ElRingThemeData.darkTheme,
    treeTheme: ElTreeThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
  );

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 布局样式
  final ElLayoutThemeData layoutTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 轮廓环默认样式
  final ElRingThemeData ringTheme;

  /// ElTree 主题数据
  final ElTreeThemeData treeTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 事件默认配置
  final ElEventThemeData eventTheme;

  /// 亮色主题构造器，构建器是私有的，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    required this.closeButtonTheme,
    required this.textTheme,
    required this.navMenuTheme,
    required this.iconTheme,
    required this.layoutTheme,
    required this.linkTheme,
    required this.inputTheme,
    required this.codePreviewTheme,
    required this.tooltipTheme,
    required this.toastTheme,
    required this.sliderTheme,
    required this.tabsTheme,
    required this.messageTheme,
    required this.buttonTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.ringTheme,
    required this.treeTheme,
    required this.tagTheme,
    required this.progressTheme,
    required this.eventTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.closeButtonTheme,
    required this.textTheme,
    required this.navMenuTheme,
    required this.iconTheme,
    required this.layoutTheme,
    required this.linkTheme,
    required this.inputTheme,
    required this.codePreviewTheme,
    required this.tooltipTheme,
    required this.toastTheme,
    required this.sliderTheme,
    required this.tabsTheme,
    required this.messageTheme,
    required this.buttonTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.ringTheme,
    required this.treeTheme,
    required this.tagTheme,
    required this.progressTheme,
    required this.eventTheme,
  }) : super.dark();

  /// 接收一组可选参数，返回新的对象
  ElThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    ElCloseButtonThemeData? closeButtonTheme,
    ElTextThemeData? textTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElIconThemeData? iconTheme,
    ElLayoutThemeData? layoutTheme,
    ElLinkThemeData? linkTheme,
    ElInputThemeData? inputTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElTooltipThemeData? tooltipTheme,
    ElToastThemeData? toastTheme,
    ElSliderThemeData? sliderTheme,
    ElTabsThemeData? tabsTheme,
    ElMessageThemeData? messageTheme,
    ElButtonThemeData? buttonTheme,
    ElModalThemeData? modalTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
    ElRingThemeData? ringTheme,
    ElTreeThemeData? treeTheme,
    ElTagThemeData? tagTheme,
    ElProgressThemeData? progressTheme,
    ElEventThemeData? eventTheme,
  }) {
    return ElThemeData._(
      primary: primary ?? super.primary,
      success: success ?? super.success,
      info: info ?? super.info,
      warning: warning ?? super.warning,
      error: error ?? super.error,
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      textTheme: this.textTheme.merge(textTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      layoutTheme: this.layoutTheme.merge(layoutTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      ringTheme: this.ringTheme.merge(ringTheme),
      treeTheme: this.treeTheme.merge(treeTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      eventTheme: this.eventTheme.merge(eventTheme),
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
      closeButtonTheme: other.closeButtonTheme,
      textTheme: other.textTheme,
      navMenuTheme: other.navMenuTheme,
      iconTheme: other.iconTheme,
      layoutTheme: other.layoutTheme,
      linkTheme: other.linkTheme,
      inputTheme: other.inputTheme,
      codePreviewTheme: other.codePreviewTheme,
      tooltipTheme: other.tooltipTheme,
      toastTheme: other.toastTheme,
      sliderTheme: other.sliderTheme,
      tabsTheme: other.tabsTheme,
      messageTheme: other.messageTheme,
      buttonTheme: other.buttonTheme,
      modalTheme: other.modalTheme,
      cardTheme: other.cardTheme,
      collapseTheme: other.collapseTheme,
      ringTheme: other.ringTheme,
      treeTheme: other.treeTheme,
      tagTheme: other.tagTheme,
      progressTheme: other.progressTheme,
      eventTheme: other.eventTheme,
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
