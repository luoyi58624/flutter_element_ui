part of 'index.dart';

@ElModel.copy()
@ElThemeDataModel()
class ElTabsThemeData {
  const ElTabsThemeData({
    this.size = 50,
  });

  /// 标签容器尺寸，
  final double size;
}
