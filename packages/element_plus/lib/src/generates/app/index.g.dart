// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../app/index.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    headerTheme: ElHeaderThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    textTheme: ElTextThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    eventTheme: ElEventThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    asideTheme: ElAsideThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    headerTheme: ElHeaderThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
  );

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 事件默认配置
  final ElEventThemeData eventTheme;

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

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 亮色主题构造器，构建器是私有的，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    super.bgColor,
    super.borderColor,
    required this.headerTheme,
    required this.linkTheme,
    required this.closeButtonTheme,
    required this.iconTheme,
    required this.textTheme,
    required this.inputTheme,
    required this.codePreviewTheme,
    required this.navMenuTheme,
    required this.tooltipTheme,
    required this.tabsTheme,
    required this.sliderTheme,
    required this.eventTheme,
    required this.buttonTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.tagTheme,
    required this.toastTheme,
    required this.messageTheme,
    required this.progressTheme,
    required this.asideTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.headerTheme,
    required this.linkTheme,
    required this.closeButtonTheme,
    required this.iconTheme,
    required this.textTheme,
    required this.inputTheme,
    required this.codePreviewTheme,
    required this.navMenuTheme,
    required this.tooltipTheme,
    required this.tabsTheme,
    required this.sliderTheme,
    required this.eventTheme,
    required this.buttonTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.tagTheme,
    required this.toastTheme,
    required this.messageTheme,
    required this.progressTheme,
    required this.asideTheme,
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
    ElHeaderThemeData? headerTheme,
    ElLinkThemeData? linkTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElIconThemeData? iconTheme,
    ElTextThemeData? textTheme,
    ElInputThemeData? inputTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElTooltipThemeData? tooltipTheme,
    ElTabsThemeData? tabsTheme,
    ElSliderThemeData? sliderTheme,
    ElEventThemeData? eventTheme,
    ElButtonThemeData? buttonTheme,
    ElModalThemeData? modalTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
    ElTagThemeData? tagTheme,
    ElToastThemeData? toastTheme,
    ElMessageThemeData? messageTheme,
    ElProgressThemeData? progressTheme,
    ElAsideThemeData? asideTheme,
  }) {
    return ElThemeData._(
      primary: primary ?? super.primary,
      success: success ?? super.success,
      info: info ?? super.info,
      warning: warning ?? super.warning,
      error: error ?? super.error,
      bgColor: bgColor ?? super.bgColor,
      borderColor: borderColor ?? super.borderColor,
      headerTheme: this.headerTheme.merge(headerTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      textTheme: this.textTheme.merge(textTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      eventTheme: this.eventTheme.merge(eventTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
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
      headerTheme: other.headerTheme,
      linkTheme: other.linkTheme,
      closeButtonTheme: other.closeButtonTheme,
      iconTheme: other.iconTheme,
      textTheme: other.textTheme,
      inputTheme: other.inputTheme,
      codePreviewTheme: other.codePreviewTheme,
      navMenuTheme: other.navMenuTheme,
      tooltipTheme: other.tooltipTheme,
      tabsTheme: other.tabsTheme,
      sliderTheme: other.sliderTheme,
      eventTheme: other.eventTheme,
      buttonTheme: other.buttonTheme,
      modalTheme: other.modalTheme,
      cardTheme: other.cardTheme,
      collapseTheme: other.collapseTheme,
      tagTheme: other.tagTheme,
      toastTheme: other.toastTheme,
      messageTheme: other.messageTheme,
      progressTheme: other.progressTheme,
      asideTheme: other.asideTheme,
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
