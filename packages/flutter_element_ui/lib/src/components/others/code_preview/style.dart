part of 'index.dart';

@ElModel.copy()
class ElCodePreviewThemeData {
  const ElCodePreviewThemeData({
    this.fontFamily,
    this.color = const Color(0xFFD19A66),
    this.bgColor = const Color.fromRGBO(49, 49, 49, 1.0),
    this.enableSection = true,
  });

  /// 字体名称
  final String? fontFamily;

  /// 默认文本颜色
  final Color color;

  /// 默认背景颜色
  final Color bgColor;

  /// 是否开启文本选择
  final bool enableSection;
}
