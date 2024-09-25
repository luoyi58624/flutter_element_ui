import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../../generates/styles/data/progress.g.dart';

@ElModel.copy()
class ElProgressData {
  const ElProgressData({
    this.duration = const Duration(milliseconds: 900),
    this.curve = Curves.easeOutSine,
    this.secondCurve = Curves.easeOut,
  });

  /// 动画进度条持续时间
  final Duration duration;

  /// 动画进度条第一条动画曲线，其进度尺寸会跟随进度一起缩小
  final Curve curve;

  /// 动画进度条第二条动画曲线，其进度尺寸不变
  final Curve secondCurve;
}

class ElProgressTheme extends InheritedWidget {
  const ElProgressTheme({
    super.key,
    required super.child,
    required this.data,
  });

  final ElProgressData data;

  static ElProgressTheme of(BuildContext context) {
    final ElProgressTheme? result =
        context.dependOnInheritedWidgetOfExactType<ElProgressTheme>();
    assert(result != null, 'No ElProgressTheme found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElProgressTheme oldWidget) => true;
}
