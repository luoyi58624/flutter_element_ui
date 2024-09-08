import 'package:flutter/animation.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/data/collapse.g.dart';

@ElModel.copy()
class ElCollapseStyle {
  const ElCollapseStyle({
    this.keepState = true,
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
  });

  /// 当子组件被折叠时是否保留状态，默认true
  final bool keepState;

  /// 折叠动画时间
  final Duration duration;

  /// 折叠动画曲线
  final Curve curve;
}
