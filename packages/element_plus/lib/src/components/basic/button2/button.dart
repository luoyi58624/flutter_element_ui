part of 'index.dart';

class ElButton2 extends ElRawButton {
  const ElButton2({
    super.key,
    required this.child,
    super.duration,
    super.type = El.primary,
    this.bgColor,
    this.width,
    this.height,
    this.iconSize,
    this.round = false,
    this.block = false,
    super.autofocus,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  /// 子组件，如果是[Widget]，则直接渲染，否则自动渲染为文字
  final dynamic child;

  /// 自定义颜色按钮，它会覆盖 [type] 属性
  final Color? bgColor;

  /// 按钮宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 自定义图标尺寸
  final double? iconSize;

  /// 圆角按钮
  final bool round;

  /// 块级按钮，宽度会充满容器，其原理只是移除 [UnconstrainedBox] 小部件
  final bool block;

  bool get isIconChild => child is ElIcon;

  @override
  Color calcBgColor(BuildContext context, Color color) {
    return context.hasTap
        ? color.tap(context)
        : context.hasHover
            ? color.hover(context)
            : color;
  }

  @override
  Color calcTextColor(BuildContext context, Color color) {
    return color.elTextColor(context);
  }

  @override
  Widget buildWrapper(BuildContext context) {
    final $duration = context.elDuration(_duration);
    final $height = context.elConfig.size!;
    Color $bgColor = bgColor ?? context.elThemeColors[type]!;
    final $textColor = calcTextColor(context, $bgColor);
    double? $iconSize = iconSize;
    if ($iconSize == null) {
      if ($height >= 36) {
        $iconSize = $height / 2 - 2;
      } else {
        $iconSize = $height / 2;
      }
    }

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: $height,
        minWidth: width ?? (isIconChild ? $height * 1.25 : _minButtonWidth),
      ),
      child: AnimatedDecoratedBox(
        duration: $duration,
        decoration: BoxDecoration(
          color: calcBgColor(context, $bgColor),
          borderRadius: context.elConfig.radius,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: $height / 2),
          child: Center(
            child: ElAnimatedDefaultTextStyle(
              duration: $duration,
              style: TextStyle(
                color: $textColor,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              child: ElIconTheme(
                data: ElIconThemeData(size: $iconSize, color: $textColor),
                child: child is Widget ? child : ElText('$child'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);
    if (!block) {
      result = UnconstrainedBox(
        child: result,
      );
    }
    return result;
  }
}
