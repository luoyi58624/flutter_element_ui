part of 'index.dart';

class ElLinkButton extends ElRawButton {
  /// Element UI 链接按钮，外观与普通文字完全一样
  const ElLinkButton({
    super.key,
    required super.child,
    super.type,
    super.autofocus,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  @override
  State<ElLinkButton> createState() => _ElLinkButtonState();
}

class _ElLinkButtonState extends ElRawButtonState<ElLinkButton> {
  @override
  Color get bgColor => context.currentBgColor;

  @override
  Color get textColor => widget.type == null
      ? bgColor.elRegularTextColor(context)
      : context.elThemeColors[widget.type]!;

  @override
  Color calcTextColor(BuildContext context, Color color) {
    return context.hasTap
        ? color.elLight3(context, reverse: true)
        : context.hasHover
            ? color.elLight5(context)
            : color;
  }

  @override
  Widget buildWrapper(BuildContext context, Widget child) {
    return ElAnimatedDefaultTextStyle(
      duration: duration,
      style: TextStyle(
        color: calcTextColor(context, textColor),
        fontSize: sizePreset.fontSize,
        fontWeight: FontWeight.w500,
      ),
      child: child,
    );
  }
}
