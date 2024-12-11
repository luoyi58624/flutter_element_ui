import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'raw_button.dart';

part 'button.dart';

part 'outline_button.dart';

part 'text_button.dart';

part 'link_button.dart';

/// 按钮属性尺寸预设
class ElButtonSizePreset {
  final double width;
  final double height;
  final double fontSize;
  final double iconSize;

  const ElButtonSizePreset({
    required this.width,
    required this.height,
    required this.fontSize,
    required this.iconSize,
  });
}
