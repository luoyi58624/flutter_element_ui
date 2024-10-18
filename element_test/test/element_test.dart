import 'package:element_dart/element_dart.dart';
import 'package:element_plus/element_plus.dart';

import 'element_dart_test.dart';
import 'element_generates_test.dart';
import 'flutter_obs_test.dart';

void main() {
  i(ElThemeData.theme.primary);
  i(ElThemeData.darkTheme.primary);
  elementDartTest();
  elementGeneratesTest();
  flutterObsTest();
}
