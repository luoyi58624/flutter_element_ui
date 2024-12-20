import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class ContextMenuPage extends ResponsivePage {
  const ContextMenuPage({super.key});

  @override
  String get title => 'ContextMenu 右键菜单';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
      // Example2(),
    ];
  }
}