import 'dart:ui';

import 'package:flutter/widgets.dart';

extension FlutterBorderExtension on Border {
  /// 获取 Border 最大的宽度
  double get maxWidth {
    final list = [left.width, left.width, left.width, left.width];
    list.sort();
    return list.last;
  }
}

extension FlutterBrightnessExtension on Brightness {
  bool get isDark => this == Brightness.dark;
}

extension FlutterAnimationControllerExtension on AnimationController {
  /// 根据当前动画状态继续运行动画
  void start() {
    if (status == AnimationStatus.dismissed ||
        status == AnimationStatus.forward) {
      forward();
    } else {
      reverse();
    }
  }
}

extension FlutterOffsetExtension on Offset {
  Offset clampConstraints(BoxConstraints constraints) {
    double x = 0.0;
    double y = 0.0;
    if (dx < 0) {
      x = 0;
    } else if (dx > constraints.maxWidth) {
      x = constraints.maxWidth;
    } else {
      x = dx;
    }
    if (dy < 0) {
      y = 0;
    } else if (dy > constraints.maxHeight) {
      y = constraints.maxHeight;
    } else {
      y = dy;
    }
    return Offset(x, y);
  }
}
