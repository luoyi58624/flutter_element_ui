library flutter_element_ui;

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

part 'src/components/app.dart';

part 'src/components/button.dart';

part 'src/components/button_group.dart';

part 'src/components/menu.dart';

part 'src/utils/color.dart';

part 'src/utils/logger.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
