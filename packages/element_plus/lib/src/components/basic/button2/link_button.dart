import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

class ElLinkButton extends ElTextButton {
  /// Element UI 链接按钮，外观与普通文字完全一样
  const ElLinkButton({
    super.key,
    required super.child,
    super.type,
    super.color,
    super.autofocus,
    super.loading,
    super.loadingBuilder,
    super.disabled,
    super.onPressed,
  });

  static WidgetBuilder loadingIndicator = (BuildContext context) {
    final iconTheme = ElIconTheme.of(context);
    return SizedBox(
      width: iconTheme.size,
      height: iconTheme.size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: iconTheme.color,
      ),
    );
  };

  @override
  State<ElLinkButton> createState() => _ElLinkButtonState();
}

class _ElLinkButtonState extends ElTextButtonState<ElLinkButton> {
  @override
  WidgetBuilder? get loadingBuilder =>
      widget.loadingBuilder ?? ElLinkButton.loadingIndicator;

  @override
  ElButtonColorRecord buildColorRecord(BuildContext context) {
    Color textColor = context.hasTap
        ? this.textColor.elLight3(context, reverse: true)
        : context.hasHover
            ? this.textColor.elLight5(context)
            : this.textColor;

    if (widget.disabled || widget.loading) {
      textColor = isDefaultButton
          ? textColor.elLight6(context)
          : textColor.elLight5(context);
    }

    return (
      bgColor: null,
      textColor: textColor,
      borderColor: null,
    );
  }

  // ==================================================================
  // 链接按钮只需要构建文本
  // ==================================================================

  @override
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    return child;
  }

  @override
  Widget buildButtonContent(BuildContext context) {
    return child;
  }
}
