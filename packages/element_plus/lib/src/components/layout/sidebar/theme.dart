part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '侧边栏默认样式')
class ElSidebarThemeData {
  static const theme = ElSidebarThemeData(color: Color(0xffffffff));
  static const darkTheme = ElSidebarThemeData(color: Color(0xff374151));

  const ElSidebarThemeData({
    required this.color,
    this.width = 240,
  });

  /// 侧边栏背景颜色
  final Color color;

  /// 侧边栏宽度
  final double width;
}
