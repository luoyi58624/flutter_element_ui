import 'package:flutter/painting.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/basic/icon.g.dart';

@ElModel.copy()
class ElIconStyle {
  /// 默认图标样式
  static const ElIconStyle style = ElIconStyle(
    icon: null,
    size: 18,
    color: null,
  );

  /// 默认的图标数据
  final dynamic icon;

  /// icon 尺寸
  final double? size;

  /// icon 颜色
  final Color? color;

  const ElIconStyle({
    this.icon,
    this.size,
    this.color,
  });
}
