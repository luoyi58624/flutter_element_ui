import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/form/slider.g.dart';

@ElModel.copy()
class ElSliderThemeData {
  const ElSliderThemeData({
    this.sliderSize = 18,
    this.thumbSize = 4,
    this.activeColor,
    required this.inactiveColor,
  });

  /// 滑块整体尺寸
  final double sliderSize;

  /// 滑块轨道尺寸
  final double thumbSize;

  /// 滑块激活颜色，如果为 null，则跟随 primary 主题色
  final Color? activeColor;

  /// 滑块未激活颜色
  final Color inactiveColor;
}
