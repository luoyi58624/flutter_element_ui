import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/builders/model/index.dart';
import 'src/builders/theme_data.dart';

Builder elBuilder(BuilderOptions options) => SharedPartBuilder([
      ElModelGenerator(),
      ElThemeDataGenerator(),
    ], 'model');
