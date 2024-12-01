import 'package:element_annotation/element_annotation.dart';
import 'package:flutter/material.dart';

part '../generates/models/config.g.dart';

@ElModel.copy()
class ConfigData {
  /// Element UI 默认全局配置
  static const ConfigData data = ConfigData();

  /// 通用控件高度，默认 36 像素，此属性会影响许多组件，最低尺寸不能低于 28 像素
  final double baseHeight;

  /// 基础控件圆角值（小尺寸控件）: 按钮、输入框...
  final BorderRadius radius;

  /// 切换全局主题动画时间，它等同于 [MaterialApp] 中 themeAnimationDuration 属性，
  /// 如果使用了 [MaterialApp] 构建应用，请将二者进行同步，这样可以避免动画不一致问题。
  final Duration themeDuration;

  /// 切换全局主题动画曲线，它等同于 [MaterialApp] 中 themeAnimationCurve 属性
  final Curve themeCurve;

  const ConfigData({
    this.baseHeight = 36,
    this.radius = const BorderRadius.all(Radius.circular(4)),
    this.themeDuration = Duration.zero,
    this.themeCurve = Curves.linear,
  }) : assert(baseHeight >= 28);
}
