import 'package:flutter/widgets.dart';

import '../app.dart';
import '../styles/theme_data.dart';

/// BuildContext 扩展方法，仅限内部使用
extension BuildContextExtension on BuildContext {
  ElThemeData get theme => ElApp.of(this).theme;

  ElThemeData get darkTheme => ElApp.of(this).darkTheme;
}
