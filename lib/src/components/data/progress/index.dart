import 'package:flutter/widgets.dart';

part 'state.dart';

class ElProgress extends StatefulWidget {
  const ElProgress(
    this.value, {
    super.key,
    this.min = 0.0,
    this.max = 100.0,
    this.color,
  })  : assert(min >= 0.0, 'ElProgress 最小值必须大于等于 0'),
        assert(max > min, 'ElProgress 最大值必须大于最小值');

  /// 进度值
  final double value;

  /// 最小值
  final double min;

  /// 最大值
  final double max;

  /// 进度条颜色，默认主题色
  final Color? color;

  @override
  State<ElProgress> createState() => _ElProgressState();
}
