part of 'index.dart';

@$ElModel.copy()
@$ElThemeModel(desc: '标签容器子标签全局样式')
class ElTabThemeData {
  static const theme = ElTabThemeData();
  static const darkTheme = ElTabThemeData();

  const ElTabThemeData({
    this.size = 50,
  });

  /// 标签容器尺寸
  final double size;
}
