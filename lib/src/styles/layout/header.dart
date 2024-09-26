import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/layout/header.g.dart';

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
