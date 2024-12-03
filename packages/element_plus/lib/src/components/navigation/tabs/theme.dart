part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '标签容器默认样式')
class ElTabsThemeData {
  static const theme = ElTabsThemeData(
    size: 28,
    direction: AxisDirection.right,
    bgColor: Color.fromRGBO(227, 227, 227, 1.0),
    hoverBgColor: Color.fromRGBO(199, 199, 199, 1.0),
    activeBgColor: Color.fromRGBO(255, 255, 255, 1.0),
  );
  static const darkTheme = ElTabsThemeData(
    size: 28,
    direction: AxisDirection.right,
    bgColor: Color.fromRGBO(60, 63, 65, 1.0),
    hoverBgColor: Color.fromRGBO(39, 41, 42, 1.0),
    activeBgColor: Color.fromRGBO(79, 82, 84, 1.0),
  );

  const ElTabsThemeData({
    this.builderWrapper,
    this.builderScrollbar,
    this.size,
    this.direction,
    this.bgColor,
    this.hoverBgColor,
    this.activeBgColor,
    this.textColor,
    this.hoverTextColor,
    this.activeTextColor,
    this.padding,
    this.itemGap,
    this.enabledDrag,
    this.dragDelay,
    this.autoScrollerVelocityScalar,
    this.dragProxyDecorator,
  });

  /// 自定义构建标签容器外观
  final ElWidgetBuilder? builderWrapper;

  /// 自定义构建标签滚动条
  final ElScrollbarBuilder? builderScrollbar;

  /// 标签容器尺寸，默认 28
  final double? size;

  /// 标签方向
  final AxisDirection? direction;

  /// 标签背景颜色
  final Color? bgColor;

  /// 标签悬停背景颜色
  final Color? hoverBgColor;

  /// 标签激活背景颜色
  final Color? activeBgColor;

  /// 标签文字颜色
  final Color? textColor;

  /// 标签悬停文字颜色
  final Color? hoverTextColor;

  /// 标签激活文字颜色
  final Color? activeTextColor;

  /// 标签容器内边距，默认 0
  final EdgeInsets? padding;

  /// 子标签之间的间距，默认 0
  final double? itemGap;

  /// 开启拖拽排序，默认 false
  final bool? enabledDrag;

  /// 触发拖拽延迟时间，默认 100 毫秒，移动端目前强制为长按触发：[kLongPressTimeout]
  final Duration? dragDelay;

  /// 拖拽到临界点时自动滚动速率，默认 100
  final double? autoScrollerVelocityScalar;

  /// 自定义拖拽代理
  final ReorderItemProxyDecorator? dragProxyDecorator;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
