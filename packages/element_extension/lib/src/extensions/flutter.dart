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

