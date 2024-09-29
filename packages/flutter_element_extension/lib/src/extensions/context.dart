import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

extension ElContextExtension on BuildContext {
  /// 获取当平台亮度模式
  Brightness get brightness => ElApp.of(this).brightness;

  /// 当前环境是否是暗黑模式
  bool get isDark => brightness == Brightness.dark;

  /// Element 亮色主题
  ElThemeData get lightTheme => ElApp.of(this).theme;

  /// Element 暗色主题
  ElThemeData get darkTheme => ElApp.of(this).darkTheme;
}
