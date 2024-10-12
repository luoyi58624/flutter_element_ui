part of 'index.dart';

@ElModel.copy()
@ElThemeDataModel()
class ElTabThemeData {
  const ElTabThemeData({
    this.size = 50,
  });

  /// 标签容器尺寸，
  final double size;
}
