import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class TabsPage extends ResponsivePage {
  const TabsPage({super.key});

  @override
  String get title => 'Tabs 标签页';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础用法'),
    ];
  }
}
