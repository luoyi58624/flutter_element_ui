import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';

class ElCloseButton extends StatelessWidget {
  const ElCloseButton({
    super.key,
    this.size,
    this.iconSize,
    this.cursor,
  });

  /// 关闭按钮尺寸
  final double? size;

  /// 图标尺寸
  final double? iconSize;

  /// 鼠标悬停光标样式
  final MouseCursor? cursor;

  @override
  Widget build(BuildContext context) {
    final $size = size ?? 16;
    final $iconSize = iconSize ?? 12;
    return ElHoverBuilder(
      cursor: cursor,
      builder: (context) {
        return Container(
          width: $size,
          height: $size,
          decoration: BoxDecoration(
            color: context.isHover ? context.elAnimatedTheme.info : null,
            borderRadius: BorderRadius.circular($size / 2),
          ),
          child: ElIcon(
            ElIcons.close,
            size: $iconSize,
          ),
        );
      },
    );
  }
}
