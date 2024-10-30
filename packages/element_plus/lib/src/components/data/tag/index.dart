import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

const _minWidth = 56.0;
const _height = 28.0;
const _padding = EdgeInsets.symmetric(horizontal: 12);
const _hasClosablePadding = EdgeInsets.only(
  left: 12,
  right: 6,
);

class ElTag extends StatelessWidget {
  const ElTag(
    this.text, {
    super.key,
    this.type,
    this.width,
    this.height,
    this.bgColor,
    this.textStyle,
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

  /// 标签高度
  final double? height;

  /// 自定义标签背景颜色，此属性会替代 [type]
  final Color? bgColor;

  /// 自定义文本样式
  final TextStyle? textStyle;

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
    final theme = ElTagTheme.maybeOf(context) ?? context.elTheme.tagTheme;
    final $type = type ?? theme.type ?? El.primary;
    final $bgColor = bgColor ?? theme.bgColor ?? context.elThemeColors[$type]!;
    final $plain = plain ?? theme.plain ?? false;
    final $round = round ?? theme.round ?? false;
    final $width = width ?? theme.width ?? _minWidth;
    final $height = height ?? theme.height ?? _height;
    final $closable = closable ?? theme.closable ?? false;
    final $borderRadius = $round
        ? BorderRadius.circular($height / 2)
        : borderRadius ?? theme.borderRadius ?? context.elConfig.radius;
    final $padding = padding ??
        theme.padding ??
        ($closable ? _hasClosablePadding : _padding);
    final $textStyle = TextStyle(
      color: $plain ? $bgColor : $bgColor.elTextColor(context),
      fontSize: 12,
    ).merge(textStyle ?? theme.textStyle);

    return UnconstrainedBox(
      child: AnimatedContainer(
        duration: context.elDuration(),
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
        child: Center(
          child: Row(
            children: [
              ElAnimatedDefaultTextStyle(
                style: $textStyle,
                child: ElText(text),
              ),
              if ($closable)
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: ElAnimatedIconTheme(
                    data: ElIconThemeData(
                      color: $textStyle.color,
                    ),
                    child: ElCloseButton(
                      cursor: SystemMouseCursors.click,
                      iconHoverColor: $plain
                          ? $bgColor.elTextColor(context)
                          : $textStyle.color,
                      bgHoverColor: $plain ? $bgColor : $bgColor.deepen(25),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
