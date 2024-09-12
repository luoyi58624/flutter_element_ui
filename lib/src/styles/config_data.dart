import 'package:flutter/material.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../generates/styles/config_data.g.dart';

@ElModel.copy()
class ElConfigData {
  /// Element UI 默认全局配置
  static const ElConfigData data = ElConfigData();

  /// 通用控件高度，不能低于 36 像素
  final double baseHeight;

  /// 基础控件圆角值（小尺寸控件）: 按钮、输入框...
  final BorderRadius radius;

  /// 全局触觉回馈，默认false，如果为true，则所有点击事件将自动添加：
  /// ```dart
  /// HapticFeedback.mediumImpact();
  /// ```
  final bool enableFeedback;

  /// 切换全局主题动画时间，它等同于 [MaterialApp] 中 themeAnimationDuration 属性，
  /// 如果使用了 [MaterialApp] 构建应用，请将二者进行同步，这样可以避免动画不一致问题。
  final Duration themeDuration;

  /// 切换全局主题动画曲线，它等同于 [MaterialApp] 中 themeAnimationCurve 属性
  final Curve themeCurve;

  const ElConfigData({
    this.baseHeight = 36,
    this.radius = const BorderRadius.all(Radius.circular(4)),
    this.enableFeedback = false,
    this.themeDuration = Duration.zero,
    this.themeCurve = Curves.linear,
  }) : assert(baseHeight >= 36);
}
