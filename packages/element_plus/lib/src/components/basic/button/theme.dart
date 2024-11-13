part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '按钮默认样式')
class ElButtonThemeData {
  static const theme = ElButtonThemeData();
  static const darkTheme = ElButtonThemeData();

  const ElButtonThemeData({
    this.child,
    this.duration,
    this.width,
    this.height,
    this.bgColor,
    this.color,
    this.type,
    this.text,
    this.bg,
    this.link,
    this.plain,
    this.round,
    this.block,
    this.borderWidth,
    this.borderActiveWidth,
    this.borderRadius,
    this.padding,
    this.iconSize,
    this.leftIcon,
    this.rightIcon,
    this.circle,
    this.loadingWidget,
    this.loadingBuilder,
  });

  /// 按钮默认内容
  final dynamic child;

  /// 过渡时间，默认 100 毫秒，因为按钮存在快速点击，所以建议不要超过 100 毫秒，防止动画呆滞
  final Duration? duration;

  /// 按钮默认宽度，如果是按钮组，[ElButton] 的 block、link、circle 等属性将不会影响指定的宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 按钮背景颜色
  final Color? bgColor;

  /// 文字、图标颜色
  final Color? color;

  /// 主题类型
  final String? type;

  /// 文字按钮
  final bool? text;

  /// 文字按钮是否添加默认背景
  final bool? bg;

  /// 链接按钮，相比文字按钮，它没有任何边距、以及宽高
  final bool? link;

  /// 镂空按钮
  final bool? plain;

  /// 圆角按钮
  final bool? round;

  /// 块级按钮，宽度会充满容器，其原理只是移除 [UnconstrainedBox] 小部件
  final bool? block;

  /// 边框宽度
  final double? borderWidth;

  /// 边框激活宽度：悬停、点击、选中
  final double? borderActiveWidth;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 按钮内边距，默认为高度的一半
  final EdgeInsetsGeometry? padding;

  /// 图标尺寸，默认根据按钮高度自动计算，当自定义各种尺寸按钮时自动计算出来的效果往往不是很好，
  /// 这时你可以自己手动微调图标大小。
  final double? iconSize;

  /// 按钮左图标
  final Widget? leftIcon;

  /// 按钮右图标
  final Widget? rightIcon;

  /// 圆形按钮
  final bool? circle;

  /// loading 图标小部件
  final Widget? loadingWidget;

  /// loading 构建器，它会替代 [loadingWidget]，其特点是背景颜色固定为灰色、同时隐藏原有内容，只展示用户构建的 Widget
  final Widget Function(ElButtonLoadingState state)? loadingBuilder;
}

class ElButtonLoadingState {
  /// 按钮 loading 颜色，它的颜色跟随图标的文字颜色
  final Color color;

  /// 按钮 loading 尺寸，它的大小和图标一致
  final double size;

  ElButtonLoadingState({
    required this.color,
    required this.size,
  });
}
