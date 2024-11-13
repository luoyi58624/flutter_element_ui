part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '导航头默认样式')
class ElHeaderThemeData {
  static const theme = ElHeaderThemeData(color: Color(0xffffffff));
  static const darkTheme = ElHeaderThemeData(color: Color(0xff404040));

  const ElHeaderThemeData({
    required this.color,
    this.height = 56,
  });

  /// 导航头背景颜色
  final Color color;

  /// 导航头高度
  final double height;
}
