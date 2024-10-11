import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/builders/model.dart';
import 'src/builders/theme_data.dart';
import 'src/config.dart';

Builder elBuilder(BuilderOptions options) {
  builderConfig = BuilderConfig.fromConfig(options.config);
  return SharedPartBuilder([
    ElModelGenerator(),
    ElThemeDataGenerator(),
  ], 'model');
}
