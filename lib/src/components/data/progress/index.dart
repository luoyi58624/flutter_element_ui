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
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.line,
        duration = Duration.zero,
        assert(min >= 0.0, 'ElProgress 最小值必须大于等于 0'),
        assert(max > min, 'ElProgress 最大值必须大于最小值'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// Element UI 动画进度条
  const ElProgress.animate(
    this.value, {
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.size = 6.0,
    this.round = true,
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.bgColor,
    this.duration = const Duration(seconds: 2),
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
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.circle,
        vertical = false,
        duration = Duration.zero,
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
    this.borderRadius = BorderRadius.zero,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.dashboard,
        vertical = false,
        duration = Duration.zero,
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

  /// 是否为垂直进度条，默认 false
  final bool vertical;

  /// 是否为圆角，默认 true
  final bool round;

  /// 自定义圆角，当 [round] 为 false 时生效
  final BorderRadiusGeometry borderRadius;

  /// 进度条颜色，默认主题色
  final Color? color;

  /// 进度条背景颜色，默认为 border + bg 进行混合
  final Color? bgColor;

  /// 动画进度条持续时间，默认 2 秒
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    final $bgColor = bgColor ?? context.elTheme.colors.borderLight;
    final $color = color ?? context.elTheme.primary;
    final $borderRadius =
        round ? BorderRadius.circular(size / 2) : borderRadius;
    final $valueRatio = math.max((value - min), 0) / (max - min);
    late Widget result;
    if (_type == _ProgressType.line) {
      result = _LineProgressInheritedWidget(
          value, min, max, size, vertical, round, $borderRadius, color, bgColor,
          child: const _LineProgress());
    } else if (_type == _ProgressType.animate) {
      result = _AnimateProgressInheritedWidget(duration,
          child: const _AnimateProgress());
    }

    return LayoutBuilder(builder: (context, constraints) {
      return _ProgressInheritedWidget(value, min, max, size, round,
          $borderRadius, $color, $bgColor, $valueRatio, constraints.maxWidth,
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
    this.borderRadius,
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
  final BorderRadiusGeometry borderRadius;
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
  bool updateShouldNotify(_ProgressInheritedWidget oldWidget) => true;
}

/// 直线进度条外观样式
class _LineWrapperWidget extends StatelessWidget {
  const _LineWrapperWidget();

  @override
  Widget build(BuildContext context) {
    final $data = _ProgressInheritedWidget.of(context);
    return Container(
      height: $data.size,
      decoration: BoxDecoration(
        color: $data.bgColor,
        borderRadius: $data.borderRadius,
      ),
    );
  }
}

/// 直线进度条样式
class _LineProgressWidget extends StatelessWidget {
  const _LineProgressWidget();

  @override
  Widget build(BuildContext context) {
    final $data = _ProgressInheritedWidget.of(context);
    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: $data.physicalSize * $data.ratio,
        height: $data.size,
        decoration: BoxDecoration(
          color: $data.color,
          borderRadius: $data.borderRadius,
        ),
      ),
    );
  }
}
