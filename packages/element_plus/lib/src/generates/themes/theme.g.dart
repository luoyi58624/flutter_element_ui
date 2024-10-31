// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData._(
    buttonTheme: ElButtonThemeData.theme,
    textTheme: ElTextThemeData.theme,
    linkTheme: ElLinkThemeData.theme,
    progressTheme: ElProgressThemeData.theme,
    iconTheme: ElIconThemeData.theme,
    inputTheme: ElInputThemeData.theme,
    cardTheme: ElCardThemeData.theme,
    collapseTheme: ElCollapseThemeData.theme,
    tagTheme: ElTagThemeData.theme,
    tooltipTheme: ElTooltipThemeData.theme,
    closeButtonTheme: ElCloseButtonThemeData.theme,
    sliderTheme: ElSliderThemeData.theme,
    tabsTheme: ElTabsThemeData.theme,
    navMenuTheme: ElNavMenuThemeData.theme,
    codePreviewTheme: ElCodePreviewThemeData.theme,
    asideTheme: ElAsideThemeData.theme,
    headerTheme: ElHeaderThemeData.theme,
    messageTheme: ElMessageThemeData.theme,
    modalTheme: ElModalThemeData.theme,
    toastTheme: ElToastThemeData.theme,
  );

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData._dark(
    buttonTheme: ElButtonThemeData.darkTheme,
    textTheme: ElTextThemeData.darkTheme,
    linkTheme: ElLinkThemeData.darkTheme,
    progressTheme: ElProgressThemeData.darkTheme,
    iconTheme: ElIconThemeData.darkTheme,
    inputTheme: ElInputThemeData.darkTheme,
    cardTheme: ElCardThemeData.darkTheme,
    collapseTheme: ElCollapseThemeData.darkTheme,
    tagTheme: ElTagThemeData.darkTheme,
    tooltipTheme: ElTooltipThemeData.darkTheme,
    closeButtonTheme: ElCloseButtonThemeData.darkTheme,
    sliderTheme: ElSliderThemeData.darkTheme,
    tabsTheme: ElTabsThemeData.darkTheme,
    navMenuTheme: ElNavMenuThemeData.darkTheme,
    codePreviewTheme: ElCodePreviewThemeData.darkTheme,
    asideTheme: ElAsideThemeData.darkTheme,
    headerTheme: ElHeaderThemeData.darkTheme,
    messageTheme: ElMessageThemeData.darkTheme,
    modalTheme: ElModalThemeData.darkTheme,
    toastTheme: ElToastThemeData.darkTheme,
  );

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 关闭按钮默认样式
  final ElCloseButtonThemeData closeButtonTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

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
    required this.buttonTheme,
    required this.textTheme,
    required this.linkTheme,
    required this.progressTheme,
    required this.iconTheme,
    required this.inputTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.tagTheme,
    required this.tooltipTheme,
    required this.closeButtonTheme,
    required this.sliderTheme,
    required this.tabsTheme,
    required this.navMenuTheme,
    required this.codePreviewTheme,
    required this.asideTheme,
    required this.headerTheme,
    required this.messageTheme,
    required this.modalTheme,
    required this.toastTheme,
  });

  /// 暗色主题构造器，构建器是私有的，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData._dark({
    required this.buttonTheme,
    required this.textTheme,
    required this.linkTheme,
    required this.progressTheme,
    required this.iconTheme,
    required this.inputTheme,
    required this.cardTheme,
    required this.collapseTheme,
    required this.tagTheme,
    required this.tooltipTheme,
    required this.closeButtonTheme,
    required this.sliderTheme,
    required this.tabsTheme,
    required this.navMenuTheme,
    required this.codePreviewTheme,
    required this.asideTheme,
    required this.headerTheme,
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
    ElButtonThemeData? buttonTheme,
    ElTextThemeData? textTheme,
    ElLinkThemeData? linkTheme,
    ElProgressThemeData? progressTheme,
    ElIconThemeData? iconTheme,
    ElInputThemeData? inputTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
    ElTagThemeData? tagTheme,
    ElTooltipThemeData? tooltipTheme,
    ElCloseButtonThemeData? closeButtonTheme,
    ElSliderThemeData? sliderTheme,
    ElTabsThemeData? tabsTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
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
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      textTheme: this.textTheme.merge(textTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      closeButtonTheme: this.closeButtonTheme.merge(closeButtonTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
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
      buttonTheme: other.buttonTheme,
      textTheme: other.textTheme,
      linkTheme: other.linkTheme,
      progressTheme: other.progressTheme,
      iconTheme: other.iconTheme,
      inputTheme: other.inputTheme,
      cardTheme: other.cardTheme,
      collapseTheme: other.collapseTheme,
      tagTheme: other.tagTheme,
      tooltipTheme: other.tooltipTheme,
      closeButtonTheme: other.closeButtonTheme,
      sliderTheme: other.sliderTheme,
      tabsTheme: other.tabsTheme,
      navMenuTheme: other.navMenuTheme,
      codePreviewTheme: other.codePreviewTheme,
      asideTheme: other.asideTheme,
      headerTheme: other.headerTheme,
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
      buttonTheme:
          ElButtonThemeData.theme.lerp(a.buttonTheme, b.buttonTheme, t),
      textTheme: ElTextThemeData.theme.lerp(a.textTheme, b.textTheme, t),
      linkTheme: ElLinkThemeData.theme.lerp(a.linkTheme, b.linkTheme, t),
      progressTheme:
          ElProgressThemeData.theme.lerp(a.progressTheme, b.progressTheme, t),
      iconTheme: ElIconThemeData.theme.lerp(a.iconTheme, b.iconTheme, t),
      inputTheme: ElInputThemeData.theme.lerp(a.inputTheme, b.inputTheme, t),
      cardTheme: ElCardThemeData.theme.lerp(a.cardTheme, b.cardTheme, t),
      collapseTheme:
          ElCollapseThemeData.theme.lerp(a.collapseTheme, b.collapseTheme, t),
      tagTheme: ElTagThemeData.theme.lerp(a.tagTheme, b.tagTheme, t),
      tooltipTheme:
          ElTooltipThemeData.theme.lerp(a.tooltipTheme, b.tooltipTheme, t),
      closeButtonTheme: ElCloseButtonThemeData.theme
          .lerp(a.closeButtonTheme, b.closeButtonTheme, t),
      sliderTheme:
          ElSliderThemeData.theme.lerp(a.sliderTheme, b.sliderTheme, t),
      tabsTheme: ElTabsThemeData.theme.lerp(a.tabsTheme, b.tabsTheme, t),
      navMenuTheme:
          ElNavMenuThemeData.theme.lerp(a.navMenuTheme, b.navMenuTheme, t),
      codePreviewTheme: ElCodePreviewThemeData.theme
          .lerp(a.codePreviewTheme, b.codePreviewTheme, t),
      asideTheme: ElAsideThemeData.theme.lerp(a.asideTheme, b.asideTheme, t),
      headerTheme:
          ElHeaderThemeData.theme.lerp(a.headerTheme, b.headerTheme, t),
      messageTheme:
          ElMessageThemeData.theme.lerp(a.messageTheme, b.messageTheme, t),
      modalTheme: ElModalThemeData.theme.lerp(a.modalTheme, b.modalTheme, t),
      toastTheme: ElToastThemeData.theme.lerp(a.toastTheme, b.toastTheme, t),
    );
  }
}
