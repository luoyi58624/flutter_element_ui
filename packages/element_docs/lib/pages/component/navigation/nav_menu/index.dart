import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class NavMenuPage extends ResponsivePage {
  const NavMenuPage({super.key});

  @override
  String get title => 'NavMenu 导航菜单';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
    ];
  }
}
