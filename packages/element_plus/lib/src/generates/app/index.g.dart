// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../app/index.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    linkTheme: ElLinkThemeData.theme,
    layoutTheme: ElLayoutThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    textTheme: ElTextThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    eventTheme: ElEventThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    linkTheme: ElLinkThemeData.darkTheme,
    layoutTheme: ElLayoutThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
  );

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 布局样式
  final ElLayoutThemeData layoutTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

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
    required this.linkTheme,
    required this.layoutTheme,
    required this.closeButtonTheme,
    required this.textTheme,
    required this.tooltipTheme,
    required this.inputTheme,
    required this.iconTheme,
    required this.codePreviewTheme,
    required this.navMenuTheme,
    required this.toastTheme,
    required this.sliderTheme,
    required this.tabsTheme,
    required this.messageTheme,
    required this.buttonTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.tagTheme,
    required this.progressTheme,
    required this.eventTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.linkTheme,
    required this.layoutTheme,
    required this.closeButtonTheme,
    required this.textTheme,
    required this.tooltipTheme,
    required this.inputTheme,
    required this.iconTheme,
    required this.codePreviewTheme,
    required this.navMenuTheme,
    required this.toastTheme,
    required this.sliderTheme,
    required this.tabsTheme,
    required this.messageTheme,
    required this.buttonTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
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
    ElLinkThemeData? linkTheme,
    ElLayoutThemeData? layoutTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElTextThemeData? textTheme,
    ElTooltipThemeData? tooltipTheme,
    ElInputThemeData? inputTheme,
    ElIconThemeData? iconTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElToastThemeData? toastTheme,
    ElSliderThemeData? sliderTheme,
    ElTabsThemeData? tabsTheme,
    ElMessageThemeData? messageTheme,
    ElButtonThemeData? buttonTheme,
    ElModalThemeData? modalTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
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
      linkTheme: this.linkTheme.merge(linkTheme),
      layoutTheme: this.layoutTheme.merge(layoutTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      textTheme: this.textTheme.merge(textTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
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
      linkTheme: other.linkTheme,
      layoutTheme: other.layoutTheme,
      closeButtonTheme: other.closeButtonTheme,
      textTheme: other.textTheme,
      tooltipTheme: other.tooltipTheme,
      inputTheme: other.inputTheme,
      iconTheme: other.iconTheme,
      codePreviewTheme: other.codePreviewTheme,
      navMenuTheme: other.navMenuTheme,
      toastTheme: other.toastTheme,
      sliderTheme: other.sliderTheme,
      tabsTheme: other.tabsTheme,
      messageTheme: other.messageTheme,
      buttonTheme: other.buttonTheme,
      modalTheme: other.modalTheme,
      cardTheme: other.cardTheme,
      collapseTheme: other.collapseTheme,
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
