import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'package:flutter_element_ui/src/mixins/physical_size.dart';

part 'state.dart';

class ElProgress extends StatefulWidget {
  /// Element UI 进度条
  const ElProgress(
    this.value, {
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.size = 6.0,
    this.vertical = false,
    this.round = false,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.bgColor,
    this.indeterminate = false,
    this.duration = const Duration(seconds: 2),
  })  : assert(min >= 0.0, 'ElProgress 最小值必须大于等于 0'),
        assert(max > min, 'ElProgress 最大值必须大于最小值'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// 进度值
  final double value;

  /// 进度条最小值
  final double min;

  /// 进度条最大值
  final double max;

  /// 进度条尺寸
  final double size;

  /// 是否为垂直进度条，默认 false
  final bool vertical;

  /// 是否为圆角，默认 false
  final bool round;

  /// 自定义圆角
  final BorderRadiusGeometry borderRadius;

  /// 进度条颜色，默认主题色
  final Color? color;

  /// 进度条背景颜色，默认为 border + bg 进行混合
  final Color? bgColor;

  /// 是否为动画进度条
  final bool indeterminate;

  /// 动画持续时间
  final Duration duration;

  @override
  State<ElProgress> createState() => _ElProgressState();
}
