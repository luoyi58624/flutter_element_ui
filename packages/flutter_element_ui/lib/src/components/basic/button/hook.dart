part of 'button.dart';

typedef _ElButtonStyle = ({Color? bgColor, Color? textColor, Border? border});

/// 计算按钮样式 hook，抽离 hook 并非一定要是公用逻辑，只是为了核心逻辑更加简洁
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
