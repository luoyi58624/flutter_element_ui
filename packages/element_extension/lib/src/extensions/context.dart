
import 'package:flutter/widgets.dart';
import 'package:element_plus/element_plus.dart';

extension ElContextExtension on BuildContext {
  /// Element 亮色主题
  ElThemeData get lightTheme => ElApp.of(this).theme;

  /// Element 暗色主题
  ElThemeData get darkTheme => ElApp.of(this).darkTheme;

  /// Element UI 主题颜色集合
  Map<String, Color> get elThemeColors => {
    'primary': elTheme.primary,
    'success': elTheme.success,
    'info': elTheme.info,
    'warning': elTheme.warning,
    'error': elTheme.error,
  };
}

