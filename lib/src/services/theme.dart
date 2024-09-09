import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/app.dart';
import 'package:flutter_element_ui/src/widgets/brightness.dart';

import '../service.dart';
import '../styles/config_data.dart';
import '../styles/theme_data.dart';

mixin ElThemeService {
  Brightness get brightness => BrightnessWidget.of(el.context);

  bool get isDark => brightness == Brightness.dark;

  ElThemeData get theme => AppProvider.of(el.context).theme;

  ElThemeData get darkTheme => AppProvider.of(el.context).darkTheme;

  ElConfigData get config => AppProvider.of(el.context).config;

  TextStyle get textStyle => AppProvider.of(el.context).textStyle;
}
