part of 'index.dart';

class ElOutlineButton extends ElButton2 {
  /// Element UI 链接按钮，外观与普通文字完全一样
  const ElOutlineButton({
    super.key,
    required super.child,
    super.type,
    super.width,
    super.height,
    super.block,
    super.autofocus,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  @override
  State<ElButton2> createState() => ElOutlineButtonState();
}

class ElOutlineButtonState extends ElButton2State<ElOutlineButton> {
  @override
  Widget buildWrapper(BuildContext context) {
    final $height = context.elConfig.size!;
    return UnconstrainedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: $height,
        ),
        child: AnimatedDecoratedBox(
          duration: context.elDuration(const Duration(milliseconds: 200)),
          decoration: BoxDecoration(
            color: context.hasHover
                ? context.elTheme.primary
                : context.elLayout.bgColor,
            borderRadius: context.elConfig.radius,
            border: Border.all(
              width: 2.0,
              color: context.elTheme.primary,
            ),
          ),
          child: ElAnimatedDefaultTextStyle(
            duration: context.elDuration(const Duration(milliseconds: 200)),
            style: TextStyle(
              color: context.hasHover ? Colors.white : context.elTheme.primary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: $height / 2),
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
