import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/data/card.g.dart';

@ElModel.copy()
class ElCardStyle {
  const ElCardStyle({
    required this.color,
    required this.elevation,
    this.radius = const BorderRadius.all(Radius.circular(6)),
  });

  /// 卡片颜色
  final Color color;

  /// 卡片海拔高度，设置较低的海拔能让应用更加扁平化，设置较高的海拔则让应用更具层级感
  final double elevation;

  /// 卡片圆角
  final BorderRadius radius;
}
