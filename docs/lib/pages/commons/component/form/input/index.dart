import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

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
      const SectionCard(
        title: 'Tip',
        content: [
          ElText([
            'ElInput 支持双向绑定，推荐你使用 ',
            FlutterHookLink(),
            ' 代替 StatefulWidget，用法更加精简',
          ]),
        ],
      ),
      Example1(),
      // Example2(),
    ];
  }
}
