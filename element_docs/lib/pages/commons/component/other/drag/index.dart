import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class DragPage extends ResponsivePage {
  const DragPage({super.key});

  @override
  String get title => 'Drag 测试';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础用法'),
      // const Example2(title: '拖拽移动'),
    ];
  }
}
