import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/component.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../builders/hover.dart';
import '../../builders/tap.dart';
import '../../styles/basic/button.dart';
import '../../styles/basic/icon.dart';
import '../../styles/basic/text.dart';
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
    final $style = ElButtonImportantTheme._merge(
      context,
      context.elConfig.buttonStyle.merge(
        ElButtonTheme._merge(context, style),
      ),
    );
    final currentWidget = SelectionContainer.disabled(
      child: ElHoverBuilder(
        disabled: $style.disabled!,
        builder: (isHover) => ElTapBuilder(
          onTap: onPressed,
          disabled: $style.disabled!,
          builder: (isTap) => _Button(child, style: $style),
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
        borderRadius: style!.round! || isCircle ? BorderRadius.circular(buttonHeight / 2) : style!.radius,
      ),
      child: buildChild(buttonStyle),
    );
  }

  Widget buildChild(_ElButtonStyle buttonStyle) {
    late Widget childWidget;
    if (child is Widget) {
      if (child is ElIcon) {
        childWidget = ElIconTheme(
          style: ElIconStyle(color: buttonStyle.textColor),
          child: child,
        );
      } else {
        childWidget = child;
      }
    } else {
      childWidget = ElText(
        child,
        style: ElTextStyle(
          textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            color: buttonStyle.textColor,
          ),
          strutStyle: const StrutStyle(
            forceStrutHeight: true,
          ),
        ),
      );
    }
    return childWidget;
  }
}

typedef _ElButtonStyle = ({Color? bgColor, Color? textColor, Border? border});

/// 计算按钮样式 hook
_ElButtonStyle _useButtonStyle(BuildContext context, ElButtonStyle style) {
  final bgColor = useState<Color?>(null);
  final textColor = useState<Color?>(null);
  final borderColor = useState<Color?>(null);

  final isHover = ElHoverBuilder.of(context);
  final isTap = ElTapBuilder.of(context);
  final $bgColor = context.elTheme.bgColor;

  // 计算文字按钮样式
  if (style.text!) {
    bgColor.value = $bgColor.onHover(isHover, 4).onTap(isTap, 4);
    style.type == null
        ? textColor.value = context.elTheme.textColor
        : textColor.value = context.themeTypeColors[style.type]!;

    if (style.disabled!) {
      textColor.value = textColor.value!.withOpacity(0.6);
    }
  } else {
    // 计算默认按钮样式
    if (style.type == null) {
      final primaryColor = context.elTheme.primary;
      bgColor.value = isHover || isTap ? primaryColor.elThemeLightBg(context) : $bgColor;
      textColor.value = isHover || isTap ? primaryColor : context.elTheme.textColor;
      borderColor.value = isTap
          ? primaryColor
          : isHover
              ? primaryColor.elThemeLightBorder(context)
              : context.elTheme.borderColor;
    }
    // 计算主题按钮样式
    else {
      // 镂空按钮
      if (style.plain!) {
        final primaryColor = context.themeTypeColors[style.type]!;
        textColor.value = isHover || isTap ? context.darkTheme.textColor : primaryColor;
        bgColor.value = PlatformUtil.isDesktop
            ? (isTap
                ? primaryColor.elTap(context)
                : isHover
                    ? primaryColor
                    : primaryColor.elThemeLightBg(context))
            : (isTap ? primaryColor : primaryColor.elThemeLightBg(context));
        borderColor.value = PlatformUtil.isDesktop
            ? (isTap
                ? primaryColor.elTap(context)
                : isHover
                    ? primaryColor
                    : primaryColor.elThemeLightBorder(context))
            : (isTap ? primaryColor : primaryColor.elThemeLightBorder(context));
      }
      // 主题按钮
      else {
        final primaryColor = context.themeTypeColors[style.type]!;
        textColor.value = context.darkTheme.textColor;
        bgColor.value = isTap
            ? primaryColor.elTap(context)
            : isHover
                ? primaryColor.elHover(context)
                : primaryColor;
      }
    }

    // 计算禁用样式
    if (style.disabled!) {
      if (style.type == null) {
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
