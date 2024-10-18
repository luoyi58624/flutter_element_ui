part of 'index.dart';

@$ElModel.copy()
@$ElThemeModel(desc: '标签全局样式')
class ElTagThemeData {
  static const theme = ElTagThemeData();
  static const darkTheme = ElTagThemeData();

  const ElTagThemeData({
    this.size = 50,
  });

  /// 标签容器尺寸
  final double size;
}
