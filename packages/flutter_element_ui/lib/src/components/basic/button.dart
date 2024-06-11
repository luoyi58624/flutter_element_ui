import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/component.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../builders/hover.dart';
import '../../builders/tap.dart';
import '../../styles/basic/button.dart';
import '../../utils/platform/platform.dart';
import 'icon.dart';
import 'text.dart';

part '../../generates/components/basic/button.g.dart';

@ElComponent.all()
class ElButton extends HookWidget {
  const ElButton(
    this.child, {
    super.key,
    this.style,
    this.onPressed,
  });

  /// 支持任意类型子组件：
  /// * 如果是基础类型，则自动渲染为[Text]
  /// * 如果是[Widget]，则直接渲染
  final dynamic child;

  /// 按钮样式
  final ElButtonStyle? style;

  /// 点击事件
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final $style = _style(context, style);
    final currentWidget = SelectionContainer.disabled(
      child: ElHoverBuilder(
        disabled: $style.disabled!,
        builder: ($isHover) => ElTapBuilder(
          onTap: onPressed,
          disabled: $style.disabled!,
          builder: ($isTap) => _Button(child, style: $style),
        ),
      ),
    );
    return $style.block! && $style.circle == false
        ? SizedBox(width: double.maxFinite, child: currentWidget)
        : UnconstrainedBox(child: currentWidget);
  }
}

class _Button extends ElButton {
  const _Button(super.child, {super.style});

  /// child类型为基础类型
  bool get isBaseType => child == null || DartUtil.isBaseType(child);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _useButtonStyle(context, style!);
    final buttonHeight = style!.height!;
    final isCircle = style!.circle == true;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      width: isCircle ? buttonHeight : null,
      height: buttonHeight,
      alignment: Alignment.center,
      padding: isCircle ? null : style!.padding ?? EdgeInsets.symmetric(horizontal: buttonHeight / 2),
      decoration: BoxDecoration(
        color: buttonStyle.bgColor,
        border: buttonStyle.border,
        borderRadius: style!.round! || isCircle ? BorderRadius.circular(buttonHeight / 2) : style!.borderRadius,
      ),
      child: buildChild(buttonStyle),
    );
  }

  Widget buildChild(_ElButtonStyle buttonStyle) {
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
        style: TextStyle(fontWeight: FontWeight.w500, color: buttonStyle.textColor),
        strutStyle: const StrutStyle(forceStrutHeight: true),
      );
    }
    if (style!.leftIcon != null || style!.rightIcon != null) {
      childWidget = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (style!.leftIcon != null) buildIcon(style!.leftIcon!, buttonStyle),
          Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: childWidget),
          if (style!.rightIcon != null) buildIcon(style!.rightIcon!, buttonStyle)
        ],
      );
    }
    return childWidget;
  }

  Widget buildIcon(Widget iconWidget, _ElButtonStyle buttonStyle) {
    return ElIconTheme(
      color: buttonStyle.textColor,
      child: iconWidget,
    );
  }
}

typedef _ElButtonStyle = ({Color? bgColor, Color? textColor, Border? border});

/// 计算按钮样式 hook
_ElButtonStyle _useButtonStyle(BuildContext context, ElButtonStyle style) {
  final bgColor = useState<Color?>(null);
  final textColor = useState<Color?>(null);
  final borderColor = useState<Color?>(null);

  final $isHover = ElHoverBuilder.of(context);
  final $isTap = ElTapBuilder.of(context);
  final $bgColor = context.elTheme.bgColor;

  // 计算文字按钮样式
  if (style.text!) {
    bgColor.value = $bgColor.onHover($isHover, 4).onTap($isTap, 4);
    style.type == null
        ? textColor.value = context.elTheme.textColor
        : textColor.value = context.themeTypeColors[style.type]!;

    if (style.disabled!) {
      textColor.value = textColor.value!.withOpacity(0.6);
    }
  } else {
    // 计算默认按钮样式
    if (style.type == null && style.bgColor == null) {
      final $primaryColor = context.elTheme.primary;
      bgColor.value = $isHover || $isTap ? $primaryColor.elThemeLightBg(context) : $bgColor;
      textColor.value = $isHover || $isTap ? $primaryColor : context.elTheme.textColor;
      borderColor.value = $isTap
          ? $primaryColor
          : $isHover
              ? $primaryColor.elThemeLightBorder(context)
              : context.elTheme.borderColor;
    }
    // 计算主题按钮样式
    else {
      final $primaryColor = style.bgColor ?? context.themeTypeColors[style.type]!;
      final $textColor =
          style.color ?? (style.bgColor == null ? context.darkTheme.textColor : style.bgColor!.elTextColor(context));
      // 镂空按钮
      if (style.plain!) {
        textColor.value = $isHover || $isTap ? $textColor : $primaryColor;
        bgColor.value = ElPlatform.isDesktop
            ? ($isTap
                ? $primaryColor.elTap(context)
                : $isHover
                    ? $primaryColor
                    : $primaryColor.elThemeLightBg(context))
            : ($isTap ? $primaryColor : $primaryColor.elThemeLightBg(context));
        borderColor.value = ElPlatform.isDesktop
            ? ($isTap
                ? $primaryColor.elTap(context)
                : $isHover
                    ? $primaryColor
                    : $primaryColor.elThemeLightBorder(context))
            : ($isTap ? $primaryColor : $primaryColor.elThemeLightBorder(context));
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
    if (style.disabled!) {
      if (style.type == null && style.bgColor == null) {
        textColor.value = textColor.value!.withOpacity(0.6);
        borderColor.value = borderColor.value!.withOpacity(0.6);
      } else {
        if (style.plain!) {
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
    border: borderColor.value != null ? Border.all(color: borderColor.value!) : null
  );
}
