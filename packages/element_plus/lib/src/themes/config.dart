import 'package:flutter/material.dart';

import '../global.dart';

part '../generates/themes/config.g.dart';

@$ElModel.copy()
class ElConfigData {
  /// Element UI 默认全局配置
  static const ElConfigData data = ElConfigData();

  /// 基础控件默认尺寸，例如：按钮、输入框...
  final double size;

  /// 基础控件默认圆角值
  final BorderRadius radius;

  /// 切换全局主题动画时间，它等同于 [MaterialApp] 中 themeAnimationDuration 属性，
  /// 如果使用了 [MaterialApp] 构建应用，请将二者进行同步，这样可以避免动画不一致问题。
  final Duration themeDuration;

  /// 切换全局主题动画曲线，它等同于 [MaterialApp] 中 themeAnimationCurve 属性
  final Curve themeCurve;

  const ElConfigData({
    this.size = 36,
    this.radius = const BorderRadius.all(Radius.circular(4)),
    this.themeDuration = Duration.zero,
    this.themeCurve = Curves.linear,
  }) : assert(size >= 24);
}
