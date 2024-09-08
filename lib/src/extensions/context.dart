import 'package:flutter/widgets.dart';

import '../styles/theme_data.dart';
import '../theme.dart';

/// BuildContext 扩展方法，仅限内部使用
extension BuildContextExtension on BuildContext {
  ElThemeData get theme => ElThemeInheritedWidget.of(this).theme;

  ElThemeData get darkTheme => ElThemeInheritedWidget.of(this).darkTheme;
}
