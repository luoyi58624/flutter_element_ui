import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class MenuBarPage extends ResponsivePage {
  const MenuBarPage({super.key});

  @override
  String get title => 'MenuBar 菜单栏';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
    ];
  }
}
