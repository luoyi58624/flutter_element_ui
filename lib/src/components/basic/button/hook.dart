part of flutter_element_ui;

typedef _BaseButtonStyle = ({Color? bgColor, Color? textColor, Border? border});
typedef _TextButtonStyle = ({Color? bgColor, Color? textColor});

/// 计算基础按钮样式 Hook
_BaseButtonStyle _useBaseButtonStyle(BuildContext context, {ElThemeType? type}) {
  final bgColor = useState<Color?>(null);
  final textColor = useState<Color?>(null);
  final border = useState<Border?>(null);

  final isHover = ElHoverBuilder.of(context);
  final isTap = ElTapBuilder.of(context);

  if (type == null) {
    final primaryColor = context.elTheme.primary;
    bgColor.value = isHover ? primaryColor.withOpacity(0.1) : Colors.transparent;
    textColor.value = isHover ? primaryColor : context.elTheme.textColor;
    Color borderColor = isTap
        ? primaryColor
        : isHover
            ? primaryColor.withOpacity(0.38)
            : context.elTheme.borderColor;
    border.value = Border.all(color: borderColor);
  } else {
    final primaryColor = context.themeColors[type]!;
    textColor.value = context.darkTheme.textColor;
    bgColor.value = isTap
        ? primaryColor.darken(16)
        : isHover
            ? primaryColor.brighten(16)
            : primaryColor;
  }

  return (bgColor: bgColor.value, textColor: textColor.value, border: border.value);
}

/// 计算文字按钮样式 Hook
_TextButtonStyle _useTextButtonStyle(BuildContext context, {ElThemeType? type}) {
  final bgColor = useState<Color?>(null);
  final textColor = useState<Color?>(null);

  final isHover = ElHoverBuilder.of(context);
  final isTap = ElTapBuilder.of(context);

  bgColor.value = context.elTheme.mainColor.onHover(context, isHover).onTap(context, isTap);
  type == null ? textColor.value = context.elTheme.textColor : textColor.value = context.themeColors[type]!;

  return (bgColor: bgColor.value, textColor: textColor.value);
}
