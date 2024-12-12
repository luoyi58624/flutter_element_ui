import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'raw_button.dart';

class ElOutlineButton extends ElButton2 {
  /// Element UI 边框按钮
  const ElOutlineButton({
    super.key,
    required super.child,
    this.plain = true,
    this.onlyActiveBorder = false,
    this.borderWidth = 1.0,
    super.duration,
    super.curve,
    super.type,
    super.width,
    super.height,
    super.block,
    super.autofocus,
    super.loading,
    super.leftIcon,
    super.rightIcon,
    super.loadingWidget,
    super.loadingBuilder,
    super.disabled,
    super.onPressed,
  });

  /// 是否绘制镂空样式按钮，默认 true，若为 false，按钮将更加贴合背景颜色
  final bool plain;

  /// 当鼠标悬停、点击按钮时，是否只对边框进行高亮，默认 false
  final bool onlyActiveBorder;

  /// 自定义边框宽度
  final double borderWidth;

  @override
  State<ElButton2> createState() => ElOutlineButtonState();
}

class ElOutlineButtonState extends ElButton2State<ElOutlineButton> {
  @override
  Duration get duration => widget.plain
      ? super.duration
      : context
          .elDuration(widget.duration ?? const Duration(milliseconds: 200));

  @override
  Curve get curve =>
      widget.plain ? super.curve : widget.curve ?? Curves.easeOut;

  @override
  ElButtonStyleBuilder buildButtonStyle(BuildContext context) {
    if (widget.loadingBuilder != null && widget.loading) {
      final loadingStyle = buildLoadingBuilderStyle(context);

      return (
        textColor: loadingStyle.textColor,
        decoration: BoxDecoration(
          color: loadingStyle.bgColor,
          border: Border.all(
            width: widget.borderWidth,
            color: loadingStyle.bgColor,
          ),
          borderRadius: BorderRadius.circular(sizePreset.radius!),
        ),
      );
    }

    late Color bgColor;
    late Color textColor;
    late Color borderColor;

    if (isDefaultButton) {
      bgColor = context.currentBgColor;
      textColor = context.hasTap || context.hasHover
          ? context.elTheme.primary
          : bgColor.elRegularTextColor(context);
      if (widget.plain) {
        if (widget.onlyActiveBorder) {
          borderColor = context.hasTap || context.hasHover
              ? context.elTheme.primary
              : context.elTheme.layoutTheme.borderColor!;
        } else {
          bgColor = context.hasTap || context.hasHover
              ? context.elTheme.primary.elLight9(context)
              : bgColor;
          borderColor = context.hasTap
              ? context.elTheme.primary
              : context.hasHover
                  ? context.elTheme.primary.elLight5(context)
                  : context.elTheme.layoutTheme.borderColor!;
        }
      } else {
        borderColor = context.hasTap || context.hasHover
            ? context.elTheme.primary
            : context.elTheme.layoutTheme.borderColor!;
      }
    } else {
      bgColor = themeBgColor;

      if (context.hasTap || context.hasHover) {
        textColor = bgColor.elTextColor(context);
      } else {
        textColor = themeBgColor;
      }

      if (widget.plain) {
        if (widget.onlyActiveBorder) {
          bgColor = bgColor.elLight9(context);
          textColor = themeBgColor;
          borderColor = context.hasTap || context.hasHover
              ? themeBgColor.elLight2(context, reverse: true)
              : themeBgColor.elLight5(context);
        } else {
          bgColor = context.hasTap
              ? bgColor.elLight3(context, reverse: true)
              : context.hasHover
                  ? bgColor
                  : bgColor.elLight9(context);
          borderColor = context.hasTap
              ? themeBgColor.elLight3(context, reverse: true)
              : context.hasHover
                  ? themeBgColor
                  : themeBgColor.elLight5(context);
        }
      } else {
        if (widget.onlyActiveBorder) {
          bgColor = context.currentBgColor;
          textColor = themeBgColor;
          borderColor = context.hasTap || context.hasHover
              ? themeBgColor.elLight2(context, reverse: true)
              : themeBgColor.elLight5(context);
        } else {
          bgColor = context.hasTap || context.hasHover
              ? themeBgColor
              : context.currentBgColor;

          borderColor = context.hasTap || context.hasHover
              ? themeBgColor
              : themeBgColor.elLight5(context);
        }
      }
    }

    if (widget.disabled || widget.loading) {
      bgColor = bgColor.elLight5(context);
      textColor = isDefaultButton
          ? textColor.elLight6(context)
          : textColor.elLight5(context);
      borderColor = borderColor.elLight5(context);
    }

    return (
      textColor: textColor,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          width: widget.borderWidth,
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(sizePreset.radius!),
      ),
    );
  }
}
