import '../../global.dart';

part '../../generates/themes/layout/header.g.dart';

@ElModel.copy()
class ElHeaderThemeData {
  const ElHeaderThemeData({
    required this.color,
    this.height = 56,
  });

  /// 导航头背景颜色
  final Color color;

  /// 导航头高度
  final double height;
}
