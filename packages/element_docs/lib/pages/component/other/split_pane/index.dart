import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class SplitPanePage extends ResponsivePage {
  const SplitPanePage({super.key});

  @override
  String get title => 'SplitPane 分割面板';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
      const Example2(title: '水平分割'),
    ];
  }
}
