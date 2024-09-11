import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class IconPage extends ResponsivePage {
  const IconPage({super.key});

  @override
  String get title => 'Icon 图标';

  @override
  List<Widget> buildPage(BuildContext context) {
    return const [
      titleGap,
      SectionText('Element UI 提供了一套常用的图标集合。'),
      Example1(),
      Example2(),
    ];
  }
}
