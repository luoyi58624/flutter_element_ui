import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class LayoutDragPage extends ResponsivePage {
  const LayoutDragPage({super.key});

  @override
  String get title => 'ElLayout 拖拽尺寸';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
      // const Example2(title: '应用 Material 样式'),
    ];
  }
}