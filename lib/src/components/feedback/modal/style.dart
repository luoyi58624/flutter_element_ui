part of 'index.dart';

@ElModel.copy()
class ElModalThemeData {
  const ElModalThemeData({
    required this.color,
    required this.elevation,
  });

  /// 模态框背景颜色
  final Color color;

  /// 模态框海拔层级
  final double elevation;
}
