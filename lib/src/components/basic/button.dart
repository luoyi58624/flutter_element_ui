import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:flutter_element_ui/src/extensions/private.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../services/service.dart';
import '../../utils/assert.dart';
import '../../utils/font.dart';
import 'text.dart';
import 'icon.dart';

typedef _ButtonStyleProp = ({
  double? width,
  double height,
  Color? bgColor,
  Color? color,
  String? type,
  bool text,
  bool link,
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
  const ElButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.bgColor,
    this.color,
    this.type,
    this.text = false,
    this.link = false,
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

  /// 指定按钮宽度，如果[block]或[circle]为true，那么将失效
  final double? width;

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

  /// 链接按钮，默认false，若为true，[child]将强制渲染成文字
  final bool link;

  /// 镂空按钮，默认false
  final bool plain;

  /// 圆角按钮，默认false
  final bool round;

  /// 块级按钮，宽度会充满容器，默认false
  final bool block;

  /// 自定义圆角
  final BorderRadiusGeometry? borderRadius;

  /// 自定义外边距
  final EdgeInsetsGeometry? margin;

  /// 自定义内边距
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
    ElAssert.themeType(type, 'ElButton');
    final elConfig = el.config;
    final defaultStyle = elConfig.buttonStyle;
    final buttonHeight = height ?? defaultStyle.height;
    _ButtonStyleProp styleProp = (
      width: width,
      height: buttonHeight,
      bgColor: bgColor,
      color: color,
      type: type,
      text: text,
      link: link,
      plain: plain,
      round: round,
      block: block,
      borderRadius:
          borderRadius ?? defaultStyle.borderRadius ?? elConfig.radius,
      margin: margin ?? defaultStyle.margin,
      padding: padding ??
          defaultStyle.padding ??
          EdgeInsets.symmetric(horizontal: buttonHeight / 2),
      leftIcon: leftIcon,
      rightIcon: rightIcon,
      circle: circle,
      disabled: disabled,
      loading: loading,
    );
    var currentWidget = SelectionContainer.disabled(
      child: Focus(
        child: HoverBuilder(
          disabled: disabled,
          cursor: SystemMouseCursors.click,
          builder: (context) => TapBuilder(
            onTap: onPressed,
            disabled: disabled,
            builder: (context) => _Button(child, styleProp),
          ),
        ),
      ),
    );
    return Padding(
      padding: styleProp.margin ?? EdgeInsets.zero,
      child: block && !circle
          ? currentWidget
          : UnconstrainedBox(child: currentWidget),
    );
  }
}

class _Button extends HookWidget {
  const _Button(this.child, this.styleProp);

  final dynamic child;
  final _ButtonStyleProp styleProp;

  /// child类型为基础类型
  bool get isBaseType => child == null || DartUtil.isBaseType(child);

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _useButtonStyle(context, styleProp);
    final $padding =
        styleProp.circle || styleProp.link ? null : styleProp.padding;
    final $constraints = styleProp.link
        ? null
        : BoxConstraints(
            minHeight: styleProp.height,
            minWidth:
                (styleProp.circle ? styleProp.height : styleProp.width) ?? 0,
          );
    final $decoration = BoxDecoration(
      color: buttonStyle.bgColor,
      border: buttonStyle.border,
      borderRadius: styleProp.round || styleProp.circle
          ? BorderRadius.circular(styleProp.height / 2)
          : styleProp.borderRadius,
    );

    return AnimatedContainer(
      duration: 100.ms,
      constraints: $constraints,
      alignment: Alignment.center,
      padding: $padding,
      decoration: $decoration,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 15,
          fontWeight: ElFont.medium,
          color: buttonStyle.textColor,
        ),
        child: buildChild(buttonStyle),
      ),
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
        '$child',
        strutStyle: const StrutStyle(forceStrutHeight: true),
      );
    }

    if (styleProp.leftIcon != null || styleProp.rightIcon != null) {
      childWidget = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (styleProp.leftIcon != null)
            buildIcon(styleProp.leftIcon!, buttonStyle),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: childWidget),
          if (styleProp.rightIcon != null)
            buildIcon(styleProp.rightIcon!, buttonStyle)
        ],
      );
    }
    return childWidget;
  }

  Widget buildIcon(Widget iconWidget, _ButtonStyleHook buttonStyle) {
    return ElIconTheme(
      color: buttonStyle.textColor,
      size: styleProp.height / 2 - 2,
      child: iconWidget,
    );
  }
}

typedef _ButtonStyleHook = ({Color? bgColor, Color? textColor, Border? border});

/// 改变按钮透明度样式值
const double _opacity = 0.6;

extension _ButtonColorExtension on Color {
  /// hover 悬停颜色，颜色会变得更浅
  Color hover(BuildContext context) => light2(context);

