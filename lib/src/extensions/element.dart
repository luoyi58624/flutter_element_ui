import 'package:flutter/material.dart';
import 'package:flutter_element_ui/global.dart';

import '../styles/theme.dart';

extension ElBuildContextExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? el.darkTheme : el.theme;

  /// 全局默认主题过渡持续时间，切换主题请使用 el.changeTheme 方法，
  /// 此方法会应用全局过渡时间和全局过渡动画曲线
  Duration? get elThemeDuration => GlobalThemeStyle.duration(this);

  /// 全局默认主题过渡动画曲线
  Curve? get elThemeCurve => GlobalThemeStyle.curve(this);
}
