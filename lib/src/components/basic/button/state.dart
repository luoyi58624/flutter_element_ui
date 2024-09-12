part of 'index.dart';

/// 按钮宽度最小为 64
const double _minWidth = 64;

class _ElButtonState extends State<ElButton2> {
  late ElButtonStyle defaultStyle;
  double? width;
  late double height;
  EdgeInsetsGeometry? padding;
  late _StyleProp styleProp;

  Widget get child =>
      widget.child is Widget ? widget.child : ElText(widget.child);

  /// 设置按钮尺寸
  void setButtonSize(BuildContext context) {}

  /// 设置样式
  void setStyleProp() {
    defaultStyle = context.elTheme.buttonStyle;
    width = widget.width;
    height =
        widget.height ?? defaultStyle.height ?? context.elConfig.baseHeight;
    padding = widget.padding ?? defaultStyle.padding;
    styleProp = (
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
        if (styleProp.enableFeedback) HapticFeedback.mediumImpact();
        if (widget.onPressed != null) widget.onPressed!();
      },
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      disabled: styleProp.disabled,
      delay: defaultStyle.animatedDuration.inMilliseconds,
      builder: (context) {
        return ElHoverBuilder(
          disabled: styleProp.disabled,
          cursor: styleProp.loading
              ? ElUtils.loadingCursor
              : styleProp.disabled
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
          builder: (context) => builder(context),
        );
      },
    );
  }

  /// 构建按钮外观
  Widget buildButton(BuildContext context) {
    Widget result = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        child,
      ],
    );
    if (widget.type == null) {
      result = _DefaultButton(child: result);
    } else {}
    return UnconstrainedBox(
      child: _ButtonData(
        duration: defaultStyle.animatedDuration,
        height: height,
        padding: widget.padding ?? defaultStyle.padding,
        borderRadius: widget.borderRadius ??
            defaultStyle.borderRadius ??
            context.elConfig.radius,
        child: ElDefaultTextStyle.merge(
          style: ElDefaultTextStyle.of(context).style.copyWith(
                fontSize: 15,
                fontWeight: ElFont.medium,
                // color: buttonStyle.textColor,
              ),
          child: result,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ElAssert.themeType(widget.type, 'ElButton');
    setStyleProp();
    return buildEvent(
      builder: (context) => buildButton(context),
    );
  }
}

class _ButtonData extends InheritedWidget {
  const _ButtonData({
    required super.child,
    required this.duration,
    required this.height,
    required this.padding,
    required this.borderRadius,
  });

  final Duration duration;
  final double height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry borderRadius;

  static _ButtonData of(BuildContext context) {
    final _ButtonData? result =
        context.dependOnInheritedWidgetOfExactType<_ButtonData>();
    assert(result != null, 'No _ButtonData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ButtonData oldWidget) => true;
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
