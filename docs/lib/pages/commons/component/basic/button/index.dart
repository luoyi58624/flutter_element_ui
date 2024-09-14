import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'examples/example4.dart';
import 'examples/example5.dart';
import 'examples/example6.dart';
import 'examples/example7.dart';
import 'examples/example8.dart';

class ButtonPage extends ResponsivePage {
  const ButtonPage({super.key});

  static final buttonTypes = [null, ...el.themeTypes];

  @override
  String get title => 'Button 按钮';

  @override
  List<Widget> buildPage(BuildContext context) {
    return const [
      Example1(),
      Example2(),
      Example3(),
      Example4(),
      Example5(),
      Example6(),
      Example7(),
      Example8(),
    ];
  }
}
