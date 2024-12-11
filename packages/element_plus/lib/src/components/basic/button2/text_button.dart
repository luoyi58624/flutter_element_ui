part of 'index.dart';

class ElTextButton extends ElButton2 {
  /// Element UI 文字按钮，外观与 [ElButton] 一样，但按钮颜色会跟随当前背景色
  const ElTextButton({
    super.key,
    required super.child,
    super.duration,
    super.type,
    this.color,
    this.bg = false,
    super.round,
    super.padding,
    super.textStyle,
    super.autofocus,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  /// 自定义文字按钮颜色，它会覆盖 [type] 属性
  final Color? color;

  /// 文字按钮是否添加默认背景，默认 false
  final bool bg;

  @override
  State<ElButton2> createState() => ElTextButtonState();
}

class ElTextButtonState extends ElButton2State<ElTextButton> {
  @override
  Color calcBgColor(BuildContext context, Color color) {
    if (widget.bg) {
      return context.hasTap
          ? color.deepen(15)
          : context.hasHover
              ? color.deepen(10)
              : color.deepen(5);
    } else {
      return context.hasTap
          ? color.deepen(10)
          : context.hasHover
              ? color.deepen(5)
              : color;
    }
  }

  @override
  Color calcTextColor(BuildContext context, Color color) => color;

  @override
  Widget buildWrapper(BuildContext context) {
    Color $bgColor = context.currentBgColor;
    Color $color = widget.color ??
        (widget.type == null
            ? $bgColor.elRegularTextColor(context)
            : context.elThemeColors[widget.type]!);

    return UnconstrainedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: sizePreset.height,
          minWidth: sizePreset.width,
        ),
        child: AnimatedDecoratedBox(
          duration: duration,
          decoration: BoxDecoration(
            color: calcBgColor(context, $bgColor),
            borderRadius: context.elConfig.radius,
          ),
          child: ElAnimatedDefaultTextStyle(
            duration: duration,
            style: TextStyle(
              color: calcTextColor(context, $color),
              fontSize: sizePreset.fontSize,
              fontWeight: FontWeight.w500,
            ).merge(widget.textStyle),
            child: Padding(
              padding: widget.padding ??
                  EdgeInsets.symmetric(horizontal: sizePreset.height / 2),
              child: Center(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
