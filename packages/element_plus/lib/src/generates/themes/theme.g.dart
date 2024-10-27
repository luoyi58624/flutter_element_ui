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

  /// 卡片默认样式
  late final ElCardThemeData cardTheme;

  /// 按钮默认样式
  late final ElButtonThemeData buttonTheme;

  /// 输入框默认样式
  late final ElInputThemeData inputTheme;

  /// 折叠菜单默认样式
  late final ElCollapseThemeData collapseTheme;

  /// 图标默认样式
  late final ElIconThemeData iconTheme;

  /// 滑块默认样式
  late final ElSliderThemeData sliderTheme;

  /// 超链接默认样式
  late final ElLinkThemeData linkTheme;

  /// 文本默认样式
  late final ElTextThemeData textTheme;

  /// 进度条默认样式
  late final ElProgressThemeData progressTheme;

  /// 提示框默认样式
  late final ElTooltipThemeData tooltipTheme;

  /// 导航菜单默认样式
  late final ElNavMenuThemeData navMenuTheme;

  /// 标签容器子标签默认样式
  late final ElTabThemeData tabTheme;

  /// 标签默认样式
  late final ElTagThemeData tagTheme;

  /// 标签容器默认样式
  late final ElTabsThemeData tabsTheme;

  /// 代码预览默认样式
  late final ElCodePreviewThemeData codePreviewTheme;

  /// 侧边栏默认样式
  late final ElAsideThemeData asideTheme;

  /// 导航头默认样式
  late final ElHeaderThemeData headerTheme;

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
    ElCardThemeData? cardTheme,
    ElButtonThemeData? buttonTheme,
    ElInputThemeData? inputTheme,
    ElCollapseThemeData? collapseTheme,
    ElIconThemeData? iconTheme,
    ElSliderThemeData? sliderTheme,
    ElLinkThemeData? linkTheme,
    ElTextThemeData? textTheme,
    ElProgressThemeData? progressTheme,
    ElTooltipThemeData? tooltipTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElTabThemeData? tabTheme,
    ElTagThemeData? tagTheme,
    ElTabsThemeData? tabsTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
  }) {
    this.cardTheme = ElCardThemeData.theme.merge(cardTheme);
    this.buttonTheme = ElButtonThemeData.theme.merge(buttonTheme);
    this.inputTheme = ElInputThemeData.theme.merge(inputTheme);
    this.collapseTheme = ElCollapseThemeData.theme.merge(collapseTheme);
    this.iconTheme = ElIconThemeData.theme.merge(iconTheme);
    this.sliderTheme = ElSliderThemeData.theme.merge(sliderTheme);
    this.linkTheme = ElLinkThemeData.theme.merge(linkTheme);
    this.textTheme = ElTextThemeData.theme.merge(textTheme);
    this.progressTheme = ElProgressThemeData.theme.merge(progressTheme);
    this.tooltipTheme = ElTooltipThemeData.theme.merge(tooltipTheme);
    this.navMenuTheme = ElNavMenuThemeData.theme.merge(navMenuTheme);
    this.tabTheme = ElTabThemeData.theme.merge(tabTheme);
    this.tagTheme = ElTagThemeData.theme.merge(tagTheme);
    this.tabsTheme = ElTabsThemeData.theme.merge(tabsTheme);
    this.codePreviewTheme =
        ElCodePreviewThemeData.theme.merge(codePreviewTheme);
    this.asideTheme = ElAsideThemeData.theme.merge(asideTheme);
    this.headerTheme = ElHeaderThemeData.theme.merge(headerTheme);
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
    ElCardThemeData? cardTheme,
    ElButtonThemeData? buttonTheme,
    ElInputThemeData? inputTheme,
    ElCollapseThemeData? collapseTheme,
    ElIconThemeData? iconTheme,
    ElSliderThemeData? sliderTheme,
    ElLinkThemeData? linkTheme,
    ElTextThemeData? textTheme,
    ElProgressThemeData? progressTheme,
    ElTooltipThemeData? tooltipTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElTabThemeData? tabTheme,
    ElTagThemeData? tagTheme,
    ElTabsThemeData? tabsTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
    ElMessageThemeData? messageTheme,
    ElModalThemeData? modalTheme,
    ElToastThemeData? toastTheme,
  }) : super.dark() {
    this.cardTheme = ElCardThemeData.darkTheme.merge(cardTheme);
    this.buttonTheme = ElButtonThemeData.darkTheme.merge(buttonTheme);
    this.inputTheme = ElInputThemeData.darkTheme.merge(inputTheme);
    this.collapseTheme = ElCollapseThemeData.darkTheme.merge(collapseTheme);
    this.iconTheme = ElIconThemeData.darkTheme.merge(iconTheme);
    this.sliderTheme = ElSliderThemeData.darkTheme.merge(sliderTheme);
    this.linkTheme = ElLinkThemeData.darkTheme.merge(linkTheme);
    this.textTheme = ElTextThemeData.darkTheme.merge(textTheme);
    this.progressTheme = ElProgressThemeData.darkTheme.merge(progressTheme);
    this.tooltipTheme = ElTooltipThemeData.darkTheme.merge(tooltipTheme);
    this.navMenuTheme = ElNavMenuThemeData.darkTheme.merge(navMenuTheme);
    this.tabTheme = ElTabThemeData.darkTheme.merge(tabTheme);
    this.tagTheme = ElTagThemeData.darkTheme.merge(tagTheme);
    this.tabsTheme = ElTabsThemeData.darkTheme.merge(tabsTheme);
    this.codePreviewTheme =
        ElCodePreviewThemeData.darkTheme.merge(codePreviewTheme);
    this.asideTheme = ElAsideThemeData.darkTheme.merge(asideTheme);
    this.headerTheme = ElHeaderThemeData.darkTheme.merge(headerTheme);
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
    ElCardThemeData? cardTheme,
    ElButtonThemeData? buttonTheme,
    ElInputThemeData? inputTheme,
    ElCollapseThemeData? collapseTheme,
    ElIconThemeData? iconTheme,
    ElSliderThemeData? sliderTheme,
    ElLinkThemeData? linkTheme,
    ElTextThemeData? textTheme,
    ElProgressThemeData? progressTheme,
    ElTooltipThemeData? tooltipTheme,
    ElNavMenuThemeData? navMenuTheme,
    ElTabThemeData? tabTheme,
    ElTagThemeData? tagTheme,
    ElTabsThemeData? tabsTheme,
    ElCodePreviewThemeData? codePreviewTheme,
    ElAsideThemeData? asideTheme,
    ElHeaderThemeData? headerTheme,
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
      cardTheme: this.cardTheme.merge(cardTheme),
      buttonTheme: this.buttonTheme.merge(buttonTheme),
      inputTheme: this.inputTheme.merge(inputTheme),
      collapseTheme: this.collapseTheme.merge(collapseTheme),
      iconTheme: this.iconTheme.merge(iconTheme),
      sliderTheme: this.sliderTheme.merge(sliderTheme),
      linkTheme: this.linkTheme.merge(linkTheme),
      textTheme: this.textTheme.merge(textTheme),
      progressTheme: this.progressTheme.merge(progressTheme),
      tooltipTheme: this.tooltipTheme.merge(tooltipTheme),
      navMenuTheme: this.navMenuTheme.merge(navMenuTheme),
      tabTheme: this.tabTheme.merge(tabTheme),
      tagTheme: this.tagTheme.merge(tagTheme),
      tabsTheme: this.tabsTheme.merge(tabsTheme),
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
      regularTextColor: other.regularTextColor,
      secondaryTextColor: other.secondaryTextColor,
      placeholderTextColor: other.placeholderTextColor,
      borderColor: other.borderColor,
      cardTheme: other.cardTheme,
      buttonTheme: other.buttonTheme,
      inputTheme: other.inputTheme,
      collapseTheme: other.collapseTheme,
      iconTheme: other.iconTheme,
      sliderTheme: other.sliderTheme,
      linkTheme: other.linkTheme,
      textTheme: other.textTheme,
      progressTheme: other.progressTheme,
      tooltipTheme: other.tooltipTheme,
      navMenuTheme: other.navMenuTheme,
      tabTheme: other.tabTheme,
      tagTheme: other.tagTheme,
      tabsTheme: other.tabsTheme,
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

class ElThemeDataTween extends Tween<ElThemeData> {
  ElThemeDataTween({super.begin, super.end});

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
      cardTheme: ElCardThemeData.theme.lerp(a.cardTheme, b.cardTheme, t),
      buttonTheme:
          ElButtonThemeData.theme.lerp(a.buttonTheme, b.buttonTheme, t),
      inputTheme: ElInputThemeData.theme.lerp(a.inputTheme, b.inputTheme, t),
      collapseTheme:
          ElCollapseThemeData.theme.lerp(a.collapseTheme, b.collapseTheme, t),
      iconTheme: ElIconThemeData.theme.lerp(a.iconTheme, b.iconTheme, t),
      sliderTheme:
          ElSliderThemeData.theme.lerp(a.sliderTheme, b.sliderTheme, t),
      linkTheme: ElLinkThemeData.theme.lerp(a.linkTheme, b.linkTheme, t),
      textTheme: ElTextThemeData.theme.lerp(a.textTheme, b.textTheme, t),
      progressTheme:
          ElProgressThemeData.theme.lerp(a.progressTheme, b.progressTheme, t),
      tooltipTheme:
          ElTooltipThemeData.theme.lerp(a.tooltipTheme, b.tooltipTheme, t),
      navMenuTheme:
          ElNavMenuThemeData.theme.lerp(a.navMenuTheme, b.navMenuTheme, t),
      tabTheme: ElTabThemeData.theme.lerp(a.tabTheme, b.tabTheme, t),
      tagTheme: ElTagThemeData.theme.lerp(a.tagTheme, b.tagTheme, t),
      tabsTheme: ElTabsThemeData.theme.lerp(a.tabsTheme, b.tabsTheme, t),
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
