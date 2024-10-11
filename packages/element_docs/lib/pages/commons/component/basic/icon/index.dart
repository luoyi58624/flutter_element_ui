import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class IconPage extends ResponsivePage {
  const IconPage({super.key});

  @override
  String get title => 'Icon 图标';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      titleGap,
      const SectionText('Element UI 提供了一套常用的图标集合。'),
      const Example1(title: '使用方法'),
      const Example2(title: '图标集合'),
    ];
  }
}
