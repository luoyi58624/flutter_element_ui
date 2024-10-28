import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:element_plus/element_plus.dart';

extension ElContextExtension on BuildContext {
  /// 获取当平台亮度模式
  Brightness? get brightness => ElBrightness.of(this);

  /// 当前环境是否是暗黑模式
  bool get isDark => brightness == Brightness.dark;

  /// Element UI 亮色主题
  ElThemeData get lightTheme => ElTheme.maybeOf(this) ?? ElThemeData.theme;

  /// Element UI 暗色主题
  ElThemeData get darkTheme => ElTheme.maybeOf(this) ?? ElThemeData.darkTheme;

  /// Element UI 主题颜色集合
  Map<String, Color> get elThemeColors => {
        'primary': elTheme.primary,
        'success': elTheme.success,
        'info': elTheme.info,
        'warning': elTheme.warning,
        'error': elTheme.error,
      };
}
