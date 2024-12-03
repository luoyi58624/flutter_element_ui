part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '分割器默认样式')
class ElSplitPaneThemeData {
  static const _defaultTheme = ElSplitPaneThemeData(
    axis: Axis.vertical,
  );
  static const theme = _defaultTheme;
  static const darkTheme = _defaultTheme;

  const ElSplitPaneThemeData({
    this.axis,
  });

  /// 分割器方向，默认垂直
  final Axis? axis;

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;
}
