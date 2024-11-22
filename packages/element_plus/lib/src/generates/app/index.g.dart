// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../app/index.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    layoutTheme: ElLayoutThemeData.theme,
    textTheme: ElTextThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    treeTheme: ElTreeThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    eventTheme: ElEventThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    layoutTheme: ElLayoutThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    treeTheme: ElTreeThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
  );

  /// 布局样式
  final ElLayoutThemeData layoutTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 标签默认样式
  final ElTreeThemeData treeTheme;

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
    required this.layoutTheme,
    required this.textTheme,
    required this.closeButtonTheme,
    required this.inputTheme,
    required this.iconTheme,
    required this.linkTheme,
    required this.codePreviewTheme,
    required this.tooltipTheme,
    required this.navMenuTheme,
    required this.toastTheme,
    required this.tabsTheme,
    required this.sliderTheme,
    required this.buttonTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.tagTheme,
    required this.treeTheme,
    required this.progressTheme,
    required this.eventTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.layoutTheme,
    required this.textTheme,
    required this.closeButtonTheme,
    required this.inputTheme,
    required this.iconTheme,
    required this.linkTheme,
    required this.codePreviewTheme,
    required this.tooltipTheme,
    required this.navMenuTheme,
    required this.toastTheme,
    required this.tabsTheme,
    required this.sliderTheme,
    required this.buttonTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.tagTheme,
    required this.treeTheme,
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
    ElLayoutThemeData? layoutTheme,
    ElTextThemeData? textTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElInputThemeData? inputTheme,
    ElIconThemeData? iconTheme,
    ElLinkThemeData? linkTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElTooltipThemeData? tooltipTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElToastThemeData? toastTheme,
    ElTabsThemeData? tabsTheme,
    ElSliderThemeData? sliderTheme,
    ElButtonThemeData? buttonTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
    ElTagThemeData? tagTheme,
    ElTreeThemeData? treeTheme,
    ElProgressThemeData? progressTheme,
    ElEventThemeData? eventTheme,
  }) {
    return ElThemeData._(
      primary: primary ?? super.primary,
      success: success ?? super.success,
      info: info ?? super.info,
      warning: warning ?? super.warning,
      error: error ?? super.error,
      layoutTheme: this.layoutTheme.merge(layoutTheme),
      textTheme: this.textTheme.merge(textTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      treeTheme: this.treeTheme.merge(treeTheme),
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
      layoutTheme: other.layoutTheme,
      textTheme: other.textTheme,
      closeButtonTheme: other.closeButtonTheme,
      inputTheme: other.inputTheme,
      iconTheme: other.iconTheme,
      linkTheme: other.linkTheme,
      codePreviewTheme: other.codePreviewTheme,
      tooltipTheme: other.tooltipTheme,
      navMenuTheme: other.navMenuTheme,
      toastTheme: other.toastTheme,
      tabsTheme: other.tabsTheme,
      sliderTheme: other.sliderTheme,
      buttonTheme: other.buttonTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      cardTheme: other.cardTheme,
      collapseTheme: other.collapseTheme,
      tagTheme: other.tagTheme,
      treeTheme: other.treeTheme,
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
    double? borderSize,
  }) {
    return ElConfigData(
      size: size ?? this.size,
      radius: radius ?? this.radius,
      borderSize: borderSize ?? this.borderSize,
    );
  }

  /// 接收一个对象，将它内部属性和原来对象进行 copy，然后返回新的对象
  ElConfigData merge([ElConfigData? other]) {
    if (other == null) return this;
    return copyWith(
      size: other.size,
      radius: other.radius,
      borderSize: other.borderSize,
    );
  }
}
