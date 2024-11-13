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
    asideTheme: ElAsideThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    textTheme: ElTextThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    eventTheme: ElEventThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    tagTheme: ElTagThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    inputTheme: ElInputThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
  );

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 事件默认配置
  final ElEventThemeData eventTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

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

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

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
    required this.sliderTheme,
    required this.asideTheme,
    required this.headerTheme,
    required this.linkTheme,
    required this.textTheme,
    required this.buttonTheme,
    required this.iconTheme,
    required this.eventTheme,
    required this.tabsTheme,
    required this.navMenuTheme,
    required this.closeButtonTheme,
    required this.codePreviewTheme,
    required this.tooltipTheme,
    required this.toastTheme,
    required this.modalTheme,
    required this.messageTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.progressTheme,
    required this.tagTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.inputTheme,
    required this.sliderTheme,
    required this.asideTheme,
    required this.headerTheme,
    required this.linkTheme,
    required this.textTheme,
    required this.buttonTheme,
    required this.iconTheme,
    required this.eventTheme,
    required this.tabsTheme,
    required this.navMenuTheme,
    required this.closeButtonTheme,
    required this.codePreviewTheme,
    required this.tooltipTheme,
    required this.toastTheme,
    required this.modalTheme,
    required this.messageTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.progressTheme,
    required this.tagTheme,
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
    ElSliderThemeData? sliderTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElLinkThemeData? linkTheme,
    ElTextThemeData? textTheme,
    ElButtonThemeData? buttonTheme,
    ElIconThemeData? iconTheme,
    ElEventThemeData? eventTheme,
    ElTabsThemeData? tabsTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElTooltipThemeData? tooltipTheme,
    ElToastThemeData? toastTheme,
    ElModalThemeData? modalTheme,
    ElMessageThemeData? messageTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
    ElProgressThemeData? progressTheme,
    ElTagThemeData? tagTheme,
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
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      textTheme: this.textTheme.merge(textTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      eventTheme: this.eventTheme.merge(eventTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
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
      bgColor: other.bgColor,
      borderColor: other.borderColor,
      inputTheme: other.inputTheme,
      sliderTheme: other.sliderTheme,
      asideTheme: other.asideTheme,
      headerTheme: other.headerTheme,
      linkTheme: other.linkTheme,
      textTheme: other.textTheme,
      buttonTheme: other.buttonTheme,
      iconTheme: other.iconTheme,
      eventTheme: other.eventTheme,
      tabsTheme: other.tabsTheme,
      navMenuTheme: other.navMenuTheme,
      closeButtonTheme: other.closeButtonTheme,
      codePreviewTheme: other.codePreviewTheme,
      tooltipTheme: other.tooltipTheme,
      toastTheme: other.toastTheme,
      modalTheme: other.modalTheme,
      messageTheme: other.messageTheme,
      cardTheme: other.cardTheme,
      collapseTheme: other.collapseTheme,
      progressTheme: other.progressTheme,
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
