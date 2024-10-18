part of 'index.dart';

@$ElModel.copy()
class ElTooltipThemeData {
  const ElTooltipThemeData({
    required this.color,
    this.enableFeedback,
  });

  /// tooltip 背景颜色
  final Color color;

  /// 是否开启震动反馈，默认跟随 config.enableFeedback
  final bool? enableFeedback;
}
