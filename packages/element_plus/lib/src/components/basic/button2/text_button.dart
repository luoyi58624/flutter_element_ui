import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';

class ElTextButton extends ElButton2 {
  /// Element UI 文字按钮，外观与 [ElButton] 一样，但按钮颜色会跟随当前背景色
  const ElTextButton({
    super.key,
    required super.child,
    this.color,
    this.bg = false,
    this.iconScale = 1.2,
    super.duration,
    super.curve,
    super.type,
    super.round,
    super.padding,
    super.autofocus,
    super.loading,
    super.leftIcon,
    super.rightIcon,
    super.loadingWidget,
    super.loadingBuilder,
    super.disabled,
    super.onPressed,
  });

  /// 自定义文字按钮颜色，它会覆盖 [type] 属性
  final Color? color;

  /// 文字按钮是否添加默认背景，默认 false
  final bool bg;

  /// 定义透明背景色文字按钮缩放比例，默认 1.2 倍
  final double iconScale;

  @override
  State<ElButton2> createState() => ElTextButtonState();
}

class ElTextButtonState extends ElButton2State<ElTextButton> {
  @override
  bool get isDefaultButton => widget.type == null && widget.color == null;

  @override
  double get iconSize => widget.bg == false && isIconChild
      ? super.iconSize * widget.iconScale
      : super.iconSize;

  /// 对于透明背景的图标按钮，将内边距设置为 0 整体外观更紧凑
  @override
  EdgeInsets get padding =>
      isIconChild && widget.bg == false ? EdgeInsets.zero : super.padding;

  @override
  ElButtonColorStyle buildLoadingBuilderStyle(BuildContext context) {
    final bgColor = context.currentBgColor;
    return (
      bgColor: bgColor,
      textColor: widget.color ??
          (widget.type == null
              ? bgColor.elRegularTextColor(context)
              : context.elThemeColors[widget.type]!)
    );
  }

  @override
  ElButtonStyleBuilder buildButtonStyle(BuildContext context) {
    if (widget.loadingBuilder != null && widget.loading) {
      final loadingStyle = buildLoadingBuilderStyle(context);

      return (
        textColor: loadingStyle.textColor,
        decoration: BoxDecoration(
          color: loadingStyle.bgColor,
          borderRadius: BorderRadius.circular(sizePreset.radius!),
        ),
      );
    }

    Color bgColor = context.currentBgColor;
    Color textColor = widget.color ??
        (widget.type == null
            ? bgColor.elRegularTextColor(context)
            : context.elThemeColors[widget.type]!);

    if (widget.bg) {
      bgColor = context.hasTap
          ? bgColor.deepen(15)
          : context.hasHover
              ? bgColor.deepen(10)
              : bgColor.deepen(5);
    } else {
      bgColor = context.hasTap
          ? bgColor.deepen(10)
          : context.hasHover
              ? bgColor.deepen(5)
              : bgColor;
    }

    if (widget.disabled || widget.loading) {
      if (widget.bg) {
        bgColor = bgColor.elLight4(context);
      }
      textColor = isDefaultButton
          ? textColor.elLight6(context)
          : textColor.elLight5(context);
    }

    return (
      textColor: textColor,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(sizePreset.radius!),
      ),
    );
  }
}
