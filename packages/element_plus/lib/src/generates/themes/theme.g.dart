// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../themes/theme.dart';

// **************************************************************************
// ElGlobalThemeModelGenerator
// **************************************************************************

class ElThemeData extends _ElThemeData {
  /// 亮色默认主题
  static final ElThemeData theme = ElThemeData();

  /// 暗色默认主题
  static final ElThemeData darkTheme = ElThemeData.dark();

  /// 滑块默认样式
  late final ElSliderThemeData sliderTheme;

  /// 侧边栏默认样式
  late final ElAsideThemeData asideTheme;

  /// 导航头默认样式
  late final ElHeaderThemeData headerTheme;

  /// 文本默认样式
  late final ElTextThemeData textTheme;

  /// 输入框默认样式
  late final ElInputThemeData inputTheme;

  /// 标签容器默认样式
  late final ElTabsThemeData tabsTheme;

  /// 图标默认样式
  late final ElIconThemeData iconTheme;

  /// 超链接默认样式
  late final ElLinkThemeData linkTheme;

  /// 导航菜单默认样式
  late final ElNavMenuThemeData navMenuTheme;

  /// 按钮默认样式
  late final ElButtonThemeData buttonTheme;

  /// 标签容器子标签默认样式
  late final ElTabThemeData tabTheme;

  /// 代码预览默认样式
  late final ElCodePreviewThemeData codePreviewTheme;

  /// 提示框默认样式
  late final ElTooltipThemeData tooltipTheme;

  /// 进度条默认样式
  late final ElProgressThemeData progressTheme;

  /// 标签默认样式
  late final ElTagThemeData tagTheme;

  /// 卡片默认样式
  late final ElCardThemeData cardTheme;

  /// 折叠菜单默认样式
  late final ElCollapseThemeData collapseTheme;

  /// 消息提示默认样式
  late final ElMessageThemeData messageTheme;

  /// 模态框默认样式
  late final ElModalThemeData modalTheme;

  /// 轻提示默认样式
  late final ElToastThemeData toastTheme;

  /// 亮色主题构造器
  ElThemeData({
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
    ElSliderThemeData? sliderTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElTextThemeData? textTheme,
    ElInputThemeData? inputTheme,
    ElTabsThemeData? tabsTheme,
    ElIconThemeData? iconTheme,
    ElLinkThemeData? linkTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElButtonThemeData? buttonTheme,
    ElTabThemeData? tabTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElTooltipThemeData? tooltipTheme,
    ElProgressThemeData? progressTheme,
    ElTagThemeData? tagTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
  }) {
    this.sliderTheme = ElSliderThemeData.theme.merge(sliderTheme);
    this.asideTheme = ElAsideThemeData.theme.merge(asideTheme);
    this.headerTheme = ElHeaderThemeData.theme.merge(headerTheme);
    this.textTheme = ElTextThemeData.theme.merge(textTheme);
    this.inputTheme = ElInputThemeData.theme.merge(inputTheme);
    this.tabsTheme = ElTabsThemeData.theme.merge(tabsTheme);
    this.iconTheme = ElIconThemeData.theme.merge(iconTheme);
    this.linkTheme = ElLinkThemeData.theme.merge(linkTheme);
    this.navMenuTheme = ElNavMenuThemeData.theme.merge(navMenuTheme);
    this.buttonTheme = ElButtonThemeData.theme.merge(buttonTheme);
    this.tabTheme = ElTabThemeData.theme.merge(tabTheme);
    this.codePreviewTheme =
        ElCodePreviewThemeData.theme.merge(codePreviewTheme);
    this.tooltipTheme = ElTooltipThemeData.theme.merge(tooltipTheme);
    this.progressTheme = ElProgressThemeData.theme.merge(progressTheme);
    this.tagTheme = ElTagThemeData.theme.merge(tagTheme);
    this.cardTheme = ElCardThemeData.theme.merge(cardTheme);
    this.collapseTheme = ElCollapseThemeData.theme.merge(collapseTheme);
    this.messageTheme = ElMessageThemeData.theme.merge(messageTheme);
    this.modalTheme = ElModalThemeData.theme.merge(modalTheme);
    this.toastTheme = ElToastThemeData.theme.merge(toastTheme);
  }

