part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '按钮默认样式')
class ElButton2ThemeData {
  static const _defaultTheme = ElButton2ThemeData(
    round: false,
    block: false,
  );
  static const theme = _defaultTheme;
  static const darkTheme = _defaultTheme;

  const ElButton2ThemeData({
    this.type,
    this.bgColor,
    this.width,
    this.height,
    this.round,
    this.block,
  });

  final String? type;
  final Color? bgColor;
  final double? width;
  final double? height;
  final bool? round;
  final bool? block;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}

class ElButton2 extends ElRawButton {
  const ElButton2({
    super.key,
    required super.child,
    super.duration,
    this.type,
    this.bgColor,
    this.width,
    this.height,
    this.round,
    this.block,
    super.autofocus,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  /// 主题类型
  final String? type;

  /// 自定义颜色按钮
  final Color? bgColor;

  /// 按钮宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 圆角按钮
  final bool? round;

  /// 块级按钮，宽度会充满容器，其原理只是移除 [UnconstrainedBox] 小部件，
  /// 所以，块级按钮的宽度将由父级约束决定
  final bool? block;

  Color _calcBgColor(BuildContext context, Color $color) {
    return context.hasTap
        ? $color.tap(context)
        : context.hasHover
            ? $color.hover(context)
            : $color;
  }

  @override
  Widget buildWrapper(BuildContext context) {
    final themeData = ElButton2Theme.of(context).copyWith(
      type: type,
      bgColor: bgColor,
      width: width,
      height: height,
      round: round,
      block: block,
    );
    final $duration = context.elDuration(const Duration(milliseconds: 100));
    final $height = context.elConfig.size!;
    Widget result = child is Widget ? child : ElText('$child');

    Color $bgColor = themeData.bgColor ??
        (themeData.type == null
            ? context.elTheme.primary
            : context.elThemeColors[themeData.type]!);

    result = UnconstrainedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: $height,
        ),
        child: AnimatedDecoratedBox(
          duration: $duration,
          decoration: BoxDecoration(
            color: _calcBgColor(context, $bgColor),
            borderRadius: context.elConfig.radius,
          ),
          child: ElAnimatedDefaultTextStyle(
            duration: $duration,
            style: TextStyle(
              color: $bgColor.elTextColor(context),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: $height / 2),
              child: Center(
                child: result,
              ),
            ),
          ),
        ),
      ),
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    Widget result = super.build(context);
    if (block == true) {
      result = UnconstrainedBox(
        child: result,
      );
    }
    return result;
  }
}
