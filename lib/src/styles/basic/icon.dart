import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/basic/icon.g.dart';

@ElModel.copy()
class ElIconStyle {
  const ElIconStyle({
    this.size,
    required this.color,
  });

  /// icon 默认尺寸
  final double? size;

  /// icon 颜色
  final Color color;
}
