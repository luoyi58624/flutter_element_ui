import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'raw_button.dart';

class ElLinkButton extends ElButton2 {
  /// Element UI 链接按钮，外观与普通文字完全一样
  const ElLinkButton({
    super.key,
    required super.child,
    super.type,
    super.autofocus,
    super.loading,
    super.loadingWidget,
    super.loadingBuilder,
    super.disabled,
    super.onPressed,
  });

  @override
  State<ElLinkButton> createState() => _ElLinkButtonState();
}

class _ElLinkButtonState extends ElButton2State<ElLinkButton> {
  @override
  bool get isDefaultButton => widget.type == null;

  @override
  double get minWidth => 0.0;

  @override
  double get minHeight => 0.0;

  @override
  EdgeInsets get padding => EdgeInsets.zero;

  @override
  ElButtonColorStyle buildLoadingBuilderStyle(BuildContext context) {
    final bgColor = context.currentBgColor;
    return (
      bgColor: bgColor,
      textColor: widget.type == null
          ? bgColor.elRegularTextColor(context)
          : context.elThemeColors[widget.type]!
    );
  }

  @override
  ElButtonStyleBuilder buildButtonStyle(BuildContext context) {
    if (widget.loadingBuilder != null && widget.loading) {
      final loadingStyle = buildLoadingBuilderStyle(context);

      return (
        textColor: loadingStyle.textColor,
        decoration: const BoxDecoration(),
      );
    }

    final bgColor = context.currentBgColor;

    Color textColor = widget.type == null
        ? bgColor.elRegularTextColor(context)
        : context.elThemeColors[widget.type]!;

    textColor = context.hasTap
        ? textColor.elLight3(context, reverse: true)
        : context.hasHover
            ? textColor.elLight5(context)
            : textColor;

    if (widget.disabled || widget.loading) {
      textColor = isDefaultButton
          ? textColor.elLight6(context)
          : textColor.elLight5(context);
    }

    return (
      textColor: textColor,
      decoration: const BoxDecoration(),
    );
  }
}
