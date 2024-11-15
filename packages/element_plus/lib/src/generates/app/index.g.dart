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
    asideTheme: ElAsideThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    textTheme: ElTextThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    eventTheme: ElEventThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    headerTheme: ElHeaderThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    eventTheme: ElEventThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
  );

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

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

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 事件默认配置
  final ElEventThemeData eventTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

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
    required this.headerTheme,
    required this.linkTheme,
    required this.closeButtonTheme,
    required this.asideTheme,
    required this.iconTheme,
    required this.textTheme,
    required this.inputTheme,
    required this.codePreviewTheme,
    required this.navMenuTheme,
    required this.tabsTheme,
    required this.sliderTheme,
    required this.tooltipTheme,
    required this.eventTheme,
    required this.buttonTheme,
    required this.toastTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.tagTheme,
    required this.messageTheme,
    required this.progressTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.headerTheme,
    required this.linkTheme,
    required this.closeButtonTheme,
    required this.asideTheme,
    required this.iconTheme,
    required this.textTheme,
    required this.inputTheme,
    required this.codePreviewTheme,
    required this.navMenuTheme,
    required this.tabsTheme,
    required this.sliderTheme,
    required this.tooltipTheme,
    required this.eventTheme,
    required this.buttonTheme,
    required this.toastTheme,
    required this.modalTheme,
    required this.cardTheme,
    required this.collapseTheme,
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
    ElHeaderThemeData? headerTheme,
    ElLinkThemeData? linkTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElAsideThemeData? asideTheme,
    ElIconThemeData? iconTheme,
    ElTextThemeData? textTheme,
    ElInputThemeData? inputTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElTabsThemeData? tabsTheme,
    ElSliderThemeData? sliderTheme,
    ElTooltipThemeData? tooltipTheme,
    ElEventThemeData? eventTheme,
    ElButtonThemeData? buttonTheme,
    ElToastThemeData? toastTheme,
    ElModalThemeData? modalTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
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
      headerTheme: this.headerTheme.merge(headerTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      textTheme: this.textTheme.merge(textTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      eventTheme: this.eventTheme.merge(eventTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
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
      headerTheme: other.headerTheme,
      linkTheme: other.linkTheme,
      closeButtonTheme: other.closeButtonTheme,
      asideTheme: other.asideTheme,
      iconTheme: other.iconTheme,
      textTheme: other.textTheme,
      inputTheme: other.inputTheme,
      codePreviewTheme: other.codePreviewTheme,
      navMenuTheme: other.navMenuTheme,
      tabsTheme: other.tabsTheme,
      sliderTheme: other.sliderTheme,
      tooltipTheme: other.tooltipTheme,
      eventTheme: other.eventTheme,
      buttonTheme: other.buttonTheme,
      toastTheme: other.toastTheme,
      modalTheme: other.modalTheme,
      cardTheme: other.cardTheme,
      collapseTheme: other.collapseTheme,
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
