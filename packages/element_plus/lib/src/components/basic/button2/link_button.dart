import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import 'raw_button.dart';

class ElLinkButton extends RawButton {
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

class _ElLinkButtonState extends RawButtonState<ElLinkButton> {
  @override
  ButtonStyle buildButtonStyle(BuildContext context) {
    final bgColor = context.currentBgColor;

    final result = widget.type == null
        ? bgColor.elRegularTextColor(context)
        : context.elThemeColors[widget.type]!;

    final textColor = context.hasTap
        ? result.elLight3(context, reverse: true)
        : context.hasHover
            ? result.elLight5(context)
            : result;
    return ButtonStyle(
      textColor: textColor,
      decoration: const BoxDecoration(),
    );
  }

  @override
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    return ElAnimatedDefaultTextStyle(
      duration: duration,
      style: TextStyle(
        color: style.textColor,
        fontSize: sizePreset.fontSize,
        fontWeight: FontWeight.w500,
      ),
      child: child,
    );
  }
}
