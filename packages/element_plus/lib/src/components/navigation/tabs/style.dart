part of 'index.dart';

@ElModel.copy()
@ElThemeDataModel()
class ElTabsThemeData {
  const ElTabsThemeData({
    this.size,
    this.padding,
    this.itemGap,
    this.enabledDrag,
    this.dragDelay,
    this.direction,
  });

  /// 标签容器尺寸，默认 50
  final double? size;

  /// 标签容器内边距，默认 0
  final EdgeInsets? padding;

  /// 子标签之间的间距，默认 0
  final double? itemGap;

  /// 开启拖拽排序，默认 false
  final bool? enabledDrag;

  /// 触发拖拽延迟时间，默认 100 毫秒
  final Duration? dragDelay;

  /// 标签方向
  final AxisDirection? direction;
}