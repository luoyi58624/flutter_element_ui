import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../builders/hover.dart';
import '../../builders/tap.dart';
import '../../theme.dart';
import '../../utils/assets.dart';
import 'icon.dart';
import 'text.dart';

typedef _ButtonStyle = ({
  double height,
  Color? bgColor,
  Color? color,
  String? type,
  bool text,
  bool plain,
  bool round,
  bool block,
  BorderRadiusGeometry borderRadius,
  EdgeInsetsGeometry? margin,
  EdgeInsetsGeometry? padding,
  ElIcon? leftIcon,
  ElIcon? rightIcon,
  bool circle,
  bool disabled,
  bool loading,
});

class ElButton extends StatelessWidget {
  const ElButton(
    this.child, {
    super.key,
    this.onPressed,
    this.height,
    this.bgColor,
    this.color,
    this.type,
    this.text = false,
    this.plain = false,
    this.round = false,
    this.block = false,
    this.borderRadius,
    this.margin,
    this.padding,
    this.leftIcon,
    this.rightIcon,
    this.circle = false,
    this.disabled = false,
    this.loading = false,
  });

  /// 支持任意类型子组件：
  /// * 如果是基础类型，则自动渲染为[Text]
  /// * 如果是[Widget]，则直接渲染
  final dynamic child;

  /// 点击事件
  final VoidCallback? onPressed;

  /// 按钮高度，默认36
  final double? height;

  /// 按钮背景颜色
  final Color? bgColor;

  /// 按钮文字、图标颜色，如果为空，则根据[bgColor]自动计算为全局默认的文字颜色
  final Color? color;

  /// 主题类型
  final String? type;

  /// 文字按钮，默认false
  final bool text;

  /// 镂空按钮，默认false
  final bool plain;

  /// 圆角按钮，默认false
  final bool round;

  /// 块级按钮，宽度会充满容器，默认false
  final bool block;

  /// 自定义按钮圆角，默认 4 像素，如果[round]为true，则强制渲染为圆角按钮
  final BorderRadiusGeometry? borderRadius;

  /// 按钮外边距，默认为 4 像素
  final EdgeInsetsGeometry? margin;

  /// 按钮内边距，默认设置水平内边距为高度一半
  final EdgeInsetsGeometry? padding;

  /// 按钮左图标，默认null
  final ElIcon? leftIcon;

  /// 按钮右图标，默认null
  final ElIcon? rightIcon;

  /// 圆形按钮，默认false
  final bool circle;

  /// 禁用按钮，默认false
  final bool disabled;

  /// 开启 loading
  final bool loading;

  @override
  Widget build(BuildContext context) {
    themeTypeAssets(type);
    final defaultStyle = context.elConfig.buttonStyle;
    _ButtonStyle style = (
      height: height ?? defaultStyle.height,
      bgColor: bgColor,
      color: color,
      type: type,
      text: text,
      plain: plain,
      round: round,
      block: block,
      borderRadius: borderRadius ?? defaultStyle.borderRadius!,
      margin: margin ?? defaultStyle.margin,
      padding: padding ?? defaultStyle.padding,
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      circle: circle,
      disabled: disabled,
      loading: loading,
    );
    final currentWidget = SelectionContainer.disabled(
      child: ElHoverBuilder(
        disabled: disabled,
        builder: ($isHover) => ElTapBuilder(
          onTap: onPressed,
          disabled: disabled,
          builder: ($isTap) => _Button(child, style),
        ),
      ),
    );
    return block && !circle
        ? SizedBox(width: double.maxFinite, child: currentWidget)
        : UnconstrainedBox(child: currentWidget);
  }
}

class _Button extends HookWidget {
  const _Button(this.child, this.style);

  final dynamic child;
  final _ButtonStyle style;

