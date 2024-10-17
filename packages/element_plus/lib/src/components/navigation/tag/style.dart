part of 'index.dart';

@ElModel.copy()
@ElThemeDataModel()
class ElTagThemeData {
  const ElTagThemeData({
    this.size = 50,
  });

  /// 标签容器尺寸
  final double size;

}
