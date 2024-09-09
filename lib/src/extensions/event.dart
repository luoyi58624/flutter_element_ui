import 'package:flutter/material.dart';

import '../widgets/hover.dart';
import '../widgets/tap.dart';

extension ElEventExtension on BuildContext {
  bool get isHover => ElHoverBuilder.of(this);

  bool get isTap => ElTapBuilder.of(this);

  /// 构建由响应事件触发的颜色状态
  Color buildEventColor(
      Color color, {
        Color? activeColor,
        Color? hoverColor,
      }) {
    Color result = color;
    if (activeColor != null) {
      if (isTap) {
        return activeColor;
      }
    }
    if (hoverColor != null) {
      if (isHover) {
        return hoverColor;
      }
    }
    return result;
  }
}
