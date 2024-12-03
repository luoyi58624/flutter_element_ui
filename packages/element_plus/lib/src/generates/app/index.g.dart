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
    navMenuTheme: ElNavMenuThemeData.theme,
    eventTheme: ElEventThemeData.theme,
    splitTheme: ElSplitThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    ringTheme: ElRingThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    treeTheme: ElTreeThemeData.theme,
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
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
    splitTheme: ElSplitThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    ringTheme: ElRingThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    treeTheme: ElTreeThemeData.darkTheme,
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

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 事件默认配置
  final ElEventThemeData eventTheme;

  /// 分割器默认样式
  final ElSplitThemeData splitTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 轮廓环默认样式
  final ElRingThemeData ringTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// ElTree 主题数据
  final ElTreeThemeData treeTheme;

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
    required this.navMenuTheme,
    required this.eventTheme,
    required this.splitTheme,
    required this.closeButtonTheme,
    required this.ringTheme,
    required this.tooltipTheme,
    required this.toastTheme,
    required this.modalTheme,
    required this.messageTheme,
    required this.cardTheme,
    required this.treeTheme,
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
    required this.navMenuTheme,
    required this.eventTheme,
    required this.splitTheme,
    required this.closeButtonTheme,
    required this.ringTheme,
    required this.tooltipTheme,
    required this.toastTheme,
    required this.modalTheme,
    required this.messageTheme,
    required this.cardTheme,
    required this.treeTheme,
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
    ElNavMenuThemeData? navMenuTheme,
    ElEventThemeData? eventTheme,
    ElSplitThemeData? splitTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElRingThemeData? ringTheme,
    ElTooltipThemeData? tooltipTheme,
    ElToastThemeData? toastTheme,
    ElModalThemeData? modalTheme,
    ElMessageThemeData? messageTheme,
    ElCardThemeData? cardTheme,
    ElTreeThemeData? treeTheme,
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
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      eventTheme: this.eventTheme.merge(eventTheme),
      splitTheme: this.splitTheme.merge(splitTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      ringTheme: this.ringTheme.merge(ringTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      treeTheme: this.treeTheme.merge(treeTheme),
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
      navMenuTheme: other.navMenuTheme,
      eventTheme: other.eventTheme,
      splitTheme: other.splitTheme,
      closeButtonTheme: other.closeButtonTheme,
      ringTheme: other.ringTheme,
      tooltipTheme: other.tooltipTheme,
      toastTheme: other.toastTheme,
      modalTheme: other.modalTheme,
      messageTheme: other.messageTheme,
      cardTheme: other.cardTheme,
      treeTheme: other.treeTheme,
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

  /// 生成 equals 对象比较方法
  bool _equals(Object other) =>
      identical(this, other) ||
      other is ElConfigData &&
          runtimeType == other.runtimeType &&
          size == other.size &&
          radius == other.radius &&
          cardRadius == other.cardRadius &&
          borderWidth == other.borderWidth;

  /// 生成 hashCode 方法
  int get _hashCode =>
      size.hashCode ^
      radius.hashCode ^
      cardRadius.hashCode ^
      borderWidth.hashCode;
}
