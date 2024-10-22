import 'package:flutter/widgets.dart';

import '../../../themes/components/basic/icon.dart';

part 'state.dart';

part 'icons.dart';

/// Element UI 图标
class ElIcon extends StatelessWidget {
  const ElIcon(
    this.child, {
    super.key,
    this.size,
    this.color,
  });

  /// 渲染图标，支持以下参数：
  /// * [IconData] 字体图标
  /// * [Widget] 自定义图标
  final dynamic child;

  /// 图标尺寸，默认 18
  final double? size;

  /// 图标颜色
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final $theme = ElIconTheme.of(context);
    final $icon = child ?? $theme.icon;
    final $size = size ?? $theme.size ?? 18;
    final $color = color ?? $theme.color;
    if ($icon is IconData) {
      return Icon($icon, size: $size, color: $color);
    } else if ($icon is Widget) {
      return UnconstrainedBox(
        child: SizedBox(
          width: $size,
          height: $size,
          child: Center(child: $icon),
        ),
      );
    } else {
      return Placeholder(
        fallbackWidth: $size,
        fallbackHeight: $size,
      );
    }
  }
}
