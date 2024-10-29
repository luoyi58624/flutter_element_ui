import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

class ElTag extends StatelessWidget {
  const ElTag(
    this.text, {
    super.key,
    this.type,
    this.width,
    this.height,
    this.bgColor,
    this.color,
    this.plain,
    this.round,
    this.closable,
    this.borderRadius,
    this.padding,
    this.onTap,
    this.onClose,
  });

  /// 标签文字信息
  final String text;

  /// 主题类型，默认 [El.primary]
  final String? type;

  /// 标签最小宽度
  final double? width;

  /// 标签高度，默认 28
  final double? height;

  /// 自定义标签背景颜色，此属性会替代 [type]
  final Color? bgColor;

  /// 文字、图标颜色，如果为空，则根据 [bgColor] 自动计算
  final Color? color;

  /// 镂空标签
  final bool? plain;

  /// 圆角标签
  final bool? round;

  /// 是否可关闭
  final bool? closable;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 自定义内边距
  final EdgeInsetsGeometry? padding;

  /// 点击事件
  final void Function()? onTap;

  /// 点击关闭按钮事件
  final void Function()? onClose;

  @override
  Widget build(BuildContext context) {
    final tagTheme = ElTagTheme.of(context);
    final $type = type ?? tagTheme.type ?? El.primary;
    final $bgColor =
        bgColor ?? tagTheme.bgColor ?? context.elThemeColors[$type]!;
    final $plain = plain ?? tagTheme.plain ?? false;
    final $round = round ?? tagTheme.round ?? false;
    final $width = width ?? tagTheme.width ?? 56;
    final $height = height ?? tagTheme.height ?? 28;
    final $closable = closable ?? tagTheme.closable ?? false;
    final $borderRadius = $round
        ? BorderRadius.circular($height / 2)
        : borderRadius ?? tagTheme.borderRadius ?? context.elConfig.radius;
    final $padding = padding ??
        tagTheme.padding ??
        const EdgeInsets.symmetric(horizontal: 12);

    Widget result = Row(
      children: [
        ElText(
          text,
          style: TextStyle(
            color: $plain ? $bgColor : $bgColor.elTextColor(context),
            fontSize: 14,
          ),
          strutStyle: const StrutStyle(
            forceStrutHeight: true,
          ),
        ),
      ],
    );

    result = UnconstrainedBox(
      child: Container(
        constraints: BoxConstraints(
          minWidth: $width,
          minHeight: $height,
          maxHeight: $height,
        ),
        padding: $padding,
        decoration: BoxDecoration(
          color: $plain ? $bgColor.elLight9(context) : $bgColor,
          borderRadius: $borderRadius,
          border: Border.all(color: $bgColor, width: 1),
        ),
        child: Center(child: result),
      ),
    );

    return result;
  }
}
