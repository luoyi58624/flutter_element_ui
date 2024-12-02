part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '分割器默认样式')
class ElSplitThemeData {
  static const _defaultTheme = ElSplitThemeData(
    size: 0,
    triggerSize: 10,
    position: ElSplitPosition.center,
  );
  static const theme = _defaultTheme;
  static const darkTheme = _defaultTheme;

  const ElSplitThemeData({
    this.size,
    this.triggerSize,
    this.color,
    this.activeColor,
    this.position,
  });

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
}
