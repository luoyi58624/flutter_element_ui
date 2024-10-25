import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../../generates/themes/components/feedback/tooltip.g.dart';

@ElModel.copy()
@ElThemeModel(generateInheritedWidget: false, desc: '提示框默认样式')
class ElTooltipThemeData {
  static const theme = ElTooltipThemeData(color: Color(0xFF616161));
  static const darkTheme = ElTooltipThemeData(color: Color(0xFF757575));

  const ElTooltipThemeData({
    required this.color,
    this.enableFeedback,
  });

  /// tooltip 背景颜色
  final Color color;

  /// 是否开启震动反馈，默认跟随 config.enableFeedback
  final bool? enableFeedback;
}
