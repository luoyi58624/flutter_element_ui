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
    inputTheme: ElInputThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    asideTheme: ElAsideThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    eventTheme: ElEventThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    linkTheme: ElLinkThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
  );

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 事件默认配置
  final ElEventThemeData eventTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 亮色主题构造器，构建器是私有的，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    super.bgColor,
    super.borderColor,
    required this.linkTheme,
    required this.textTheme,
    required this.inputTheme,
    required this.iconTheme,
    required this.closeButtonTheme,
    required this.asideTheme,
    required this.headerTheme,
    required this.codePreviewTheme,
    required this.tabsTheme,
    required this.navMenuTheme,
    required this.eventTheme,
    required this.sliderTheme,
    required this.buttonTheme,
    required this.tooltipTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.toastTheme,
    required this.tagTheme,
    required this.messageTheme,
    required this.progressTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.linkTheme,
    required this.textTheme,
    required this.inputTheme,
    required this.iconTheme,
    required this.closeButtonTheme,
    required this.asideTheme,
    required this.headerTheme,
    required this.codePreviewTheme,
    required this.tabsTheme,
    required this.navMenuTheme,
    required this.eventTheme,
    required this.sliderTheme,
    required this.buttonTheme,
    required this.tooltipTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.toastTheme,
    required this.tagTheme,
    required this.messageTheme,
    required this.progressTheme,
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
    ElLinkThemeData? linkTheme,
    ElTextThemeData? textTheme,
    ElInputThemeData? inputTheme,
    ElIconThemeData? iconTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElTabsThemeData? tabsTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElEventThemeData? eventTheme,
    ElSliderThemeData? sliderTheme,
    ElButtonThemeData? buttonTheme,
    ElTooltipThemeData? tooltipTheme,
    ElModalThemeData? modalTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
    ElToastThemeData? toastTheme,
    ElTagThemeData? tagTheme,
    ElMessageThemeData? messageTheme,
    ElProgressThemeData? progressTheme,
  }) {
    return ElThemeData._(
      primary: primary ?? super.primary,
      success: success ?? super.success,
      info: info ?? super.info,
      warning: warning ?? super.warning,
      error: error ?? super.error,
      bgColor: bgColor ?? super.bgColor,
      borderColor: borderColor ?? super.borderColor,
      linkTheme: this.linkTheme.merge(linkTheme),
      textTheme: this.textTheme.merge(textTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      eventTheme: this.eventTheme.merge(eventTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
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
      linkTheme: other.linkTheme,
      textTheme: other.textTheme,
      inputTheme: other.inputTheme,
      iconTheme: other.iconTheme,
      closeButtonTheme: other.closeButtonTheme,
      asideTheme: other.asideTheme,
      headerTheme: other.headerTheme,
      codePreviewTheme: other.codePreviewTheme,
      tabsTheme: other.tabsTheme,
      navMenuTheme: other.navMenuTheme,
      eventTheme: other.eventTheme,
      sliderTheme: other.sliderTheme,
      buttonTheme: other.buttonTheme,
      tooltipTheme: other.tooltipTheme,
      modalTheme: other.modalTheme,
      cardTheme: other.cardTheme,
      collapseTheme: other.collapseTheme,
      toastTheme: other.toastTheme,
      tagTheme: other.tagTheme,
      messageTheme: other.messageTheme,
      progressTheme: other.progressTheme,
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
