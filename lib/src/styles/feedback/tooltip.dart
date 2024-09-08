import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_ui/src/services/toast.dart';

part '../../generates/styles/feedback/tooltip.g.dart';

@ElModel.copy()
class ElTooltipStyle {
  const ElTooltipStyle({
    required this.color,
    this.enableFeedback,
  });

  /// tooltip 背景颜色
  final Color color;

  /// 是否开启震动反馈，默认跟随 config.enableFeedback
  final bool? enableFeedback;
}
