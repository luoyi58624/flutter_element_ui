part of 'index.dart';

/// 按钮宽度最小为 64
const double _minWidth = 64;

/// 改变按钮透明度样式值
const double _disabledOpacity = 0.6;

/// 文字类型按钮被禁用时透明值
const double _textButtonDisabledOpacity = 0.36;

typedef ElButtonProp = ({
  double height,
  Duration duration,
  Color? bgColor,
  Color? color,
  String? type,
  bool text,
  bool link,
  bool plain,
  bool round,
  bool block,
  BorderRadiusGeometry borderRadius,
  EdgeInsetsGeometry? padding,
  ElIcon? leftIcon,
  ElIcon? rightIcon,
  bool circle,
  bool disabled,
  bool loading,
  bool enableFeedback,
});

class _ElButtonState extends State<ElButton2> with TickerProviderStateMixin {
  late ElButtonStyle defaultStyle;
  late ElButtonProp prop;
  late AnimationController sizeController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 300),
  );

  late Animation sizeAnimation;

  Widget get child =>
      widget.child is Widget ? widget.child : ElText(widget.child);

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ElButton2 oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  /// 设置按钮尺寸
  void setButtonSize(BuildContext context) {}

  /// 设置样式
  void setProp() {
    defaultStyle = context.elTheme.buttonStyle;
    prop = (
      height:
          widget.height ?? defaultStyle.height ?? context.elConfig.baseHeight,
      duration: defaultStyle.animatedDuration,
      bgColor: widget.bgColor,
      color: widget.color,
      type: widget.type,
      text: widget.text,
      link: widget.link,
      plain: widget.plain,
      round: widget.round,
      block: widget.block,
      borderRadius: widget.borderRadius ??
          defaultStyle.borderRadius ??
          context.elConfig.radius,
      padding: widget.padding ?? defaultStyle.padding,
      leftIcon: widget.leftIcon,
      rightIcon: widget.rightIcon,
      circle: widget.circle,
      disabled: widget.loading || widget.disabled,
      loading: widget.loading,
      enableFeedback: widget.enableFeedback ??
          defaultStyle.enableFeedback ??
          context.elConfig.enableFeedback,
    );
  }

  /// 构建按钮事件
  Widget buildEvent({required WidgetBuilder builder}) {
    return ElTapBuilder(
      onTap: () {
        if (prop.enableFeedback) HapticFeedback.mediumImpact();
        if (widget.onPressed != null) widget.onPressed!();
      },
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      disabled: prop.disabled,
      delay: defaultStyle.animatedDuration.inMilliseconds,
      builder: (context) {
        return ElHoverBuilder(
          disabled: prop.disabled,
          cursor: prop.loading
              ? ElUtils.loadingCursor
              : prop.disabled
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
          builder: (context) => builder(context),
        );
      },
    );
  }

  /// 构建按钮外观
  Widget buildButton(BuildContext context) {
    return UnconstrainedBox(
      child: _ElButtonTextStyle(
        bgColor: widget.bgColor,
        type: widget.type,
        text: widget.text,
        plain: widget.plain,
        link: widget.link,
        disabled: prop.disabled,
        child: _ElButtonWrapper(
          prop: prop,
          child: ElButtonContent(
            prop: prop,
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ElAssert.themeType(widget.type, 'ElButton');
    setProp();
    return buildEvent(
      builder: (context) => buildButton(context),
    );
  }
}

extension _ButtonColorExtension on Color {
  /// hover 悬停颜色，颜色会变得更浅
  Color hover(BuildContext context) => elLight2(context);

  /// tap 按下颜色，颜色会变得更深
  Color tap(BuildContext context) => elLight3(context, reverse: true);

  /// 应用主题透明背景颜色
  Color themeLightBg(BuildContext context) => elLight9(context);

  /// 应用主题透明边框颜色
  Color themeLightBorder(BuildContext context) => elLight6(context);
}
