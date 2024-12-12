import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import 'raw_button.dart';

class ElButton2 extends RawButton {
  const ElButton2({
    super.key,
    required super.child,
    this.bgColor,
    this.width,
    this.height,
    this.iconSize,
    this.leftIcon,
    this.rightIcon,
    this.round = false,
    this.padding,
    super.duration,
    super.curve,
    super.type,
    super.block,
    super.textStyle,
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

  /// 自定义图标尺寸
  final double? iconSize;

  /// 按钮左图标
  final Widget? leftIcon;

  /// 按钮右图标
  final Widget? rightIcon;

  /// 圆角按钮
  final bool round;

  /// 自定义按钮内边距
  final EdgeInsets? padding;

  @override
  State<RawButton> createState() => ElButton2State();
}

class ElButton2State<T extends ElButton2> extends RawButtonState<T> {
  bool get isIconChild => widget.child is ElIcon;

  bool get isDefaultButton => widget.type == null && widget.bgColor == null;

  /// 获取按钮主题背景颜色，如果 bgColor 不为 null，则返回 bgColor，否则根据 type 返回预设主题色
  Color get themeBgColor {
    if (widget.bgColor != null) return widget.bgColor!;
    return context.elThemeColors[widget.type ?? El.primary]!;
  }

  @override
  ButtonStyle buildButtonStyle(BuildContext context) {
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

    return ButtonStyle(
      textColor: textColor,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(sizePreset.radius!),
      ),
    );
  }

  @override
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: sizePreset.height!,
        minWidth: widget.width ??
            (isIconChild ? sizePreset.height! * 1.25 : sizePreset.width!),
      ),
      child: _AnimatedWidget(
        duration: duration,
        curve: curve,
        decoration: style.decoration,
        textStyle: TextStyle(
          color: style.textColor,
          fontSize: sizePreset.fontSize,
          fontWeight: FontWeight.w500,
        ).merge(widget.textStyle),
        iconThemeData: ElIconThemeData(
          size: widget.iconSize ?? sizePreset.iconSize,
          color: style.textColor,
        ),
        child: Padding(
          padding: widget.padding ??
              EdgeInsets.symmetric(horizontal: sizePreset.height! / 2),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  Widget buildButtonContent(BuildContext context) {
    Widget result = super.buildButtonContent(context);

    Widget? $leftIcon = widget.leftIcon;
    Widget? $rightIcon = widget.rightIcon;
    if (widget.loadingBuilder == null && widget.loading) {
      if ($leftIcon != null) {
        $leftIcon = widget.loadingWidget;
      } else if ($rightIcon != null) {
        $rightIcon = widget.loadingWidget;
      } else {
        if (!isIconChild) {
          $leftIcon = widget.loadingWidget;
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
          ? widget.loadingWidget
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

class _AnimatedWidget extends ImplicitlyAnimatedWidget {
  const _AnimatedWidget({
    required super.duration,
    super.curve,
    required this.decoration,
    required this.textStyle,
    required this.iconThemeData,
    required this.child,
  });

  final BoxDecoration decoration;
  final TextStyle textStyle;
  final ElIconThemeData iconThemeData;
  final Widget child;

  @override
  AnimatedWidgetBaseState<_AnimatedWidget> createState() =>
      _AnimatedWidgetState();
}

class _AnimatedWidgetState extends AnimatedWidgetBaseState<_AnimatedWidget> {
  DecorationTween? _decoration;
  TextStyleTween? _textStyle;
  ElIconThemeDataTween? _iconThemeData;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decoration!.evaluate(animation),
      child: ElDefaultTextStyle(
        style: _textStyle!.evaluate(animation),
        child: ElIconTheme(
          data: _iconThemeData!.evaluate(animation),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _decoration = visitor(_decoration, widget.decoration,
            (dynamic value) => DecorationTween(begin: value as BoxDecoration))
        as DecorationTween;
    _textStyle = visitor(_textStyle, widget.textStyle,
            (dynamic value) => TextStyleTween(begin: value as TextStyle))
        as TextStyleTween;
    _iconThemeData = visitor(
            _iconThemeData,
            widget.iconThemeData,
            (dynamic value) =>
                ElIconThemeDataTween(begin: value as ElIconThemeData))
        as ElIconThemeDataTween;
  }
}
