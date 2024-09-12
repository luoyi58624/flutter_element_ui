import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/form/input.g.dart';

@ElModel.copy()
class ElInputStyle {
  const ElInputStyle({
    this.height,
    this.borderRadius,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.symmetric(horizontal: 8),
    this.textStyle = const TextStyle(fontSize: 14),
  });

  /// 输入框高度，默认全局 baseHeight
  final double? height;

  /// 输入框圆角：默认：radius
  final BorderRadius? borderRadius;

  /// 输入框外边距
  final EdgeInsetsGeometry? margin;

  /// 输入框内边距
  final EdgeInsetsGeometry? padding;

  /// 输入框文本样式
  final TextStyle textStyle;
}
