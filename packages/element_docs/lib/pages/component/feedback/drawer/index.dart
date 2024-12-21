import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class DrawerPage extends ResponsivePage {
  const DrawerPage({super.key});

  @override
  String get title => 'Drawer 抽屉';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
    ];
  }
}
