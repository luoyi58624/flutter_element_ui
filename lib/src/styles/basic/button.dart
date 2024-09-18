import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/basic/button.g.dart';

@ElModel.copy()
class ElButtonStyle {
  const ElButtonStyle({
    this.height,
    this.borderRadius,
    this.padding,
  });

  /// 按钮高度，默认全局 baseHeight
  final double? height;

  /// 按钮圆角，默认：radius
  final BorderRadius? borderRadius;

  /// 按钮内边距，默认为高度的一半
  final EdgeInsetsGeometry? padding;
}
