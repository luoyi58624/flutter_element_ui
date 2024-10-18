import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

part 'state.dart';

part 'style.dart';

part 'icons.dart';

/// Element UI 图标
class ElIcon extends StatelessWidget {
  const ElIcon(
    this.child, {
    super.key,
    this.size,
    this.color,
    this.package = 'flutter_element_ui',
  });

  /// 渲染图标，支持以下参数：
  /// * http svg 图标
  /// * asset svg 图标，如果字符串不是http，那么将直接加载 asset 下的图标
  /// * [IconData] 字体图标
  /// * [Widget] 自定义图标
  final dynamic child;

  /// icon 尺寸
  final double? size;

  /// icon 颜色
  final Color? color;

  /// 当 child 为 asset 字符串地址时，你可以指定其他库的 asset 图标资产包
  final String? package;

  @override
  Widget build(BuildContext context) {
    final $theme = ElIconTheme.maybeOf(context);
    final $icon = child ?? $theme?.icon;
    final $size = size ?? $theme?.size ?? 1.5.rem(context);
    final $color = color ?? $theme?.color ?? context.elTheme.iconColor;
    if ($icon is IconData) {
      return Icon($icon, size: $size, color: $color);
    } else if ($icon is Widget) {
      return UnconstrainedBox(
        child:
            SizedBox(width: $size, height: $size, child: Center(child: $icon)),
      );
    } else {
      return Placeholder(fallbackWidth: $size, fallbackHeight: $size);
    }
  }
}