  /// 暗色主题构造器，它是私有的，若要自定义主题请操作 [darkTheme] 实例
  ElThemeData.dark({
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
    ElSliderThemeData? sliderTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElTextThemeData? textTheme,
    ElInputThemeData? inputTheme,
    ElTabsThemeData? tabsTheme,
    ElIconThemeData? iconTheme,
    ElLinkThemeData? linkTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElButtonThemeData? buttonTheme,
    ElTabThemeData? tabTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElTooltipThemeData? tooltipTheme,
    ElProgressThemeData? progressTheme,
    ElTagThemeData? tagTheme,
    ElCardThemeData? cardTheme,
    ElCollapseThemeData? collapseTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
  }) : super.dark() {
    this.sliderTheme = ElSliderThemeData.darkTheme.merge(sliderTheme);
    this.asideTheme = ElAsideThemeData.darkTheme.merge(asideTheme);
    this.headerTheme = ElHeaderThemeData.darkTheme.merge(headerTheme);
    this.textTheme = ElTextThemeData.darkTheme.merge(textTheme);
    this.inputTheme = ElInputThemeData.darkTheme.merge(inputTheme);
    this.tabsTheme = ElTabsThemeData.darkTheme.merge(tabsTheme);
    this.iconTheme = ElIconThemeData.darkTheme.merge(iconTheme);
    this.linkTheme = ElLinkThemeData.darkTheme.merge(linkTheme);
    this.navMenuTheme = ElNavMenuThemeData.darkTheme.merge(navMenuTheme);
    this.buttonTheme = ElButtonThemeData.darkTheme.merge(buttonTheme);
    this.tabTheme = ElTabThemeData.darkTheme.merge(tabTheme);
    this.codePreviewTheme =
        ElCodePreviewThemeData.darkTheme.merge(codePreviewTheme);
    this.tooltipTheme = ElTooltipThemeData.darkTheme.merge(tooltipTheme);
    this.progressTheme = ElProgressThemeData.darkTheme.merge(progressTheme);
    this.tagTheme = ElTagThemeData.darkTheme.merge(tagTheme);
    this.cardTheme = ElCardThemeData.darkTheme.merge(cardTheme);
    this.collapseTheme = ElCollapseThemeData.darkTheme.merge(collapseTheme);
    this.messageTheme = ElMessageThemeData.darkTheme.merge(messageTheme);
    this.modalTheme = ElModalThemeData.darkTheme.merge(modalTheme);
    this.toastTheme = ElToastThemeData.darkTheme.merge(toastTheme);
  }

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
    ElSliderThemeData? sliderTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElTextThemeData? textTheme,
    ElInputThemeData? inputTheme,
    ElTabsThemeData? tabsTheme,
    ElIconThemeData? iconTheme,
    ElLinkThemeData? linkTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElButtonThemeData? buttonTheme,
    ElTabThemeData? tabTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElTooltipThemeData? tooltipTheme,
    ElProgressThemeData? progressTheme,
    ElTagThemeData? tagTheme,
    ElCardThemeData? cardTheme,
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
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      asideTheme: this.asideTheme.merge(asideTheme),
      headerTheme: this.headerTheme.merge(headerTheme),
      textTheme: this.textTheme.merge(textTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      codePreviewTheme: this.codePreviewTheme.merge(codePreviewTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      cardTheme: this.cardTheme.merge(cardTheme),
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
      sliderTheme: other.sliderTheme,
      asideTheme: other.asideTheme,
      headerTheme: other.headerTheme,
      textTheme: other.textTheme,
      inputTheme: other.inputTheme,
      tabsTheme: other.tabsTheme,
      iconTheme: other.iconTheme,
      linkTheme: other.linkTheme,
      navMenuTheme: other.navMenuTheme,
      buttonTheme: other.buttonTheme,
      tabTheme: other.tabTheme,
      codePreviewTheme: other.codePreviewTheme,
      tooltipTheme: other.tooltipTheme,
      progressTheme: other.progressTheme,
      tagTheme: other.tagTheme,
      cardTheme: other.cardTheme,
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

  /// 通过上下文访问默认的主题数据，可能为 null
  static ElThemeData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElTheme>()?.data;

  static ElThemeData of(BuildContext context) {
    final ElTheme? result =
        context.dependOnInheritedWidgetOfExactType<ElTheme>();
    assert(result != null, 'No ElTheme found in context');
    return result!.data;
  }

  /// 接收自定义主题数据，将它与祖先提供的主题进行合并，组成新的主题数据提供给后代组件
  static Widget merge({
    Key? key,
    ElThemeData? data,
    required Widget child,
  }) {
    return Builder(builder: (context) {
      final parent = ElTheme.of(context);
      return ElTheme(
        data: parent.merge(data),
        child: child,
      );
    });
  }

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
  ElThemeDataTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(_data, widget.data,
            (dynamic value) => ElThemeDataTween(begin: value as ElThemeData))!
        as ElThemeDataTween;
  }

  @override
  Widget build(BuildContext context) {
    return ElTheme(
      data: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}
