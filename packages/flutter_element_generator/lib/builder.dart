import 'package:build/build.dart';
import 'package:flutter_element_dart/flutter_element_dart.dart';
import 'package:flutter_element_generator/src/config.dart';
import 'package:source_gen/source_gen.dart';

import 'src/builders/model.dart';
import 'src/builders/theme_data.dart';

Builder elBuilder(BuilderOptions options) {
  return SharedPartBuilder([
    ElModelGenerator(BuilderConfig.fromConfig(options.config)),
    ElThemeDataGenerator(),
  ], 'model');
}
