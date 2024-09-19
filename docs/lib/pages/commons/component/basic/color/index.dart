import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';

class ColorPage extends ResponsivePage {
  const ColorPage({super.key});

  @override
  String get title => 'Color 颜色';

  @override
  List<Widget> buildPage(BuildContext context) {
    return const [
      titleGap,
      SectionText(
          'Element UI 为了避免视觉传达差异，使用一套特定的调色板来规定颜色，为你所搭建的产品提供一致的外观视觉感受。'),
      Example1(),
      Example2(),
      Example3(),
    ];
  }
}