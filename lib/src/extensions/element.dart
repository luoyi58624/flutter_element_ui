import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../services/service.dart';
import '../styles/theme.dart';

extension ElAppExtension on BuildContext {
  /// Element UI 自适应主题，如果当前是暗黑模式，则获取注入的暗黑主题，否则获取注入的亮色主题
  ElThemeData get elTheme => isDark ? el.darkTheme : el.theme;

  /// Element UI 主题颜色集合
  Map<String, Color> get elThemeColors => {
        'primary': elTheme.primary,
        'success': elTheme.success,
        'info': elTheme.info,
        'warning': elTheme.warning,
        'error': elTheme.error,
      };
}
