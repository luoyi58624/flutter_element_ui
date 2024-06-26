import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/basic/input.g.dart';

@ElModel.copy()
class ElInputStyle {
  const ElInputStyle({
    this.height = 36,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.margin = const EdgeInsets.all(4),
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
  }) : assert(height >= 24, 'input min height is 24');

  /// 输入框高度
  final double height;

  /// 输入框圆角，如果[round]为true，则强制渲染为圆角输入框
  final BorderRadiusGeometry? borderRadius;

  /// 输入框外边距
  final EdgeInsetsGeometry? margin;

  /// 输入框内边距
  final EdgeInsetsGeometry? padding;
}
