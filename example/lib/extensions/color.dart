import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

extension ThemeExtension on BuildContext {
  ElColorThemeData get theme => ElTheme.of(this).theme;

  ElColorThemeData get darkTheme => ElTheme.of(this).darkTheme;

  /// Element UI 主题类型颜色集合
  Map<String, Color> get elThemeTypeColors => {
        'primary': elTheme.primary,
        'success': elTheme.success,
        'info': elTheme.info,
        'warning': elTheme.warning,
        'error': elTheme.error,
      };
}
