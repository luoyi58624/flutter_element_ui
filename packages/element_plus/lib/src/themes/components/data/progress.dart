import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../../generates/themes/components/data/progress.g.dart';

@ElModel.copy()
@ElThemeModel(desc: '进度条默认样式')
class ElProgressThemeData {
  static const theme = ElProgressThemeData();
  static const darkTheme = ElProgressThemeData();

  const ElProgressThemeData({
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
