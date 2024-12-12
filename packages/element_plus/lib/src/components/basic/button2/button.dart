import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import '../../feedback/loading/loading.dart';
import 'raw_button.dart';

class ElButton2 extends ElRawButton {
  const ElButton2({
    super.key,
    required super.child,
    this.bgColor,
    this.width,
    this.height,
    this.leftIcon,
    this.rightIcon,
    this.round = false,
    this.padding,
    super.duration,
    super.curve,
    super.type,
    super.block,
    super.iconSize,
    super.autofocus,
    super.disabled,
    super.loading,
    super.loadingWidget,
    super.loadingBuilder,
    super.onPressed,
  });

  /// 自定义颜色按钮，它会覆盖 [type] 属性
  final Color? bgColor;

  /// 按钮最小宽度，按钮的宽度受多种因素影响，具体表现有以下几种情况（按优先级排序）：
  /// * [block]，它会解除按钮约束，通常情况下按钮将充满整个空间，这取决于父级约束条件
  /// * [circle]，按钮宽度强制等于高度，因为此时按钮是圆形
  /// * [width]，用户自定义宽度
  /// * 最后：如果 [child] 是 [ElIcon] 或 [Icon]，那么默认宽度等于 height * 1.25
  final double? width;

  /// 按钮高度
  final double? height;

  /// 按钮左图标
  final Widget? leftIcon;

  /// 按钮右图标
  final Widget? rightIcon;

  /// 圆角按钮
  final bool round;

  /// 自定义按钮内边距
  final EdgeInsets? padding;

  @override
  State<ElRawButton> createState() => ElButton2State();
}

class ElButton2State<T extends ElButton2> extends ElRawButtonState<T> {
  bool get isIconChild => widget.child is ElIcon || widget.child is Icon;

  bool get isDefaultButton => widget.type == null && widget.bgColor == null;

  /// 如果是图标按钮，直接应用预设宽度会显得剩余空间比较大，所以需要处理一下
  double get minHeight => widget.height ?? sizePreset.height!;

  /// 如果是图标按钮，直接应用预设宽度会显得剩余空间比较大，所以需要处理一下
  double get minWidth =>
      widget.width ??
      (isIconChild ? sizePreset.height! * 1.25 : sizePreset.width!);

  /// 按钮内边距
  EdgeInsets get padding =>
      widget.padding ??
      EdgeInsets.symmetric(horizontal: sizePreset.height! / 2);

  Widget get loadingWidget =>
      widget.loadingWidget ?? const ElLoading(ElIcons.loading);

  /// 获取按钮主题背景颜色，如果 bgColor 不为 null，则返回 bgColor，否则根据 type 返回预设主题色
  Color get themeBgColor {
    if (widget.bgColor != null) return widget.bgColor!;
    return context.elThemeColors[widget.type ?? El.primary]!;
  }

  ElButtonColorStyle buildLoadingBuilderStyle(BuildContext context) {
    final bgColor = context.isDark
        ? const Color.fromRGBO(57, 57, 57, 1.0)
        : const Color.fromRGBO(224, 224, 224, 1.0);
    final textColor = context.isDark
        ? const Color.fromRGBO(118, 118, 118, 1.0)
        : const Color.fromRGBO(166, 166, 166, 1.0);

    return (bgColor: bgColor, textColor: textColor);
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

    late Color bgColor;
    late Color textColor;
    if (isDefaultButton) {
      bgColor = context.isDark ? Colors.grey.shade800 : Colors.grey.shade200;
      textColor = context.elTheme.textTheme.regularStyle.color!;

      if (context.hasTap) {
        bgColor = bgColor.elLight2(context, reverse: true);
      } else if (context.hasHover) {
        bgColor = bgColor.elLight1(context, reverse: true);
      }
    } else {
      bgColor = themeBgColor;
      textColor = bgColor.elTextColor(context);

      if (context.hasTap) {
        bgColor = bgColor.elLight3(context, reverse: true);
      } else if (context.hasHover) {
        bgColor = bgColor.elLight3(context);
      }
    }

    if (widget.disabled || widget.loading) {
      bgColor = bgColor.elLight5(context);
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

  @override
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    Widget result = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: minHeight,
        minWidth: minWidth,
      ),
      child: AnimatedDecoratedBox(
        duration: duration,
        curve: curve,
        decoration: style.decoration,
        child: Padding(
          padding: padding,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
    if (widget.loadingBuilder != null && widget.loading) {
      result = Stack(
        children: [
          result,
          Positioned.fill(
            child: Center(
              child: widget.loadingBuilder!(context),
            ),
          ),
        ],
      );
    }

    return result;
  }

  @override
  Widget buildButtonContent(BuildContext context) {
    Widget result = super.buildButtonContent(context);

    Widget? $leftIcon = widget.leftIcon;
    Widget? $rightIcon = widget.rightIcon;
    if (widget.loadingBuilder == null && widget.loading) {
      if ($leftIcon != null) {
        $leftIcon = loadingWidget;
      } else if ($rightIcon != null) {
        $rightIcon = loadingWidget;
      } else {
        if (!isIconChild) {
          $leftIcon = loadingWidget;
        }
      }
    }

    result = Padding(
      padding: EdgeInsets.only(
        left: $leftIcon != null ? 6.0 : 0.0,
        right: $rightIcon != null ? 6.0 : 0.0,
      ),
      child: widget.loadingBuilder == null &&
              widget.leftIcon == null &&
              widget.loading &&
              isIconChild
          ? loadingWidget
          : result,
    );

    result = DefaultSelectionStyle(
      mouseCursor: cursor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if ($leftIcon != null) $leftIcon,
          result,
          if ($rightIcon != null) $rightIcon,
        ],
      ),
    );

    if (widget.loadingBuilder != null) {
      result = Opacity(
        opacity: widget.loading == true ? 0.0 : 1.0,
        child: result,
      );
    }

    return result;
  }
}
