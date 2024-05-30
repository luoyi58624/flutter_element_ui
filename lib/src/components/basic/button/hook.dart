part of flutter_element_ui;

typedef _BaseButtonStyle = ({Color? bgColor, Color? textColor, Border? border});
typedef _TextButtonStyle = ({Color? bgColor, Color? textColor});

/// 计算基础按钮样式 Hook
_BaseButtonStyle _useBaseButtonStyle(
  BuildContext context, {
  ElThemeType? type,
  bool plain = false,
  bool disabled = false,
}) {
  final bgColor = useState<Color?>(null);
  final textColor = useState<Color?>(null);
  final borderColor = useState<Color?>(null);

  final isHover = HoverBuilder.of(context);
  final isTap = TapBuilder.of(context);

  // 计算默认按钮样式
  if (type == null) {
    final primaryColor = context.elTheme.primary;
    bgColor.value = isHover || isTap ? primaryColor.elThemeLightBg(context) : context.elTheme.mainColor;
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
    if (plain) {
      final primaryColor = context.themeTypeColors[type]!;
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
      final primaryColor = context.themeTypeColors[type]!;
      textColor.value = context.darkTheme.textColor;
      bgColor.value = isTap
          ? primaryColor.elTap(context)
          : isHover
              ? primaryColor.elHover(context)
              : primaryColor;
    }
  }

  // 计算禁用样式
  if (disabled) {
    if (type == null) {
      textColor.value = textColor.value!.withOpacity(0.6);
      borderColor.value = borderColor.value!.withOpacity(0.6);
    } else {
      if (plain) {
        bgColor.value = bgColor.value!.withOpacity(0.6);
        textColor.value = textColor.value!.withOpacity(0.6);
        borderColor.value = borderColor.value!.withOpacity(0.6);
      } else {
        bgColor.value = bgColor.value!.withOpacity(0.6);
        textColor.value = textColor.value!.withOpacity(0.9);
      }
    }
  }

  return (
    bgColor: bgColor.value,
    textColor: textColor.value,
    border: borderColor.value != null ? Border.all(color: borderColor.value!) : null
  );
}

/// 计算文字按钮样式 Hook
_TextButtonStyle _useTextButtonStyle(
  BuildContext context, {
  ElThemeType? type,
  bool disabled = false,
}) {
  final bgColor = useState<Color?>(null);
  final textColor = useState<Color?>(null);

  final isHover = HoverBuilder.of(context);
  final isTap = TapBuilder.of(context);

  final mainColor = context.elTheme.mainColor;

  bgColor.value = mainColor.onHover(isHover, 4).onTap(isTap, 4);
  type == null ? textColor.value = context.elTheme.textColor : textColor.value = context.themeTypeColors[type]!;

  if (disabled) {
    textColor.value = textColor.value!.withOpacity(0.6);
  }

  return (bgColor: bgColor.value, textColor: textColor.value);
}
