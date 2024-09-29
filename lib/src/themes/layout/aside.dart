import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/themes/layout/aside.g.dart';

@ElModel.copy()
class ElAsideThemeData {
  const ElAsideThemeData({
    required this.color,
    this.width = 240,
  });

  /// 侧边栏背景颜色
  final Color color;

  /// 侧边栏宽度
  final double width;
}
