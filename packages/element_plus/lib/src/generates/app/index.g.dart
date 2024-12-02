// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../app/index.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    inputTheme: ElInputThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    layoutTheme: ElLayoutThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    textTheme: ElTextThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    eventTheme: ElEventThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    ringTheme: ElRingThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    treeTheme: ElTreeThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    tagTheme: ElTagThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    inputTheme: ElInputThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    layoutTheme: ElLayoutThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    ringTheme: ElRingThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    treeTheme: ElTreeThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
  );

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 布局样式
  final ElLayoutThemeData layoutTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 事件默认配置
  final ElEventThemeData eventTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 轮廓环默认样式
  final ElRingThemeData ringTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// ElTree 主题数据
  final ElTreeThemeData treeTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 亮色主题构造器，构建器是私有的，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    required this.inputTheme,
    required this.sliderTheme,
    required this.layoutTheme,
    required this.linkTheme,
    required this.textTheme,
    required this.iconTheme,
    required this.buttonTheme,
    required this.tabsTheme,
    required this.eventTheme,
    required this.navMenuTheme,
    required this.closeButtonTheme,
    required this.ringTheme,
    required this.tooltipTheme,
    required this.toastTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.treeTheme,
    required this.cardTheme,
    required this.progressTheme,
    required this.collapseTheme,
    required this.tagTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.inputTheme,
    required this.sliderTheme,
    required this.layoutTheme,
    required this.linkTheme,
    required this.textTheme,
    required this.iconTheme,
    required this.buttonTheme,
    required this.tabsTheme,
    required this.eventTheme,
    required this.navMenuTheme,
    required this.closeButtonTheme,
    required this.ringTheme,
    required this.tooltipTheme,
    required this.toastTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.treeTheme,
    required this.cardTheme,
    required this.progressTheme,
    required this.collapseTheme,
    required this.tagTheme,
  }) : super.dark();

  /// 接收一组可选参数，返回新的对象
  ElThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    ElInputThemeData? inputTheme,
    ElSliderThemeData? sliderTheme,
    ElLayoutThemeData? layoutTheme,
    ElLinkThemeData? linkTheme,
    ElTextThemeData? textTheme,
    ElIconThemeData? iconTheme,
    ElButtonThemeData? buttonTheme,
    ElTabsThemeData? tabsTheme,
    ElEventThemeData? eventTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElRingThemeData? ringTheme,
    ElTooltipThemeData? tooltipTheme,
    ElToastThemeData? toastTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElTreeThemeData? treeTheme,
    ElCardThemeData? cardTheme,
    ElProgressThemeData? progressTheme,
    ElCollapseThemeData? collapseTheme,
    ElTagThemeData? tagTheme,
  }) {
    return ElThemeData._(
      primary: primary ?? super.primary,
      success: success ?? super.success,
      info: info ?? super.info,
      warning: warning ?? super.warning,
      error: error ?? super.error,
      inputTheme: this.inputTheme.merge(inputTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      layoutTheme: this.layoutTheme.merge(layoutTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      textTheme: this.textTheme.merge(textTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      eventTheme: this.eventTheme.merge(eventTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      ringTheme: this.ringTheme.merge(ringTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      treeTheme: this.treeTheme.merge(treeTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
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
      inputTheme: other.inputTheme,
      sliderTheme: other.sliderTheme,
      layoutTheme: other.layoutTheme,
      linkTheme: other.linkTheme,
      textTheme: other.textTheme,
      iconTheme: other.iconTheme,
      buttonTheme: other.buttonTheme,
      tabsTheme: other.tabsTheme,
      eventTheme: other.eventTheme,
      navMenuTheme: other.navMenuTheme,
      closeButtonTheme: other.closeButtonTheme,
      ringTheme: other.ringTheme,
      tooltipTheme: other.tooltipTheme,
      toastTheme: other.toastTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      treeTheme: other.treeTheme,
      cardTheme: other.cardTheme,
      progressTheme: other.progressTheme,
      collapseTheme: other.collapseTheme,
      tagTheme: other.tagTheme,
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
