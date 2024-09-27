import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';

part 'style.dart';

part 'widgets/line.dart';

part 'widgets/animate.dart';

part '../../../generates/components/data/progress/index.g.dart';

const _valueDuration = Duration(milliseconds: 150);
const _valueCurve = Cubic(0.4, 0, 0.2, 1);

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
    this.boxSize = 16.0,
    this.axis = AxisDirection.right,
    this.valueDuration = _valueDuration,
    this.valueCurve = _valueCurve,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.line,
        pollDuration = Duration.zero,
        assert(boxSize >= size, 'ElProgress boxSize 必须大于等于 size'),
        assert(min >= 0.0, 'ElProgress min 必须大于等于 0'),
        assert(max > min, 'ElProgress max 必须大于 min'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// Element UI 动画进度条
  const ElProgress.animate(
    this.value, {
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.size = 6.0,
    this.boxSize = 16.0,
    this.axis = AxisDirection.right,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
    this.pollDuration = const Duration(milliseconds: 1800),
  })  : _type = _ProgressType.animate,
        valueDuration = Duration.zero,
        valueCurve = _valueCurve,
        assert(boxSize >= size, 'ElProgress boxSize 必须大于等于 size'),
        assert(min >= 0.0, 'ElProgress min 必须大于等于 0'),
        assert(max > min, 'ElProgress max 必须大于 min'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// Element UI 圆环进度条
  const ElProgress.circle(
    this.value, {
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.size = 6.0,
    this.boxSize = 16.0,
    this.valueDuration = _valueDuration,
    this.valueCurve = _valueCurve,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.circle,
        axis = AxisDirection.right,
        pollDuration = Duration.zero,
        assert(boxSize >= size, 'ElProgress boxSize 必须大于等于 size'),
        assert(min >= 0.0, 'ElProgress min 必须大于等于 0'),
        assert(max > min, 'ElProgress max 必须大于 min'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// Element UI 仪表盘进度条
  const ElProgress.dashboard(
    this.value, {
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.size = 6.0,
    this.boxSize = 16.0,
    this.valueDuration = _valueDuration,
    this.valueCurve = _valueCurve,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.dashboard,
        axis = AxisDirection.right,
        pollDuration = Duration.zero,
        assert(boxSize >= size, 'ElProgress boxSize 必须大于等于 size'),
        assert(min >= 0.0, 'ElProgress min 必须大于等于 0'),
        assert(max > min, 'ElProgress max 必须大于 min'),
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

  /// 进度条尺寸，默认 6 像素
  final double size;

  /// 进度条外部容器尺寸，默认 16 像素
  final double boxSize;

  /// 进度条方向，仅限直线进度条、动画进度条
  final AxisDirection axis;

  /// 是否为圆角，默认 true
  final bool round;

  /// 自定义圆角值，当 [round] 为 false 时生效
  final double radius;

  /// 进度条颜色，默认主题色
  final Color? color;

  /// 进度条背景颜色，默认为 border + bg 进行混合
  final Color? bgColor;

  /// [value] 进度更新时动画持续时间，如果频繁更新进度，请将它设置为 0
  final Duration valueDuration;

  /// [value] 进度更新时动画曲线
  final Curve valueCurve;

  /// 轮询动画持续时间，仅限动画进度条
  final Duration pollDuration;

  @override
  Widget build(BuildContext context) {
    final $bgColor = bgColor ?? context.elTheme.colors.borderLight;
    final $color = color ?? context.elTheme.primary;
    final $valueRatio = math.max((value - min), 0) / (max - min);
    final $vertical = axis == AxisDirection.up || axis == AxisDirection.down;
    late Size $size;
    late Size $boxSize;
    if ($vertical) {
      $size = Size.fromWidth(size);
      $boxSize = Size.fromWidth(boxSize);
    } else {
      $size = Size.fromHeight(size);
      $boxSize = Size.fromHeight(boxSize);
    }

    late Widget result;
    if (_type == _ProgressType.line) {
      result = _LineProgress(
        ratio: $valueRatio,
        size: $size,
        color: $color,
        axis: axis,
        duration: valueDuration,
        curve: valueCurve,
      );
    } else if (_type == _ProgressType.animate) {
      result = _AnimateProgressInheritedWidget(pollDuration,
          child: const _AnimateProgress());
    }

    return SizedBox.fromSize(
      size: $boxSize,
      child: Center(
        child: _ProgressInheritedWidget(value, min, max, $size, $boxSize, axis,
            $vertical, round, radius, $color, $bgColor, $valueRatio,
            child: result),
      ),
    );
  }
}

class _ProgressInheritedWidget extends InheritedWidget {
  const _ProgressInheritedWidget(
    this.value,
    this.min,
    this.max,
    this.size,
    this.boxSize,
    this.axis,
    this.vertical,
    this.round,
    this.radius,
    this.color,
    this.bgColor,
    this.ratio, {
    required super.child,
  });

  final double value;
  final double min;
  final double max;
  final Size size;
  final Size boxSize;
  final AxisDirection axis;
  final bool vertical;
  final bool round;
  final double radius;
  final Color color;
  final Color bgColor;

  /// [value] 在 [min] 和 [max] 之间的比例
  final double ratio;

  static _ProgressInheritedWidget of(BuildContext context) {
    final _ProgressInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ProgressInheritedWidget>();
    assert(result != null, 'No _ProgressInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ProgressInheritedWidget oldWidget) => true;
}
