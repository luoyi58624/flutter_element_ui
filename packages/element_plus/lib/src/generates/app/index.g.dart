// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../app/index.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    linkTheme: ElLinkThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    textTheme: ElTextThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    eventTheme: ElEventThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    treeTheme: ElTreeThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    layoutTheme: ElLayoutThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    linkTheme: ElLinkThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    treeTheme: ElTreeThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    layoutTheme: ElLayoutThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
  );

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 事件默认配置
  final ElEventThemeData eventTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 标签默认样式
  final ElTreeThemeData treeTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 布局样式
  final ElLayoutThemeData layoutTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 亮色主题构造器，构建器是私有的，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    required this.linkTheme,
    required this.iconTheme,
    required this.buttonTheme,
    required this.textTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.eventTheme,
    required this.progressTheme,
    required this.tagTheme,
    required this.treeTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
    required this.tooltipTheme,
    required this.inputTheme,
    required this.layoutTheme,
    required this.sliderTheme,
    required this.navMenuTheme,
    required this.closeButtonTheme,
    required this.tabsTheme,
    required this.codePreviewTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.linkTheme,
    required this.iconTheme,
    required this.buttonTheme,
    required this.textTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.eventTheme,
    required this.progressTheme,
    required this.tagTheme,
    required this.treeTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
    required this.tooltipTheme,
    required this.inputTheme,
    required this.layoutTheme,
    required this.sliderTheme,
    required this.navMenuTheme,
    required this.closeButtonTheme,
    required this.tabsTheme,
    required this.codePreviewTheme,
  }) : super.dark();

  /// 接收一组可选参数，返回新的对象
  ElThemeData copyWith({
    Color? primary,
    Color? success,
    Color? info,
    Color? warning,
    Color? error,
    ElLinkThemeData? linkTheme,
    ElIconThemeData? iconTheme,
    ElButtonThemeData? buttonTheme,
    ElTextThemeData? textTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
    ElEventThemeData? eventTheme,
    ElProgressThemeData? progressTheme,
    ElTagThemeData? tagTheme,
    ElTreeThemeData? treeTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
    ElTooltipThemeData? tooltipTheme,
    ElInputThemeData? inputTheme,
    ElLayoutThemeData? layoutTheme,
    ElSliderThemeData? sliderTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElTabsThemeData? tabsTheme,
    ElCodePreviewThemeData? codePreviewTheme,
  }) {
    return ElThemeData._(
      primary: primary ?? super.primary,
      success: success ?? super.success,
      info: info ?? super.info,
      warning: warning ?? super.warning,
      error: error ?? super.error,
      linkTheme: this.linkTheme.merge(linkTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      textTheme: this.textTheme.merge(textTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      eventTheme: this.eventTheme.merge(eventTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      treeTheme: this.treeTheme.merge(treeTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      layoutTheme: this.layoutTheme.merge(layoutTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
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
      iconTheme: other.iconTheme,
      buttonTheme: other.buttonTheme,
      textTheme: other.textTheme,
      cardTheme: other.cardTheme,
      collapseTheme: other.collapseTheme,
      eventTheme: other.eventTheme,
      progressTheme: other.progressTheme,
      tagTheme: other.tagTheme,
      treeTheme: other.treeTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
      tooltipTheme: other.tooltipTheme,
      inputTheme: other.inputTheme,
      layoutTheme: other.layoutTheme,
      sliderTheme: other.sliderTheme,
      navMenuTheme: other.navMenuTheme,
      closeButtonTheme: other.closeButtonTheme,
      tabsTheme: other.tabsTheme,
      codePreviewTheme: other.codePreviewTheme,
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
