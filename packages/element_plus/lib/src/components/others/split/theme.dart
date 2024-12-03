part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '分割器默认样式')
class ElSplitThemeData {
  static const _defaultTheme = ElSplitThemeData(
    axis: Axis.vertical,
    size: 0,
    triggerSize: 10,
    position: ElSplitPosition.center,
  );
  static const theme = _defaultTheme;
  static const darkTheme = _defaultTheme;

  const ElSplitThemeData({
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

  /// 控件占据页面的空间
  final double? size;

  /// 可拖拽控件触发范围
  final double? triggerSize;

  /// 控件颜色，默认边框颜色
  final Color? color;

  /// 拖拽激活颜色，默认 null
  final Color? activeColor;

  /// 分割条触发位置，默认居中。
  ///
  /// 如果你设置了较大触发范围，可能会遮挡了页面中的滚动条，你可以设置此参数调整触发位置。
  final ElSplitPosition? position;

  /// 分割器拖拽偏移，不要直接编写匿名函数，它会导致每次构建时 [ElSplitThemeData] 一定不相等，
  /// 进而引起 [ElSplit] 构建的 overlay 不断删除、插入。
  final ValueChanged<double>? onChanged;

  /// 分割器结束拖拽
  final VoidCallback? onEnd;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