  /// tap 按下颜色，颜色会变得更深
  Color tap(BuildContext context) => light3(context, reverse: true);

  /// 应用主题透明背景颜色
  Color themeLightBg(BuildContext context) => light9(context);

  /// 应用主题透明边框颜色
  Color themeLightBorder(BuildContext context) => light6(context);
}

/// 计算按钮样式 hook
_ButtonStyleHook _useButtonStyle(BuildContext context, _ButtonStyleProp style) {
  final bgColor = useState<Color?>(null);
  final textColor = useState<Color?>(null);
  final borderColor = useState<Color?>(null);

  final $isHover = HoverBuilder.of(context);
  final $isTap = TapBuilder.of(context);
  final $bgColor = context.elTheme.bgColor;
  final $isThemeType = el.themeTypes.contains(style.type);
  final $defaultTextColor =
      context.elTheme.textColor.deepen(context.isDark ? 0 : 24);
  Color? $themeTypeColor;
  if ($isThemeType) $themeTypeColor = context.elThemeColors[style.type]!;

  if (style.link) {
    $isThemeType
        ? textColor.value = $themeTypeColor!
            .on($isHover, color: $themeTypeColor.withOpacity(_opacity))
            .on($isTap, color: $themeTypeColor.tap(context))
        : textColor.value = $defaultTextColor
            .on($isHover, color: $defaultTextColor.withOpacity(_opacity))
            .on($isTap, color: $defaultTextColor.tap(context));
    borderColor.value = null;
    if (style.disabled) {
      textColor.value = textColor.value!.withOpacity(_opacity);
    }
  }
  // 计算文字按钮样式
  else if (style.text) {
    bgColor.value = $bgColor
        .on($isHover, color: $bgColor.deepen(4))
        .on($isTap, color: $bgColor.deepen(10));
    $isThemeType
        ? textColor.value = context.elThemeColors[style.type]!
        : textColor.value = $defaultTextColor;
    borderColor.value = null;
    if (style.disabled) {
      textColor.value = textColor.value!.withOpacity(_opacity);
    }
  } else {
    // 计算默认按钮样式
    if ($isThemeType == false && style.bgColor == null) {
      final $primaryColor = context.elTheme.primary;
      bgColor.value =
          $isHover || $isTap ? $primaryColor.themeLightBg(context) : $bgColor;
      textColor.value = $isHover || $isTap ? $primaryColor : $defaultTextColor;
      borderColor.value = $isTap
          ? $primaryColor
          : $isHover
              ? $primaryColor.themeLightBorder(context)
              : context.elTheme.borderColor;
    }
    // 计算主题按钮样式
    else {
      final $primaryColor = style.bgColor ?? context.elThemeColors[style.type]!;
      final $textColor = style.color ??
          (style.bgColor == null
              ? el.darkTheme.textColor
              : style.bgColor!.elTextColor(context));
      // 镂空按钮
      if (style.plain) {
        textColor.value = $isHover || $isTap ? $textColor : $primaryColor;
        bgColor.value = PlatformUtil.isDesktop
            ? ($isTap
                ? $primaryColor.tap(context)
                : $isHover
                    ? $primaryColor
                    : $primaryColor.themeLightBg(context))
            : ($isTap ? $primaryColor : $primaryColor.themeLightBg(context));
        borderColor.value = PlatformUtil.isDesktop
            ? ($isTap
                ? $primaryColor.tap(context)
                : $isHover
                    ? $primaryColor
                    : $primaryColor.themeLightBorder(context))
            : ($isTap
                ? $primaryColor
                : $primaryColor.themeLightBorder(context));
      }
      // 主题按钮
      else {
        textColor.value = $textColor;
        bgColor.value = $isTap
            ? $primaryColor.tap(context)
            : $isHover
                ? $primaryColor.hover(context)
                : $primaryColor;
        borderColor.value = null;
      }
    }

    // 计算禁用样式
    if (style.disabled) {
      if ($isThemeType == false && style.bgColor == null) {
        textColor.value = textColor.value!.withOpacity(_opacity);
        borderColor.value = borderColor.value!.withOpacity(_opacity);
      } else {
        if (style.plain) {
          bgColor.value = bgColor.value!.withOpacity(_opacity);
          textColor.value = textColor.value!.withOpacity(_opacity);
          borderColor.value = borderColor.value!.withOpacity(_opacity);
        } else {
          bgColor.value = bgColor.value!.withOpacity(_opacity);
          textColor.value = textColor.value!.isDark
              ? textColor.value!.withOpacity(_opacity)
              : textColor.value!.withOpacity(0.9);
        }
      }
    }
  }

  return (
    bgColor: bgColor.value,
    textColor: textColor.value,
    border: borderColor.value != null
        ? Border.all(
            color: borderColor.value!,
            width: 1,
            // strokeAlign: BorderSide.strokeAlignOutside,
          )
        : null
  );
}
