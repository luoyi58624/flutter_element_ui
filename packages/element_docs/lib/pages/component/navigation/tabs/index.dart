import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class TabsPage extends ResponsivePage {
  const TabsPage({super.key});

  @override
  String get title => 'Tabs 标签页';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
      const Example2(title: 'Material 标签页'),
    ];
  }
}
