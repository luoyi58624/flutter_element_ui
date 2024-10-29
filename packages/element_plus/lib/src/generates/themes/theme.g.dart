// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static const ElThemeData theme = ElThemeData();

  /// 暗色默认主题
  static const ElThemeData darkTheme = ElThemeData.dark();

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 标签容器子标签默认样式
  final ElTabThemeData tabTheme;

  /// 标签默认样式
  final ElTagThemeData tagTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 折叠菜单默认样式
  final ElCollapseThemeData collapseTheme;

  /// 消息提示默认样式
  final ElMessageThemeData messageTheme;

  /// 模态框默认样式
  final ElModalThemeData modalTheme;

  /// 轻提示默认样式
  final ElToastThemeData toastTheme;

  /// 亮色主题构造器，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    super.bgColor,
    super.borderColor,
    this.textTheme = ElTextThemeData.theme,
    this.sliderTheme = ElSliderThemeData.theme,
    this.tabsTheme = ElTabsThemeData.theme,
    this.cardTheme = ElCardThemeData.theme,
    this.buttonTheme = ElButtonThemeData.theme,
    this.tabTheme = ElTabThemeData.theme,
    this.tagTheme = ElTagThemeData.theme,
    this.iconTheme = ElIconThemeData.theme,
    this.progressTheme = ElProgressThemeData.theme,
    this.navMenuTheme = ElNavMenuThemeData.theme,
    this.tooltipTheme = ElTooltipThemeData.theme,
    this.codePreviewTheme = ElCodePreviewThemeData.theme,
    this.asideTheme = ElAsideThemeData.theme,
    this.headerTheme = ElHeaderThemeData.theme,
    this.linkTheme = ElLinkThemeData.theme,
    this.inputTheme = ElInputThemeData.theme,
    this.collapseTheme = ElCollapseThemeData.theme,
    this.messageTheme = ElMessageThemeData.theme,
    this.modalTheme = ElModalThemeData.theme,
    this.toastTheme = ElToastThemeData.theme,
  });

  /// 暗色主题构造器，请通过 [darkTheme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData.dark({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    super.bgColor,
    super.borderColor,
    this.textTheme = ElTextThemeData.darkTheme,
    this.sliderTheme = ElSliderThemeData.darkTheme,
    this.tabsTheme = ElTabsThemeData.darkTheme,
    this.cardTheme = ElCardThemeData.darkTheme,
    this.buttonTheme = ElButtonThemeData.darkTheme,
    this.tabTheme = ElTabThemeData.darkTheme,
    this.tagTheme = ElTagThemeData.darkTheme,
    this.iconTheme = ElIconThemeData.darkTheme,
    this.progressTheme = ElProgressThemeData.darkTheme,
    this.navMenuTheme = ElNavMenuThemeData.darkTheme,
    this.tooltipTheme = ElTooltipThemeData.darkTheme,
    this.codePreviewTheme = ElCodePreviewThemeData.darkTheme,
    this.asideTheme = ElAsideThemeData.darkTheme,
    this.headerTheme = ElHeaderThemeData.darkTheme,
    this.linkTheme = ElLinkThemeData.darkTheme,
    this.inputTheme = ElInputThemeData.darkTheme,
    this.collapseTheme = ElCollapseThemeData.darkTheme,
    this.messageTheme = ElMessageThemeData.darkTheme,
    this.modalTheme = ElModalThemeData.darkTheme,
    this.toastTheme = ElToastThemeData.darkTheme,
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
    ElTextThemeData? textTheme,
    ElSliderThemeData? sliderTheme,
    ElTabsThemeData? tabsTheme,
    ElCardThemeData? cardTheme,
    ElButtonThemeData? buttonTheme,
    ElTabThemeData? tabTheme,
    ElTagThemeData? tagTheme,
    ElIconThemeData? iconTheme,
    ElProgressThemeData? progressTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElTooltipThemeData? tooltipTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElLinkThemeData? linkTheme,
    ElInputThemeData? inputTheme,
    ElCollapseThemeData? collapseTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
  }) {
    return ElThemeData(
      primary: primary ?? super.primary,
      success: success ?? super.success,
      info: info ?? super.info,
      warning: warning ?? super.warning,
      error: error ?? super.error,
      bgColor: bgColor ?? super.bgColor,
      borderColor: borderColor ?? super.borderColor,
      textTheme: this.textTheme.merge(textTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
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
      textTheme: other.textTheme,
      sliderTheme: other.sliderTheme,
      tabsTheme: other.tabsTheme,
      cardTheme: other.cardTheme,
      buttonTheme: other.buttonTheme,
      tabTheme: other.tabTheme,
      tagTheme: other.tagTheme,
      iconTheme: other.iconTheme,
      progressTheme: other.progressTheme,
      navMenuTheme: other.navMenuTheme,
      tooltipTheme: other.tooltipTheme,
      codePreviewTheme: other.codePreviewTheme,
      asideTheme: other.asideTheme,
      headerTheme: other.headerTheme,
      linkTheme: other.linkTheme,
      inputTheme: other.inputTheme,
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

    return ElThemeData(
      primary: Color.lerp(a.primary, b.primary, t) ?? a.primary,
      success: Color.lerp(a.success, b.success, t) ?? a.success,
      info: Color.lerp(a.info, b.info, t) ?? a.info,
      warning: Color.lerp(a.warning, b.warning, t) ?? a.warning,
      error: Color.lerp(a.error, b.error, t) ?? a.error,
      bgColor: Color.lerp(a.bgColor, b.bgColor, t) ?? a.bgColor,
      borderColor: Color.lerp(a.borderColor, b.borderColor, t) ?? a.borderColor,
      textTheme: ElTextThemeData.theme.lerp(a.textTheme, b.textTheme, t),
      sliderTheme:
          ElSliderThemeData.theme.lerp(a.sliderTheme, b.sliderTheme, t),
      tabsTheme: ElTabsThemeData.theme.lerp(a.tabsTheme, b.tabsTheme, t),
      cardTheme: ElCardThemeData.theme.lerp(a.cardTheme, b.cardTheme, t),
      buttonTheme:
          ElButtonThemeData.theme.lerp(a.buttonTheme, b.buttonTheme, t),
      tabTheme: ElTabThemeData.theme.lerp(a.tabTheme, b.tabTheme, t),
      tagTheme: ElTagThemeData.theme.lerp(a.tagTheme, b.tagTheme, t),
      iconTheme: ElIconThemeData.theme.lerp(a.iconTheme, b.iconTheme, t),
      progressTheme:
          ElProgressThemeData.theme.lerp(a.progressTheme, b.progressTheme, t),
      navMenuTheme:
          ElNavMenuThemeData.theme.lerp(a.navMenuTheme, b.navMenuTheme, t),
      tooltipTheme:
          ElTooltipThemeData.theme.lerp(a.tooltipTheme, b.tooltipTheme, t),
      codePreviewTheme: ElCodePreviewThemeData.theme
          .lerp(a.codePreviewTheme, b.codePreviewTheme, t),
      asideTheme: ElAsideThemeData.theme.lerp(a.asideTheme, b.asideTheme, t),
      headerTheme:
          ElHeaderThemeData.theme.lerp(a.headerTheme, b.headerTheme, t),
      linkTheme: ElLinkThemeData.theme.lerp(a.linkTheme, b.linkTheme, t),
      inputTheme: ElInputThemeData.theme.lerp(a.inputTheme, b.inputTheme, t),
      collapseTheme:
          ElCollapseThemeData.theme.lerp(a.collapseTheme, b.collapseTheme, t),
      messageTheme:
          ElMessageThemeData.theme.lerp(a.messageTheme, b.messageTheme, t),
      modalTheme: ElModalThemeData.theme.lerp(a.modalTheme, b.modalTheme, t),
      toastTheme: ElToastThemeData.theme.lerp(a.toastTheme, b.toastTheme, t),
    );
  }
}
