import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';

class TreePage extends ResponsivePage {
  const TreePage({super.key});

  @override
  String get title => 'Tag 标签';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
      const Example2(title: '可关闭标签'),
      const Example3(title: '动态编辑标签'),
    ];
  }
}
