import 'package:flutter/material.dart';
import 'package:flutter_element_ui/global.dart';

import '../styles/theme.dart';

extension ElBuildContextExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? el.darkTheme : el.theme;
}
