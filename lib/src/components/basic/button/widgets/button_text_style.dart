part of '../index.dart';

/// 构建按钮文本样式
class _ElButtonTextStyle extends StatelessWidget {
  const _ElButtonTextStyle({
    required this.child,
    required this.bgColor,
    required this.type,
    required this.text,
    required this.plain,
    required this.link,
    required this.disabled,
  });

  final Widget child;
  final Color? bgColor;
  final String? type;
  final bool text;
  final bool plain;
  final bool link;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final $elTheme = context.elTheme;
    late Color $color;
    // 链接按钮
    if (link) {
      $color = (type == null
              ? $elTheme.colors.regularText
              : context.elThemeColors[type]!)
          .buildEventColor(
        context,
        tapBuilder: (color) => color.tap(context),
        hoverBuilder: (color) => color.withOpacity(_disabledOpacity),
      );
    }
    // 文字按钮
    else if (text) {
      $color = type == null
          ? context.elThemeColors[type]!
          : $elTheme.colors.regularText;
      if (disabled) $color = $color.withOpacity(_textButtonDisabledOpacity);
    } else {
      // 默认按钮
      if (type == null && bgColor == null) {
        $color = context.isTap || context.isHover
            ? $elTheme.primary
            : $elTheme.colors.regularText;
        if (disabled) $color = $color.withOpacity(_textButtonDisabledOpacity);
      } else {
        // 镂空按钮
        if (plain) {
          $color = context.isTap || context.isHover
              ? context.elThemeColors[type]!.elTextColor(context)
              : $elTheme.colors.regularText;
        }
        // 主题按钮
        else {
          $color = context.elThemeColors[type]!.elTextColor(context);
        }
      }
    }
    return ElDefaultTextStyle.merge(
      style: TextStyle(
        fontSize: 15,
        fontWeight: ElFont.medium,
        color: $color,
      ),
      child: child,
    );
  }
}
