part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '分割器默认样式')
class ElSplitResizerThemeData {
  static const _defaultTheme = ElSplitResizerThemeData(
    axis: Axis.vertical,
    size: 0,
    triggerSize: 4,
    position: ElSplitPosition.center,
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
    this.onChanged,
    this.onEnd,
  });

  /// 分割器方向，默认垂直
  final Axis? axis;

  /// 控件占据页面的空间，默认 0
  final double? size;

  /// 可拖拽控件触发范围，默认 4
  final double? triggerSize;

  /// 控件颜色，默认全局边框颜色，当 [size] 大于 0 时绘制
  final Color? color;

  /// 拖拽激活颜色，默认 null
  final Color? activeColor;

  /// 分割条触发位置，默认居中。
  ///
  /// 如果你设置了较大触发范围，可能会遮挡了页面中的滚动条，你可以设置此参数调整触发位置。
  final ElSplitPosition? position;

  /// 分割器拖拽偏移
  final ValueChanged<double>? onChanged;

  /// 分割器结束拖拽
  final VoidCallback? onEnd;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
