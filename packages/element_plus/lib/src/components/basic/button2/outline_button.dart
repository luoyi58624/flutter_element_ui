part of 'index.dart';

class ElOutlineButton extends ElButton2 {
  /// Element UI 边框按钮
  const ElOutlineButton({
    super.key,
    required super.child,
    this.plain = true,
    this.borderWidth = 1.0,
    super.duration,
    super.curve,
    super.type,
    super.width,
    super.height,
    super.block,
    super.autofocus,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  /// 是否绘制镂空样式按钮，默认 true，若为 false，按钮将更加贴合背景颜色
  final bool plain;

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
  Color get bgColor {
    if (isDefaultButton || widget.plain == false) return context.currentBgColor;
    return getBgColor();
  }

  @override
  Color? calcBgColor(BuildContext context) {
    final color = bgColor;
    if (isDefaultButton) {
      if (widget.plain) {
        return context.hasTap || context.hasHover
            ? context.elTheme.primary.elLight9(context)
            : color;
      } else {
        return color;
      }
    }
    if (widget.plain) {
      return context.hasTap
          ? color.elLight3(context, reverse: true)
          : context.hasHover
              ? color
              : color.elLight9(context);
    } else {
      return context.hasTap || context.hasHover ? getBgColor() : color;
    }
  }

  @override
  Color? calcTextColor(BuildContext context, Color? $bgColor) {
    if (isDefaultButton) {
      return context.hasTap || context.hasHover
          ? context.elTheme.primary
          : bgColor.elRegularTextColor(context);
    }
    if (context.hasTap || context.hasHover) {
      return $bgColor?.elTextColor(context);
    } else {
      return getBgColor();
    }
  }

  @override
  Border? calcBorder(BuildContext context) {
    late Color borderColor;
    if (isDefaultButton) {
      if (widget.plain) {
        borderColor = context.hasTap
            ? context.elTheme.primary
            : context.hasHover
                ? context.elTheme.primary.elLight5(context)
                : context.elTheme.layoutTheme.borderColor!;
      } else {
        borderColor = context.hasTap || context.hasHover
            ? context.elTheme.primary
            : context.elTheme.layoutTheme.borderColor!;
      }
    } else {
      if (widget.plain) {
        borderColor = context.hasTap
            ? getBgColor().elLight3(context, reverse: true)
            : context.hasHover
                ? getBgColor()
                : getBgColor().elLight5(context);
      } else {
        borderColor = context.hasTap || context.hasHover
            ? getBgColor()
            : getBgColor().elLight5(context);
      }
    }
    return Border.all(
      width: widget.borderWidth,
      color: borderColor,
    );
  }
}
