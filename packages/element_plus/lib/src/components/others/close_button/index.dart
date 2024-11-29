import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

part 'theme.dart';

part '../../../generates/components/others/close_button/index.g.dart';

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

    return ElStopPropagation(
      child: ElEvent(
        cursor: cursor ?? theme.cursor,
        onTap: onTap,
        builder: (context) {
          return Container(
            width: $size,
            height: $size,
            decoration: BoxDecoration(
              color: context.hasHover ? $bgHoverColor : null,
              borderRadius: BorderRadius.circular($size / 2),
            ),
            child: ElIcon(
              ElIcons.close,
              color: context.hasHover ? $iconHoverColor : null,
              size: $iconSize,
            ),
          );
        },
      ),
    );
  }
}
