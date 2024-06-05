import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator.dart';

Builder modelBuilder(BuilderOptions options) => SharedPartBuilder([ElModelGenerator()], 'model');
