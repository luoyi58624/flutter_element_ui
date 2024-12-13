import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

part 'icons.dart';

part 'theme.dart';

part '../../../generates/components/basic/icon/index.g.dart';

/// Element UI 图标
class ElIcon extends Icon {
  const ElIcon(
    this.child, {
    super.key,
    super.size,
    super.color,
  }) : super(null);

  /// 渲染图标，支持以下参数：
  /// * [IconData] 字体图标
  /// * [Widget] 自定义图标
  final dynamic child;

  @override
  Widget build(BuildContext context) {
    final commonSizePreset = context.commonSizePreset;
    final $theme = ElIconTheme.of(context);
    final $icon = child ?? $theme.icon;
    final $size = size ?? $theme.size ?? commonSizePreset.iconSize!;
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
