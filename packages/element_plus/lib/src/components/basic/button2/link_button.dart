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

  /// 链接按钮默认的 loading 构造器，它使用 Material 风格的圆形进度条充当加载器
  static Widget defaultLoadingBuilder(BuildContext context) {
    final iconTheme = ElIconTheme.of(context);
    return SizedBox(
      width: iconTheme.size,
      height: iconTheme.size,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: iconTheme.color,
      ),
    );
  }

  @override
  State<ElLinkButton> createState() => _ElLinkButtonState();
}

class _ElLinkButtonState extends ElTextButtonState<ElLinkButton> {
  /// 链接按钮不适合使用默认的 loading 加载器，使用自定义 loading 在外观上更好看一些
  @override
  WidgetBuilder? get loadingBuilder =>
      widget.loadingBuilder ?? ElLinkButton.defaultLoadingBuilder;

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

  // =======================================================================
  // 链接按钮只需要构建文本，所以在构建外观与内容方法上只需要返回 Text 小部件即可
  // =======================================================================

  @override
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    return child;
  }

  @override
  Widget buildButtonContent(BuildContext context) {
    return child;
  }
}
