// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    asideTheme: ElAsideThemeData.theme,
    textTheme: ElTextThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    tabTheme: ElTabThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    toastTheme: ElToastThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    asideTheme: ElAsideThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    tabTheme: ElTabThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
  );

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 标签容器子标签默认样式
  final ElTabThemeData tabTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

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
    required this.asideTheme,
    required this.textTheme,
    required this.sliderTheme,
    required this.headerTheme,
    required this.inputTheme,
    required this.tooltipTheme,
    required this.tabTheme,
    required this.closeButtonTheme,
    required this.navMenuTheme,
    required this.cardTheme,
    required this.buttonTheme,
    required this.iconTheme,
    required this.linkTheme,
    required this.tabsTheme,
    required this.codePreviewTheme,
    required this.tagTheme,
    required this.collapseTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
    required this.progressTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.asideTheme,
    required this.textTheme,
    required this.sliderTheme,
    required this.headerTheme,
    required this.inputTheme,
    required this.tooltipTheme,
    required this.tabTheme,
    required this.closeButtonTheme,
    required this.navMenuTheme,
    required this.cardTheme,
    required this.buttonTheme,
    required this.iconTheme,
    required this.linkTheme,
    required this.tabsTheme,
    required this.codePreviewTheme,
    required this.tagTheme,
    required this.collapseTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
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
    ElAsideThemeData? asideTheme,
    ElTextThemeData? textTheme,
    ElSliderThemeData? sliderTheme,
    ElHeaderThemeData? headerTheme,
    ElInputThemeData? inputTheme,
    ElTooltipThemeData? tooltipTheme,
    ElTabThemeData? tabTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCardThemeData? cardTheme,
    ElButtonThemeData? buttonTheme,
    ElIconThemeData? iconTheme,
    ElLinkThemeData? linkTheme,
    ElTabsThemeData? tabsTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElTagThemeData? tagTheme,
    ElCollapseThemeData? collapseTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
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
      asideTheme: this.asideTheme.merge(asideTheme),
      textTheme: this.textTheme.merge(textTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
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
      asideTheme: other.asideTheme,
      textTheme: other.textTheme,
      sliderTheme: other.sliderTheme,
      headerTheme: other.headerTheme,
      inputTheme: other.inputTheme,
      tooltipTheme: other.tooltipTheme,
      tabTheme: other.tabTheme,
      closeButtonTheme: other.closeButtonTheme,
      navMenuTheme: other.navMenuTheme,
      cardTheme: other.cardTheme,
      buttonTheme: other.buttonTheme,
      iconTheme: other.iconTheme,
      linkTheme: other.linkTheme,
      tabsTheme: other.tabsTheme,
      codePreviewTheme: other.codePreviewTheme,
      tagTheme: other.tagTheme,
      collapseTheme: other.collapseTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
      progressTheme: other.progressTheme,
    );
  }
}

class ElTheme extends InheritedWidget {
  /// 为后代提供默认数据小部件
  const ElTheme({super.key, required super.child, required this.data});

  /// 主题数据
  final ElThemeData data;

  /// 通过上下文访问默认的主题数据
  static ElThemeData of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElTheme>()!.data;

  @override
  bool updateShouldNotify(ElTheme oldWidget) => true;
}

class ElAnimatedTheme extends ImplicitlyAnimatedWidget {
  /// 提供动画默认数据小部件
  const ElAnimatedTheme({
    super.key,
    required this.data,
    super.curve,
    super.duration = kThemeAnimationDuration,
    super.onEnd,
    required this.child,
  });

  final ElThemeData data;
  final Widget child;

  @override
  AnimatedWidgetBaseState<ElAnimatedTheme> createState() => _ElThemeDataState();
}

class _ElThemeDataState extends AnimatedWidgetBaseState<ElAnimatedTheme> {
  _ElThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(_data, widget.data,
            (dynamic value) => _ElThemeDataTween(begin: value as ElThemeData))!
        as _ElThemeDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return ElTheme(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}

class _ElThemeDataTween extends Tween<ElThemeData> {
  _ElThemeDataTween({super.begin});

  @override
  ElThemeData lerp(double t) => _lerp(begin!, end!, t);

  static ElThemeData _lerp(ElThemeData a, ElThemeData b, double t) {
    if (identical(a, b)) {
      return a;
    }

    return ElThemeData._(
      primary: Color.lerp(a.primary, b.primary, t) ?? a.primary,
      success: Color.lerp(a.success, b.success, t) ?? a.success,
      info: Color.lerp(a.info, b.info, t) ?? a.info,
      warning: Color.lerp(a.warning, b.warning, t) ?? a.warning,
      error: Color.lerp(a.error, b.error, t) ?? a.error,
      bgColor: Color.lerp(a.bgColor, b.bgColor, t) ?? a.bgColor,
      borderColor: Color.lerp(a.borderColor, b.borderColor, t) ?? a.borderColor,
      asideTheme: ElAsideThemeData.theme.lerp(a.asideTheme, b.asideTheme, t),
      textTheme: ElTextThemeData.theme.lerp(a.textTheme, b.textTheme, t),
      sliderTheme:
          ElSliderThemeData.theme.lerp(a.sliderTheme, b.sliderTheme, t),
      headerTheme:
          ElHeaderThemeData.theme.lerp(a.headerTheme, b.headerTheme, t),
      inputTheme: ElInputThemeData.theme.lerp(a.inputTheme, b.inputTheme, t),
      tooltipTheme:
          ElTooltipThemeData.theme.lerp(a.tooltipTheme, b.tooltipTheme, t),
      tabTheme: ElTabThemeData.theme.lerp(a.tabTheme, b.tabTheme, t),
      closeButtonTheme: ElCloseButtonThemeData.theme
          .lerp(a.closeButtonTheme, b.closeButtonTheme, t),
      navMenuTheme:
          ElNavMenuThemeData.theme.lerp(a.navMenuTheme, b.navMenuTheme, t),
      cardTheme: ElCardThemeData.theme.lerp(a.cardTheme, b.cardTheme, t),
      buttonTheme:
          ElButtonThemeData.theme.lerp(a.buttonTheme, b.buttonTheme, t),
      iconTheme: ElIconThemeData.theme.lerp(a.iconTheme, b.iconTheme, t),
      linkTheme: ElLinkThemeData.theme.lerp(a.linkTheme, b.linkTheme, t),
      tabsTheme: ElTabsThemeData.theme.lerp(a.tabsTheme, b.tabsTheme, t),
      codePreviewTheme: ElCodePreviewThemeData.theme
          .lerp(a.codePreviewTheme, b.codePreviewTheme, t),
      tagTheme: ElTagThemeData.theme.lerp(a.tagTheme, b.tagTheme, t),
      collapseTheme:
          ElCollapseThemeData.theme.lerp(a.collapseTheme, b.collapseTheme, t),
      messageTheme:
          ElMessageThemeData.theme.lerp(a.messageTheme, b.messageTheme, t),
      modalTheme: ElModalThemeData.theme.lerp(a.modalTheme, b.modalTheme, t),
      toastTheme: ElToastThemeData.theme.lerp(a.toastTheme, b.toastTheme, t),
      progressTheme:
          ElProgressThemeData.theme.lerp(a.progressTheme, b.progressTheme, t),
    );
  }
}
