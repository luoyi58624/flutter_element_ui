import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/builders/global_theme_model.dart';
import 'src/builders/model.dart';
import 'src/builders/theme_model.dart';
import 'src/config.dart';

Builder elModelBuilder(BuilderOptions options) {
  modelBuilderConfig = ModelBuilderConfig.fromConfig(options.config);
  return SharedPartBuilder([
    ElModelGenerator(),
  ], 'model');
}

Builder elThemeModelBuilder(BuilderOptions options) {
  return SharedPartBuilder([
    ElThemeModelGenerator(),
  ], 'themeModel');
}

Builder elGlobalThemeModelBuilder(BuilderOptions options) {
  return SharedPartBuilder([
    ElGlobalThemeModelGenerator(),
  ], 'globalThemeModel');
}