  /// child类型为基础类型
  bool get isBaseType => child == null || DartUtil.isBaseType(child);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _useButtonStyle(context, style);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: style.circle ? style.height : null,
      height: style.height,
      alignment: Alignment.center,
      margin: style.margin,
      padding: style.circle ? null : style.padding,
      decoration: BoxDecoration(
        color: buttonStyle.bgColor,
        border: buttonStyle.border,
        borderRadius: style.round || style.circle
            ? BorderRadius.circular(style.height / 2)
            : style.borderRadius,
      ),
      child: buildChild(buttonStyle),
    );
  }

  Widget buildChild(_ButtonStyleHook buttonStyle) {
    late Widget childWidget;
    if (child is Widget) {
      if (child is ElIcon) {
        childWidget = buildIcon(child, buttonStyle);
      } else {
        childWidget = child;
      }
    } else {
      childWidget = ElText(
        child,
        style: TextStyle(
            fontWeight: FontWeight.w500, color: buttonStyle.textColor),
        strutStyle: const StrutStyle(forceStrutHeight: true),
      );
    }
    if (style.leftIcon != null || style.rightIcon != null) {
      childWidget = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (style.leftIcon != null) buildIcon(style.leftIcon!, buttonStyle),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: childWidget),
          if (style.rightIcon != null) buildIcon(style.rightIcon!, buttonStyle)
        ],
      );
    }
    return childWidget;
  }

  Widget buildIcon(Widget iconWidget, _ButtonStyleHook buttonStyle) {
    return ElIconTheme(
      color: buttonStyle.textColor,
      child: iconWidget,
    );
  }
}

typedef _ButtonStyleHook = ({Color? bgColor, Color? textColor, Border? border});

/// 计算按钮样式 hook
_ButtonStyleHook _useButtonStyle(BuildContext context, _ButtonStyle style) {
  final bgColor = useState<Color?>(null);
  final textColor = useState<Color?>(null);
  final borderColor = useState<Color?>(null);

  final $isHover = ElHoverBuilder.of(context);
  final $isTap = ElTapBuilder.of(context);
  final $bgColor = context.elTheme.bgColor;
  final $isThemeType = elThemeTypes.contains(style.type);

  // 计算文字按钮样式
  if (style.text) {
    bgColor.value = $bgColor.onHover($isHover, 4).onTap($isTap, 4);
    $isThemeType
        ? textColor.value = context.themeTypeColors[style.type]!
        : textColor.value = context.elTheme.textColor;

    if (style.disabled) {
      textColor.value = textColor.value!.withOpacity(0.6);
    }
  } else {
    // 计算默认按钮样式
    if ($isThemeType == false && style.bgColor == null) {
      final $primaryColor = context.elTheme.primary;
      bgColor.value =
          $isHover || $isTap ? $primaryColor.elThemeLightBg(context) : $bgColor;
      textColor.value =
          $isHover || $isTap ? $primaryColor : context.elTheme.textColor;
      borderColor.value = $isTap
          ? $primaryColor
          : $isHover
              ? $primaryColor.elThemeLightBorder(context)
              : context.elTheme.borderColor;
    }
    // 计算主题按钮样式
    else {
      final $primaryColor =
          style.bgColor ?? context.themeTypeColors[style.type]!;
      final $textColor = style.color ??
          (style.bgColor == null
              ? context.darkTheme.textColor
              : style.bgColor!.elTextColor(context));
      // 镂空按钮
      if (style.plain) {
        textColor.value = $isHover || $isTap ? $textColor : $primaryColor;
        bgColor.value = PlatformUtil.isDesktop
            ? ($isTap
                ? $primaryColor.elTap(context)
                : $isHover
                    ? $primaryColor
                    : $primaryColor.elThemeLightBg(context))
            : ($isTap ? $primaryColor : $primaryColor.elThemeLightBg(context));
        borderColor.value = PlatformUtil.isDesktop
            ? ($isTap
                ? $primaryColor.elTap(context)
                : $isHover
                    ? $primaryColor
                    : $primaryColor.elThemeLightBorder(context))
            : ($isTap
                ? $primaryColor
                : $primaryColor.elThemeLightBorder(context));
      }
      // 主题按钮
      else {
        textColor.value = $textColor;
        bgColor.value = $isTap
            ? $primaryColor.elTap(context)
            : $isHover
                ? $primaryColor.elHover(context)
                : $primaryColor;
      }
    }

    // 计算禁用样式
    if (style.disabled) {
      if ($isThemeType == false && style.bgColor == null) {
        textColor.value = textColor.value!.withOpacity(0.6);
        borderColor.value = borderColor.value!.withOpacity(0.6);
      } else {
        if (style.plain) {
          bgColor.value = bgColor.value!.withOpacity(0.6);
          textColor.value = textColor.value!.withOpacity(0.6);
          borderColor.value = borderColor.value!.withOpacity(0.6);
        } else {
          bgColor.value = bgColor.value!.withOpacity(0.6);
          textColor.value = textColor.value!.withOpacity(0.9);
        }
      }
    }
  }

  return (
    bgColor: bgColor.value,
    textColor: textColor.value,
    border:
        borderColor.value != null ? Border.all(color: borderColor.value!) : null
  );
}
