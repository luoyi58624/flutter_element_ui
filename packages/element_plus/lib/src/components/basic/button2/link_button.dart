part of 'index.dart';

class ElLinkButton extends ElRawButton {
  /// Element UI 链接按钮，外观与普通文字完全一样
  const ElLinkButton(
    this.text, {
    super.key,
    super.type,
    super.autofocus,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  final String text;

  @override
  Color calcTextColor(BuildContext context, Color color) {
    return context.hasTap
        ? color.tap(context)
        : context.hasHover
            ? color.disabled(context)
            : color;
  }

  @override
  Widget buildWrapper(BuildContext context) {
    final $duration = context.elDuration(_duration);
    Color $bgColor = context.currentBgColor;
    Color color = type == null
        ? $bgColor.elRegularTextColor(context)
        : context.elThemeColors[type]!;

    return ElAnimatedDefaultTextStyle(
      duration: $duration,
      style: TextStyle(
        color: calcTextColor(context, color),
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      child: ElText(text),
    );
  }
}
