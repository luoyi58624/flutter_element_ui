import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';

part 'style.dart';

part 'widgets/line.dart';

part 'widgets/animate.dart';

part 'widgets/circle.dart';

part '../../../generates/components/data/progress/index.g.dart';

const _valueDuration = Duration(milliseconds: 150);

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
    this.vertical = false,
    this.disabledAnimate = false,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.line,
        duration = Duration.zero,
        curve = Curves.linear,
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
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
    this.duration = const Duration(milliseconds: 1800),
    this.curve = Curves.easeOutSine,
  })  : _type = _ProgressType.animate,
        vertical = false,
        disabledAnimate = false,
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
    this.disabledAnimate = false,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.circle,
        vertical = false,
        duration = Duration.zero,
        curve = Curves.linear,
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
    this.disabledAnimate = false,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.dashboard,
        vertical = false,
        duration = Duration.zero,
        curve = Curves.linear,
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

  /// 是否为垂直进度条，默认 false，仅限直线进度条
  final bool vertical;

  /// 默认情况下，每次更新 [value] 进度时会进行动画处理，在频繁更新进度时会造成延迟问题，
  /// 例如：拖拽进度条，你可以在开始拖拽时将 [disabledAnimate] 设置为 true，
  /// 这样便可以快速响应拖拽事件。
  final bool disabledAnimate;

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

  /// 动画进度条动画曲线
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final $bgColor = bgColor ?? context.elTheme.colors.borderLight;
    final $color = color ?? context.elTheme.primary;

    final $valueRatio = math.max((value - min), 0) / (max - min);

    late Widget result;
    if (_type == _ProgressType.line) {
      result = _LineProgress(
        value: $valueRatio,
        size: size,
        color: $color,
        vertical: vertical,
        disabledAnimate: disabledAnimate,
      );
    } else if (_type == _ProgressType.animate) {
      result = _AnimateProgressInheritedWidget(duration, curve,
          child: const _AnimateProgress());
    }
    late Size physicalSize;
    if (vertical) {
      physicalSize = Size.fromWidth(size);
    } else {
      physicalSize = Size.fromHeight(size);
    }
    return SizedBox(
      width: vertical ? boxSize : double.infinity,
      height: vertical ? double.infinity : boxSize,
      child: Center(
        child: _ProgressInheritedWidget(value, min, max, size, boxSize, round,
            radius, $color, $bgColor, $valueRatio, physicalSize,
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
  final double boxSize;
  final bool round;
  final double radius;
  final Color color;
  final Color bgColor;

  /// [value] 在 [min] 和 [max] 之间的比例
  final double ratio;

  /// 进度条整体所占据的物理尺寸
  final Size physicalSize;

  static _ProgressInheritedWidget of(BuildContext context) {
    final _ProgressInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ProgressInheritedWidget>();
    assert(result != null, 'No _ProgressInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ProgressInheritedWidget oldWidget) => true;
}
