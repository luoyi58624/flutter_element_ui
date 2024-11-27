import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'examples/example4.dart';

class FocusPage extends ResponsivePage {
  const FocusPage({super.key});

  @override
  String get title => 'Focus 焦点';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      titleGap,
      const SectionText('Element UI 提供了 ElFocusScope 小部件，'
          '它可以简化焦点的使用。'),
      const Example1(title: '基础使用'),
      const Example2(title: '焦点按钮'),
      const Example3(title: '焦点按钮组'),
      const Example4(title: '嵌套焦点按钮'),
    ];
  }
}
