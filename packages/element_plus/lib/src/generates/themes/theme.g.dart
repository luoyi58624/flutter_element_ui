// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    asideTheme: ElAsideThemeData.theme,
    buttonTheme: ElButtonThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    tabTheme: ElTabThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    textTheme: ElTextThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    toastTheme: ElToastThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    asideTheme: ElAsideThemeData.darkTheme,
    buttonTheme: ElButtonThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    tabTheme: ElTabThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
  );

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 标签容器子标签默认样式
  final ElTabThemeData tabTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

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
    required this.buttonTheme,
    required this.linkTheme,
    required this.headerTheme,
    required this.tabsTheme,
    required this.tabTheme,
    required this.iconTheme,
    required this.navMenuTheme,
    required this.tooltipTheme,
    required this.sliderTheme,
    required this.closeButtonTheme,
    required this.codePreviewTheme,
    required this.progressTheme,
    required this.inputTheme,
    required this.textTheme,
    required this.cardTheme,
    required this.tagTheme,
    required this.collapseTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.asideTheme,
    required this.buttonTheme,
    required this.linkTheme,
    required this.headerTheme,
    required this.tabsTheme,
    required this.tabTheme,
    required this.iconTheme,
    required this.navMenuTheme,
    required this.tooltipTheme,
    required this.sliderTheme,
    required this.closeButtonTheme,
    required this.codePreviewTheme,
    required this.progressTheme,
    required this.inputTheme,
    required this.textTheme,
    required this.cardTheme,
    required this.tagTheme,
    required this.collapseTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
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
    ElButtonThemeData? buttonTheme,
    ElLinkThemeData? linkTheme,
    ElHeaderThemeData? headerTheme,
    ElTabsThemeData? tabsTheme,
    ElTabThemeData? tabTheme,
    ElIconThemeData? iconTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElTooltipThemeData? tooltipTheme,
    ElSliderThemeData? sliderTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElProgressThemeData? progressTheme,
    ElInputThemeData? inputTheme,
    ElTextThemeData? textTheme,
    ElCardThemeData? cardTheme,
    ElTagThemeData? tagTheme,
    ElCollapseThemeData? collapseTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
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
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      textTheme: this.textTheme.merge(textTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      messageTheme: this.messageTheme.merge(messageTheme),
      modalTheme: this.modalTheme.merge(modalTheme),
      toastTheme: this.toastTheme.merge(toastTheme),
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
      buttonTheme: other.buttonTheme,
      linkTheme: other.linkTheme,
      headerTheme: other.headerTheme,
      tabsTheme: other.tabsTheme,
      tabTheme: other.tabTheme,
      iconTheme: other.iconTheme,
      navMenuTheme: other.navMenuTheme,
      tooltipTheme: other.tooltipTheme,
      sliderTheme: other.sliderTheme,
      closeButtonTheme: other.closeButtonTheme,
      codePreviewTheme: other.codePreviewTheme,
      progressTheme: other.progressTheme,
      inputTheme: other.inputTheme,
      textTheme: other.textTheme,
      cardTheme: other.cardTheme,
      tagTheme: other.tagTheme,
      collapseTheme: other.collapseTheme,
      messageTheme: other.messageTheme,
      modalTheme: other.modalTheme,
      toastTheme: other.toastTheme,
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
      buttonTheme:
          ElButtonThemeData.theme.lerp(a.buttonTheme, b.buttonTheme, t),
      linkTheme: ElLinkThemeData.theme.lerp(a.linkTheme, b.linkTheme, t),
      headerTheme:
          ElHeaderThemeData.theme.lerp(a.headerTheme, b.headerTheme, t),
      tabsTheme: ElTabsThemeData.theme.lerp(a.tabsTheme, b.tabsTheme, t),
      tabTheme: ElTabThemeData.theme.lerp(a.tabTheme, b.tabTheme, t),
      iconTheme: ElIconThemeData.theme.lerp(a.iconTheme, b.iconTheme, t),
      navMenuTheme:
          ElNavMenuThemeData.theme.lerp(a.navMenuTheme, b.navMenuTheme, t),
      tooltipTheme:
          ElTooltipThemeData.theme.lerp(a.tooltipTheme, b.tooltipTheme, t),
      sliderTheme:
          ElSliderThemeData.theme.lerp(a.sliderTheme, b.sliderTheme, t),
      closeButtonTheme: ElCloseButtonThemeData.theme
          .lerp(a.closeButtonTheme, b.closeButtonTheme, t),
      codePreviewTheme: ElCodePreviewThemeData.theme
          .lerp(a.codePreviewTheme, b.codePreviewTheme, t),
      progressTheme:
          ElProgressThemeData.theme.lerp(a.progressTheme, b.progressTheme, t),
      inputTheme: ElInputThemeData.theme.lerp(a.inputTheme, b.inputTheme, t),
      textTheme: ElTextThemeData.theme.lerp(a.textTheme, b.textTheme, t),
      cardTheme: ElCardThemeData.theme.lerp(a.cardTheme, b.cardTheme, t),
      tagTheme: ElTagThemeData.theme.lerp(a.tagTheme, b.tagTheme, t),
      collapseTheme:
          ElCollapseThemeData.theme.lerp(a.collapseTheme, b.collapseTheme, t),
      messageTheme:
          ElMessageThemeData.theme.lerp(a.messageTheme, b.messageTheme, t),
      modalTheme: ElModalThemeData.theme.lerp(a.modalTheme, b.modalTheme, t),
      toastTheme: ElToastThemeData.theme.lerp(a.toastTheme, b.toastTheme, t),
    );
  }
}
