import 'package:element_extension/element_extension.dart';
import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';

class ElCloseButton extends StatelessWidget {
  const ElCloseButton({
    super.key,
    this.iconHoverColor,
    this.bgHoverColor,
    this.cursor,
    this.onTap,
  });

  /// 图标悬停颜色
  final Color? iconHoverColor;

  /// 按钮悬停背景颜色
  final Color? bgHoverColor;

  /// 鼠标悬停光标样式
  final MouseCursor? cursor;

  /// 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ElCloseButtonTheme.of(context);
    final iconTheme = ElIconTheme.of(context);
    final $iconSize = iconTheme.size ?? ElIconThemeData.theme.size!;
    final $iconHoverColor = iconHoverColor ?? theme.iconHoverColor;
    final $bgHoverColor = bgHoverColor ?? theme.bgHoverColor;

    final $size = $iconSize + 4;

    return TapWidget(
      onTapDown: (e) {
        TapWidget.stopPropagation(context);
      },
      onTap: onTap,
      child: ElHoverBuilder(
        cursor: cursor,
        builder: (context) {
          return Container(
            width: $size,
            height: $size,
            decoration: BoxDecoration(
              color: context.isHover ? $bgHoverColor : null,
              borderRadius: BorderRadius.circular($size / 2),
            ),
            child: ElIcon(
              ElIcons.close,
              color: context.isHover ? $iconHoverColor : null,
              size: $iconSize,
            ),
          );
        },
      ),
    );
  }
}
