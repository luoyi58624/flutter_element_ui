import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

class ButtonGroupPage extends ResponsivePage {
  const ButtonGroupPage({super.key});

  @override
  String get title => 'ButtonGroup 按钮组';

  @override
  List<Widget> buildPage(BuildContext context) {
    return const [
      Example1(title: '基础用法'),
      Example2(title: '选中状态'),
    ];
  }
}
