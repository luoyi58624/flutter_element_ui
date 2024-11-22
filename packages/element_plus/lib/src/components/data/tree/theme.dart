part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '标签默认样式')
class ElTreeThemeData {
  static const theme = ElTreeThemeData();
  static const darkTheme = ElTreeThemeData();

  const ElTreeThemeData({
    this.duration,
    this.curve,
    this.type,
    this.icon,
    this.width,
    this.height,
    this.bgColor,
    this.textColor,
    this.textSize,
    this.iconColor,
    this.iconSize,
    this.plain,
    this.round,
    this.closable,
    this.borderRadius,
    this.padding,
  });

  /// 动画持续时间
  final Duration? duration;

  /// 动画曲线
  final Curve? curve;

  /// 主题类型，默认 [El.primary]
  final String? type;

  /// 标签左图标
  final Widget? icon;

  /// 标签最小宽度
  final double? width;

  /// 标签高度，默认 28
  final double? height;

  /// 自定义标签背景颜色，此属性会替代 [type]
  final Color? bgColor;

  /// 文字颜色
  final Color? textColor;

  /// 文字大小，默认 12
  final double? textSize;

  /// 图标颜色
  final Color? iconColor;

  /// 图标大小，默认 18
  final double? iconSize;

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
}
