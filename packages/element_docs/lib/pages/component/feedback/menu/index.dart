import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class MenuPage extends ResponsivePage {
  const MenuPage({super.key});

  @override
  String get title => 'Menu 菜单';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
      // Example2(),
    ];
  }
}
