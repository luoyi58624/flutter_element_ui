part of '../index.dart';

/// 构建按钮外观
class _ElButtonWrapper extends StatelessWidget {
  const _ElButtonWrapper({
    required this.child,
    required this.prop,
  });

  final Widget child;
  final ElButtonProp prop;

  @override
  Widget build(BuildContext context) {
    FlutterUtil.nextTick(() {
      if (prop.loading) {
        // i(context.size!.width);
      }
    });
    final $elTheme = context.elTheme;
    final $primaryColor = $elTheme.primary;
    final $defaultBorderColor = $elTheme.colors.border;
    late Color $color;
    Color? $borderColor;

    // 链接按钮
    if (prop.link) {
    }
    // 文字按钮
    else if (prop.text) {
    } else {
      // 默认按钮
      if (prop.type == null && prop.bgColor == null) {
        $color = context.isTap || context.isHover
            ? $primaryColor.themeLightBg(context)
            : $elTheme.colors.bg;

        $borderColor = context.isTap
            ? $primaryColor
            : context.isHover
                ? $primaryColor.themeLightBorder(context)
                : $defaultBorderColor;

        if (prop.disabled) {
          $borderColor = $borderColor.withOpacity(_disabledOpacity);
        }
      } else {
        // 镂空按钮
        if (prop.plain) {
        }
        // 主题按钮
        else {
          $color = context.isTap
              ? $primaryColor.tap(context)
              : context.isHover
                  ? $primaryColor.hover(context)
                  : $primaryColor;
        }
      }
    }

    return ClipRRect(
      borderRadius: prop.borderRadius,
      child: SizedBox(
        height: prop.height,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: _minWidth,
          ),
          child: ElAnimatedColoredBox(
            duration: prop.duration,
            color: $color,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: $borderColor == null
                    ? const Border()
                    : Border.all(color: $borderColor, width: 1),
                borderRadius: prop.borderRadius,
              ),
              child: Padding(
                padding: prop.padding ??
                    EdgeInsets.symmetric(horizontal: prop.height / 2),
                child: Center(child: child),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
