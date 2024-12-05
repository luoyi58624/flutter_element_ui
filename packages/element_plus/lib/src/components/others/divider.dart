import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';

class ElDivider extends StatelessWidget {
  const ElDivider({
    super.key,
    this.vertical = false,
    this.size,
    this.thickness = 0.5,
    this.indent = 0,
    this.color,
  });

  /// 是否为垂直分割线
  final bool vertical;

  /// 分割线实际占据的空间大小，默认跟随[thickness]
  final double? size;

  /// 分割线的线条粗细程度
  final double thickness;

  /// 分割线从什么位置开始绘制
  final double indent;

  /// 自定义分割线的颜色
  final Color? color;

  /// 构建列表分割线widget
  static IndexedWidgetBuilder buildSeparatorWidget(
    BuildContext context, {
    double indent = 0,
    Color? color,
  }) {
    return (ctx, index) => ElDivider(indent: indent, color: color);
  }

  @override
  Widget build(BuildContext context) {
    return vertical
        ? VerticalDivider(
            width: size ?? thickness,
            thickness: thickness,
            indent: indent,
            color: color ?? context.elLayout.borderColor!,
          )
        : Divider(
            height: size ?? thickness,
            thickness: thickness,
            indent: indent,
            color: color ?? context.elLayout.borderColor!,
          );
  }
}
