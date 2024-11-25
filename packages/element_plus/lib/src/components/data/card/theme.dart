part of 'index.dart';

@ElModel.copy()
@ElThemeModel(desc: '卡片默认样式')
class ElCardThemeData {
  static const theme = ElCardThemeData(
    color: Color(0xffffffff),
    elevation: 2,
  );
  static const darkTheme = ElCardThemeData(
    color: Color(0xff3f3f46),
    elevation: 4,
  );

  const ElCardThemeData({
    required this.color,
    required this.elevation,
  });

  /// 卡片颜色
  final Color color;

  /// 卡片海拔高度，设置较低的海拔能让应用更加扁平化，设置较高的海拔则让应用更具层级感
  final double elevation;
}
