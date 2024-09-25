import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';
import 'package:flutter_element_ui/src/services/toast.dart';

part '../../generates/styles/feedback/modal.g.dart';

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
