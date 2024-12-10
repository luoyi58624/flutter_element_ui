import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';

class ScrollbarPage extends ResponsivePage {
  const ScrollbarPage({super.key});

  @override
  String get title => 'Scrollbar 滚动条';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
      const Example2(title: '定制滚动条外观'),
      const Example3(title: '横向、垂直滚动条'),
    ];
  }
}
