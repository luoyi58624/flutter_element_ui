import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class MessagePage extends ResponsivePage {
  const MessagePage({super.key});

  @override
  String get title => 'Message 消息提示';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
      const Example2(title: '分组消息合并'),
    ];
  }
}
