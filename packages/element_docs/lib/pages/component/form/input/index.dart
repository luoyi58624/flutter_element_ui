import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';

class InputPage extends ResponsivePage {
  const InputPage({super.key});

  @override
  String get title => 'Input 输入框';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      titleGap,
      const SectionText('通过鼠标或键盘输入字符'),
      textGap,
      const Example1(title: '基础使用'),
      // Example2(),
    ];
  }
}
