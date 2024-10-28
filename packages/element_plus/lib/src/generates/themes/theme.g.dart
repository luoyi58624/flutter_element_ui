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

  /// 侧边栏默认样式
  final ElAsideThemeData asideTheme;

  /// 导航头默认样式
  final ElHeaderThemeData headerTheme;

  /// 文本默认样式
  final ElTextThemeData textTheme;

  /// 滑块默认样式
  final ElSliderThemeData sliderTheme;

  /// 超链接默认样式
  final ElLinkThemeData linkTheme;

  /// 按钮默认样式
  final ElButtonThemeData buttonTheme;

  /// 标签容器默认样式
  final ElTabsThemeData tabsTheme;

  /// 标签容器子标签默认样式
  final ElTabThemeData tabTheme;

  /// 导航菜单默认样式
  final ElNavMenuThemeData navMenuTheme;

  /// 代码预览默认样式
  final ElCodePreviewThemeData codePreviewTheme;

  /// 输入框默认样式
  final ElInputThemeData inputTheme;

  /// 图标默认样式
  final ElIconThemeData iconTheme;

  /// 卡片默认样式
  final ElCardThemeData cardTheme;

  /// 进度条默认样式
  final ElProgressThemeData progressTheme;

  /// 提示框默认样式
  final ElTooltipThemeData tooltipTheme;

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

  /// 亮色主题构造器，请通过 [theme] 调用 [copyWith] 方法实现自定义主题，避免破坏主题默认值
  const ElThemeData({
    super.primary,
    super.success,
    super.info,
    super.warning,
    super.error,
    super.bgColor,
    super.regularTextColor,
    super.secondaryTextColor,
    super.placeholderTextColor,
    super.borderColor,
    this.asideTheme = ElAsideThemeData.theme,
    this.headerTheme = ElHeaderThemeData.theme,
    this.textTheme = ElTextThemeData.theme,
    this.sliderTheme = ElSliderThemeData.theme,
    this.linkTheme = ElLinkThemeData.theme,
    this.buttonTheme = ElButtonThemeData.theme,
    this.tabsTheme = ElTabsThemeData.theme,
    this.tabTheme = ElTabThemeData.theme,
    this.navMenuTheme = ElNavMenuThemeData.theme,
    this.codePreviewTheme = ElCodePreviewThemeData.theme,
    this.inputTheme = ElInputThemeData.theme,
    this.iconTheme = ElIconThemeData.theme,
    this.cardTheme = ElCardThemeData.theme,
    this.progressTheme = ElProgressThemeData.theme,
    this.tooltipTheme = ElTooltipThemeData.theme,
    this.tagTheme = ElTagThemeData.theme,
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
    super.regularTextColor,
    super.secondaryTextColor,
    super.placeholderTextColor,
    super.borderColor,
    this.asideTheme = ElAsideThemeData.darkTheme,
    this.headerTheme = ElHeaderThemeData.darkTheme,
    this.textTheme = ElTextThemeData.darkTheme,
    this.sliderTheme = ElSliderThemeData.darkTheme,
    this.linkTheme = ElLinkThemeData.darkTheme,
    this.buttonTheme = ElButtonThemeData.darkTheme,
    this.tabsTheme = ElTabsThemeData.darkTheme,
    this.tabTheme = ElTabThemeData.darkTheme,
    this.navMenuTheme = ElNavMenuThemeData.darkTheme,
    this.codePreviewTheme = ElCodePreviewThemeData.darkTheme,
    this.inputTheme = ElInputThemeData.darkTheme,
    this.iconTheme = ElIconThemeData.darkTheme,
    this.cardTheme = ElCardThemeData.darkTheme,
    this.progressTheme = ElProgressThemeData.darkTheme,
    this.tooltipTheme = ElTooltipThemeData.darkTheme,
    this.tagTheme = ElTagThemeData.darkTheme,
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
    Color? regularTextColor,
    Color? secondaryTextColor,
    Color? placeholderTextColor,
    Color? borderColor,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElTextThemeData? textTheme,
    ElSliderThemeData? sliderTheme,
    ElLinkThemeData? linkTheme,
    ElButtonThemeData? buttonTheme,
    ElTabsThemeData? tabsTheme,
    ElTabThemeData? tabTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElInputThemeData? inputTheme,
    ElIconThemeData? iconTheme,
    ElCardThemeData? cardTheme,
    ElProgressThemeData? progressTheme,
    ElTooltipThemeData? tooltipTheme,
    ElTagThemeData? tagTheme,
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
      regularTextColor: regularTextColor ?? super.regularTextColor,
      secondaryTextColor: secondaryTextColor ?? super.secondaryTextColor,
      placeholderTextColor: placeholderTextColor ?? super.placeholderTextColor,
      borderColor: borderColor ?? super.borderColor,
      asideTheme: this.asideTheme.merge(asideTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      textTheme: this.textTheme.merge(textTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
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
      regularTextColor: other.regularTextColor,
      secondaryTextColor: other.secondaryTextColor,
      placeholderTextColor: other.placeholderTextColor,
      borderColor: other.borderColor,
      asideTheme: other.asideTheme,
      headerTheme: other.headerTheme,
      textTheme: other.textTheme,
      sliderTheme: other.sliderTheme,
      linkTheme: other.linkTheme,
      buttonTheme: other.buttonTheme,
      tabsTheme: other.tabsTheme,
      tabTheme: other.tabTheme,
      navMenuTheme: other.navMenuTheme,
      codePreviewTheme: other.codePreviewTheme,
      inputTheme: other.inputTheme,
      iconTheme: other.iconTheme,
      cardTheme: other.cardTheme,
      progressTheme: other.progressTheme,
      tooltipTheme: other.tooltipTheme,
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

    return ElThemeData(
      primary: Color.lerp(a.primary, b.primary, t) ?? a.primary,
      success: Color.lerp(a.success, b.success, t) ?? a.success,
      info: Color.lerp(a.info, b.info, t) ?? a.info,
      warning: Color.lerp(a.warning, b.warning, t) ?? a.warning,
      error: Color.lerp(a.error, b.error, t) ?? a.error,
      bgColor: Color.lerp(a.bgColor, b.bgColor, t) ?? a.bgColor,
      regularTextColor: Color.lerp(a.regularTextColor, b.regularTextColor, t) ??
          a.regularTextColor,
      secondaryTextColor:
          Color.lerp(a.secondaryTextColor, b.secondaryTextColor, t) ??
              a.secondaryTextColor,
      placeholderTextColor:
          Color.lerp(a.placeholderTextColor, b.placeholderTextColor, t) ??
              a.placeholderTextColor,
      borderColor: Color.lerp(a.borderColor, b.borderColor, t) ?? a.borderColor,
      asideTheme: ElAsideThemeData.theme.lerp(a.asideTheme, b.asideTheme, t),
      headerTheme:
          ElHeaderThemeData.theme.lerp(a.headerTheme, b.headerTheme, t),
      textTheme: ElTextThemeData.theme.lerp(a.textTheme, b.textTheme, t),
      sliderTheme:
          ElSliderThemeData.theme.lerp(a.sliderTheme, b.sliderTheme, t),
      linkTheme: ElLinkThemeData.theme.lerp(a.linkTheme, b.linkTheme, t),
      buttonTheme:
          ElButtonThemeData.theme.lerp(a.buttonTheme, b.buttonTheme, t),
      tabsTheme: ElTabsThemeData.theme.lerp(a.tabsTheme, b.tabsTheme, t),
      tabTheme: ElTabThemeData.theme.lerp(a.tabTheme, b.tabTheme, t),
      navMenuTheme:
          ElNavMenuThemeData.theme.lerp(a.navMenuTheme, b.navMenuTheme, t),
      codePreviewTheme: ElCodePreviewThemeData.theme
          .lerp(a.codePreviewTheme, b.codePreviewTheme, t),
      inputTheme: ElInputThemeData.theme.lerp(a.inputTheme, b.inputTheme, t),
      iconTheme: ElIconThemeData.theme.lerp(a.iconTheme, b.iconTheme, t),
      cardTheme: ElCardThemeData.theme.lerp(a.cardTheme, b.cardTheme, t),
      progressTheme:
          ElProgressThemeData.theme.lerp(a.progressTheme, b.progressTheme, t),
      tooltipTheme:
          ElTooltipThemeData.theme.lerp(a.tooltipTheme, b.tooltipTheme, t),
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
