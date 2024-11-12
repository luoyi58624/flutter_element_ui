import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'examples/example10.dart';

class EventPage extends ResponsivePage {
  const EventPage({super.key});

  @override
  String get title => 'Event 测试';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example10(title: '基础使用'),
      const Example1(title: '点击事件冒泡'),
      const Example2(title: '双击事件冒泡'),
      const Example3(title: '测试'),
    ];
  }
}
