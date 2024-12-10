part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '分割器默认样式')
class ElSplitResizerThemeData {
  static const _defaultTheme = ElSplitResizerThemeData(
    axis: Axis.vertical,
    size: 0,
    triggerSize: 4,
    position: ElSplitPosition.center,
    rootOverlay: true,
  );
  static const theme = _defaultTheme;
  static const darkTheme = _defaultTheme;

  const ElSplitResizerThemeData({
    this.axis,
    this.size,
    this.triggerSize,
    this.color,
    this.activeColor,
    this.position,
    this.rootOverlay,
  });

  /// 分割器方向，默认垂直
  final Axis? axis;

  /// 控件占据页面的空间，默认 0
  final double? size;

  /// 可拖拽控件触发范围，默认 4。
  ///
  /// 注意：[triggerSize] 必须大于 [size]，否则会抛出异常。
  final double? triggerSize;

  /// 控件颜色，默认全局边框颜色，当 [size] 大于 0 时绘制
  final Color? color;

  /// 拖拽激活颜色，默认 null，如果 [triggerSize] 过大，则不建议显示它，会显得很突兀
  final Color? activeColor;

  /// 分割条触发位置，默认居中。
  ///
  /// 如果你设置了较大触发范围，可能会遮挡了页面中的滚动条，你可以设置此参数调整触发位置。
  final ElSplitPosition? position;

  /// 分隔条是否作用于顶级 [Overlay]，默认 true。
  ///
  /// 如果没有在顶级 [Overlay] 插入，操作 [MaterialApp] 任意属性时分割器的事件将会丢失，
  /// 这个问题似乎是 [Overlay] 的 bug。
  final bool? rootOverlay;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
