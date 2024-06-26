import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/basic/button.g.dart';

@ElModel.copy()
class ElButtonStyle {
  const ElButtonStyle({
    this.height = 36,
    this.borderRadius,
    this.margin = const EdgeInsets.all(4),
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
  }) : assert(height >= 24, 'button min height is 24');

  /// 按钮高度
  final double height;

  /// 按钮圆角，如果[round]为true，则强制渲染为圆角按钮
  final BorderRadiusGeometry? borderRadius;

  /// 按钮外边距
  final EdgeInsetsGeometry? margin;

  /// 按钮内边距
  final EdgeInsetsGeometry? padding;
}
