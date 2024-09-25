import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';

part 'line/index.dart';

part 'animate/index.dart';

enum _ProgressType {
  line,
  animate,
  circle,
  dashboard,
}

class ElProgress extends StatelessWidget {
  /// Element UI 直线进度条
  const ElProgress(
    this.value, {
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.size = 6.0,
    this.vertical = false,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.line,
        duration = Duration.zero,
        curve = Curves.linear,
        secondCurve = Curves.linear,
        assert(min >= 0.0, 'ElProgress 最小值必须大于等于 0'),
        assert(max > min, 'ElProgress 最大值必须大于最小值'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// Element UI 直线动画进度条
  const ElProgress.animate(
    this.value, {
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.size = 6.0,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
    this.duration = const Duration(milliseconds: 900),
    this.curve = Curves.easeOutCubic,
    this.secondCurve = Curves.easeIn,
  })  : _type = _ProgressType.animate,
        vertical = false,
        assert(min >= 0.0, 'ElProgress 最小值必须大于等于 0'),
        assert(max > min, 'ElProgress 最大值必须大于最小值'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// Element UI 圆环进度条
  const ElProgress.circle(
    this.value, {
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.size = 6.0,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.circle,
        vertical = false,
        duration = Duration.zero,
        curve = Curves.linear,
        secondCurve = Curves.linear,
        assert(min >= 0.0, 'ElProgress 最小值必须大于等于 0'),
        assert(max > min, 'ElProgress 最大值必须大于最小值'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// Element UI 仪表盘进度条
  const ElProgress.dashboard(
    this.value, {
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.size = 6.0,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.dashboard,
        vertical = false,
        duration = Duration.zero,
        curve = Curves.linear,
        secondCurve = Curves.linear,
        assert(min >= 0.0, 'ElProgress 最小值必须大于等于 0'),
        assert(max > min, 'ElProgress 最大值必须大于最小值'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// 进度条类型
  final _ProgressType _type;

  /// 进度值
  final double value;

  /// 进度条最小值
  final double min;

  /// 进度条最大值
  final double max;

  /// 进度条尺寸
  final double size;

  /// 是否为垂直进度条，默认 false，仅限直线进度条
  final bool vertical;

  /// 是否为圆角，默认 true
  final bool round;

  /// 自定义圆角值，当 [round] 为 false 时生效
  final double radius;

  /// 进度条颜色，默认主题色
  final Color? color;

  /// 进度条背景颜色，默认为 border + bg 进行混合
  final Color? bgColor;

  /// 动画进度条持续时间
  final Duration duration;

  /// 动画进度条第一条动画曲线
  final Curve curve;

  /// 动画进度条第二条动画曲线
  final Curve secondCurve;

  @override
  Widget build(BuildContext context) {
    final $bgColor = bgColor ?? context.elTheme.colors.borderLight;
    final $color = color ?? context.elTheme.primary;
    final $radius = round ? size / 2 : radius;
    final $valueRatio = math.max((value - min), 0) / (max - min);
    late Widget result;
    if (_type == _ProgressType.line) {
      result =
          _LineProgressInheritedWidget(vertical, child: const _LineProgress());
    } else if (_type == _ProgressType.animate) {
      result = _AnimateProgressInheritedWidget(duration, curve, secondCurve,
          child: const _AnimateProgress());
    }

    return LayoutBuilder(builder: (context, constraints) {
      return _ProgressInheritedWidget(value, min, max, size, round, $radius,
          $color, $bgColor, $valueRatio, constraints.maxWidth,
          child: result);
    });
  }
}

class _ProgressInheritedWidget extends InheritedWidget {
  const _ProgressInheritedWidget(
    this.value,
    this.min,
    this.max,
    this.size,
    this.round,
    this.radius,
    this.color,
    this.bgColor,
    this.ratio,
    this.physicalSize, {
    required super.child,
  });

  final double value;
  final double min;
  final double max;
  final double size;
  final bool round;
  final double radius;
  final Color color;
  final Color bgColor;

  /// [value] 在 [min] 和 [max] 之间的比例
  final double ratio;

  /// 进度条整体所占据的物理尺寸
  final double physicalSize;

  static _ProgressInheritedWidget of(BuildContext context) {
    final _ProgressInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ProgressInheritedWidget>();
    assert(result != null, 'No _ProgressInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ProgressInheritedWidget oldWidget) =>
      value != oldWidget.value ||
      min != oldWidget.min ||
      max != oldWidget.max ||
      round != oldWidget.round ||
      radius != oldWidget.radius ||
      color != oldWidget.color ||
      bgColor != oldWidget.bgColor;
}
