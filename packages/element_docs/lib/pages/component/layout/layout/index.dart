import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'examples/example4.dart';
// import 'examples/example10.dart';

class LayoutPage extends ResponsivePage {
  const LayoutPage({super.key});

  @override
  String get title => 'ElLayout 布局';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
      const Example2(title: '应用 Material 样式'),
      const Example3(title: '拖拽布局'),
      // const Example4(title: '工具栏'),
      // const Example4(title: 'Focus 焦点'),
    ];
  }
}
