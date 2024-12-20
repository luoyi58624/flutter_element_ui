part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '支持拖拽、调整 Widget 尺寸小部件默认样式')
class ElDragResizerThemeData {
  static const _defaultTheme = ElDragResizerThemeData(
    triggerSize: 8,
  );
  static const theme = _defaultTheme;
  static const darkTheme = _defaultTheme;

  const ElDragResizerThemeData({
    this.triggerSize,
  });

  /// 拖拽控件触发范围，默认 8。
  ///
  /// 注意：[triggerSize] 必须大于 [size]，否则会抛出异常。
  final double? triggerSize;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
