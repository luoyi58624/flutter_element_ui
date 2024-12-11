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
  Color? calcTextColor(BuildContext context, Color? $bgColor) {
    final result = widget.type == null
        ? $bgColor!.elRegularTextColor(context)
        : context.elThemeColors[widget.type]!;
    return context.hasTap
        ? result.elLight3(context, reverse: true)
        : context.hasHover
            ? result.elLight5(context)
            : result;
  }

  @override
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    return ElAnimatedDefaultTextStyle(
      duration: duration,
      style: TextStyle(
        color: calcTextColor(context, bgColor),
        fontSize: sizePreset.fontSize,
        fontWeight: FontWeight.w500,
      ),
      child: child,
    );
  }
}
