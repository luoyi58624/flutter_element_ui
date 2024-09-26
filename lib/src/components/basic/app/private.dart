import 'package:flutter/material.dart';

import 'index.dart';

/// ElApp 注入的全局数据，你可以通过 [ElApp.of] 方法访问它们
class AppData {
  /// 当前主题模式
  final Brightness brightness;

  /// 亮色主题配置
  final ElThemeData theme;

  /// 暗色主题配置
  final ElThemeData darkTheme;

  /// 全局通用配置
  final ElConfigData config;

  /// 最终的全局文本样式，Element UI 预先提供一个默认的文本样式，然后合并颜色主题，最后合并用户自定义的文本样式
  final TextStyle textStyle;

  /// 当切换主题模式时，会临时设置全局默认的动画时间: [config.themeDuration]，这样可以保持动画过渡的一致性
  final Duration? globalThemeDuration;

  /// 全局动画曲线，同上
  final Curve? globalThemeCurve;

  AppData({
    required this.brightness,
    required this.theme,
    required this.darkTheme,
    required this.config,
    required this.textStyle,
    this.globalThemeDuration,
    this.globalThemeCurve,
  });
}
