import 'package:build/build.dart';

import 'package:source_gen/source_gen.dart';

import 'model.dart';

Builder modelBuilder(BuilderOptions options) => SharedPartBuilder([ElModelGenerator()], 'model');
