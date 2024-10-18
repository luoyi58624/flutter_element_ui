import 'dart:math' as math;

import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

part 'animate_builder.dart';

part 'painter.dart';

part 'animate_loader.dart';

const _defaultDuration = Duration(milliseconds: 150);
const _defaultCurve = Cubic(0.4, 0, 0.2, 1);

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
    this.secondaryValue = 0.0,
    this.min = 0.0,
    this.max = 100.0,
    this.boxSize = 16.0,
    this.strokeSize = 6.0,
    this.axis = AxisDirection.right,
    this.duration = _defaultDuration,
    this.curve = _defaultCurve,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.line,
        assert(boxSize >= strokeSize, 'ElProgress boxSize 必须大于等于 strokeSize'),
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
    this.boxSize = 16.0,
    this.strokeSize = 6.0,
    this.axis = AxisDirection.right,
    this.round = true,
    this.radius = 0,
    this.color,
    this.bgColor,
    this.duration = const Duration(milliseconds: 3000),
    this.curve = Curves.ease,
  })  : _type = _ProgressType.animate,
        secondaryValue = 0.0,
        assert(boxSize >= strokeSize, 'ElProgress boxSize 必须大于等于 strokeSize'),
        assert(min >= 0.0, 'ElProgress min 必须大于等于 0'),
        assert(max > min, 'ElProgress max 必须大于 min'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// Element UI 圆环进度条
  const ElProgress.circle(
    this.value, {
    super.key,
    this.secondaryValue = 0.0,
    this.min = 0.0,
    this.max = 100.0,
    this.boxSize = 100.0,
    this.strokeSize = 6.0,
    this.duration = _defaultDuration,
    this.curve = _defaultCurve,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.circle,
        axis = AxisDirection.right,
        round = true,
        radius = 0,
        assert(boxSize >= strokeSize, 'ElProgress boxSize 必须大于等于 strokeSize'),
        assert(min >= 0.0, 'ElProgress min 必须大于等于 0'),
        assert(max > min, 'ElProgress max 必须大于 min'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// Element UI 仪表盘进度条
  const ElProgress.dashboard(
    this.value, {
    super.key,
    this.secondaryValue = 0.0,
    this.min = 0.0,
    this.max = 100.0,
    this.boxSize = 100.0,
    this.strokeSize = 6.0,
    this.duration = _defaultDuration,
    this.curve = _defaultCurve,
    this.color,
    this.bgColor,
  })  : _type = _ProgressType.dashboard,
        axis = AxisDirection.right,
        round = true,
        radius = 0,
        assert(boxSize >= strokeSize, 'ElProgress boxSize 必须大于等于 strokeSize'),
        assert(min >= 0.0, 'ElProgress min 必须大于等于 0'),
        assert(max > min, 'ElProgress max 必须大于 min'),
        assert(value >= min && value <= max,
            'ElProgress value 取值范围必须在 min - max 之间');

  /// 进度条类型
  final _ProgressType _type;

  /// 进度值
  final double value;

  /// 次要进度条的进度值
  final double secondaryValue;

  /// 进度条最小值
  final double min;

  /// 进度条最大值
  final double max;

  /// 进度条容器尺寸：
  /// * 如果是直线进度条，方向若是水平则表示直线进度条的高度，垂直方向则表示宽度，默认尺寸为 16 像素；
  /// * 如果是圆环、仪表盘进度条，则表示宽高一致的圆形，默认尺寸为 100 像素。
  final double boxSize;

  /// 进度条实际绘制的尺寸，默认 6 像素，它不能大于 [boxSize]
  final double strokeSize;

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

  /// [value] 进度更新时动画持续时间，如果频繁更新进度，请将它设置为 [Duration.zero]，
  /// 当使用动画进度条时，它代表的是每次循环的持续时间。
  final Duration duration;

  /// [value] 进度更新时动画曲线，当使用动画进度条时，它代表的是循环动画曲线
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final $bgColor = bgColor ?? context.elTheme.borderLightColor;
    final $color = color ?? context.elTheme.primary;
    final $valueRatio = math.max((value - min), 0) / (max - min);
    final $vertical = axis == AxisDirection.up || axis == AxisDirection.down;

    late Size $boxSize;
    late Size $strokeSize;
    switch (_type) {
      case _ProgressType.line:
      case _ProgressType.animate:
        if ($vertical) {
          $boxSize = Size.fromWidth(boxSize);
          $strokeSize = Size.fromWidth(strokeSize);
        } else {
          $boxSize = Size.fromHeight(boxSize);
          $strokeSize = Size.fromHeight(strokeSize);
        }
        break;
      case _ProgressType.circle:
      case _ProgressType.dashboard:
        $boxSize = Size(boxSize, boxSize);
        $strokeSize = Size(strokeSize, strokeSize);
        break;
    }

    late _ProgressAnimateBuilder builder;

    late Widget result;

    if (_type == _ProgressType.animate) {
      result = _AnimateLoader(
        duration: duration,
        curve: curve,
      );
    } else {
      if (_type == _ProgressType.line) {
        builder = (ratio, strokeSize, color) {
          double $radius = round
              ? ($vertical ? strokeSize.width : strokeSize.height) / 2
              : radius;
          return ClipRRect(
            borderRadius: BorderRadius.circular($radius),
            child: CustomPaint(
              size: strokeSize,
              painter: _LineProgressPainter(
                ratio: ratio,
                positionRatio: 0,
                color: color,
                radius: $radius,
                axis: axis,
                bgColor: $bgColor,
              ),
            ),
          );
        };
      } else if (_type == _ProgressType.circle) {
        builder = (ratio, strokeSize, color) {
          return CustomPaint(
            size: $boxSize,
            painter: _CricleProgressPainter(
              ratio: ratio,
              strokeSize: strokeSize,
              color: color,
              bgColor: $bgColor,
            ),
          );
        };
      } else {
        builder = (ratio, strokeSize, color) {
          return CustomPaint(
            size: $boxSize,
            painter: _DashboardProgressPainter(
              ratio: ratio,
              strokeSize: strokeSize,
              color: color,
              bgColor: $bgColor,
            ),
          );
        };
      }

      result = _AnimateBuilder(
        ratio: $valueRatio,
        strokeSize: $strokeSize,
        color: $color,
        axis: axis,
        duration: duration,
        curve: curve,
        builder: builder,
      );
    }

    return SizedBox.fromSize(
      size: $boxSize,
      child: Center(
        child: _ProgressInheritedWidget(value, min, max, $boxSize, $strokeSize,
            axis, $vertical, round, radius, $color, $bgColor, $valueRatio,
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
    this.boxSize,
    this.strokeSize,
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
  final Size boxSize;
  final Size strokeSize;
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
