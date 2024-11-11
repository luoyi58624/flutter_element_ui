import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class EventPage extends ResponsivePage {
  const EventPage({super.key});

  @override
  String get title => 'Event 测试';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '点击事件冒泡'),
      const Example2(title: '双击事件冒泡'),
    ];
  }
}
