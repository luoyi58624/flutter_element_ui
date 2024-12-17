import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'theme.dart';

class ElOutlineButton extends ElButton2 {
  /// Element UI 边框按钮
  const ElOutlineButton({
    super.key,
    required super.child,
    this.plain,
    this.onlyActiveBorder,
    this.borderWidth,
    super.type,
    super.width,
    super.height,
    super.round,
    super.block,
    super.leftIcon,
    super.rightIcon,
    super.loadingWidget,
    super.loadingBuilder,
    super.loading,
    super.disabled,
    super.autofocus,
    super.onPressed,
  });

  /// 是否绘制镂空样式按钮，默认 true，若为 false，按钮将更加贴合背景颜色，同时移除 tap 反馈
  final bool? plain;

  /// 当鼠标悬停、点击按钮时，是否只对边框进行高亮，默认 false
  final bool? onlyActiveBorder;

  /// 自定义边框宽度
  final double? borderWidth;

  @override
  State<ElButton2> createState() => _ElOutlineButtonState();
}

class _ElOutlineButtonState extends ElButton2State<ElOutlineButton> {
  bool get plain => themeData.plain ?? true;

  bool get onlyActiveBorder => themeData.onlyActiveBorder ?? false;

  @override
  ElOutlineButtonThemeData get themeData =>
      super.themeData as ElOutlineButtonThemeData;

  @override
  Duration get decorationDuration => plain
      ? super.decorationDuration
      : context.elDuration(const Duration(milliseconds: 300));

  @override
  Curve get decorationCurve => plain ? super.decorationCurve : Curves.easeOut;

  @override
  Border? get border => Border.all(
        width: themeData.borderWidth ?? commonSizePreset.borderWidth!,
        color: colorRecord.borderColor!,
      );

  @override
  ElButton2ThemeData buildThemeData(BuildContext context) {
    return ElOutlineButtonTheme.of(context).copyWith(
      plain: widget.plain,
      onlyActiveBorder: widget.onlyActiveBorder,
      borderWidth: widget.borderWidth,
      duration: widget.duration,
      curve: widget.curve,
      type: widget.type,
      bgColor: widget.bgColor,
      width: widget.width,
      height: widget.height,
      leftIcon: widget.leftIcon,
      rightIcon: widget.rightIcon,
      round: widget.round,
      padding: widget.padding,
      iconSize: widget.iconSize,
      block: widget.block,
      loadingWidget: widget.loadingWidget,
      loadingBuilder: widget.loadingBuilder,
    );
  }

  @override
  ElButtonColorRecord buildColorRecord(BuildContext context) {
    late Color bgColor;
    late Color textColor;
    late Color borderColor;

    if (isDefaultButton) {
      bgColor = context.currentBgColor;
      textColor = context.hasTap || context.hasHover
          ? context.elTheme.primary
          : bgColor.elRegularTextColor(context);
      if (plain) {
        if (onlyActiveBorder) {
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

      if (plain) {
        if (onlyActiveBorder) {
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
        if (onlyActiveBorder) {
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
      bgColor: bgColor,
      textColor: textColor,
      borderColor: borderColor,
    );
  }

  @override
  ElButtonColorRecord buildLoadingColorRecord(BuildContext context) {
    final colorRecord = super.buildLoadingColorRecord(context);
    return (
      bgColor: colorRecord.bgColor,
      textColor: colorRecord.textColor,
      borderColor: colorRecord.bgColor,
    );
  }
}
