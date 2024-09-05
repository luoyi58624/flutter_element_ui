import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/01.dart';
import 'examples/02.dart';
import 'examples/03.dart';
import 'test.dart';

class TextPage extends ResponsivePage {
  const TextPage({super.key});

  @override
  String get title => 'Text 文本';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(),
      const Example2(),
      const Example3(),
      const Gap(50),
      ElButton(
        onPressed: () {
          context.push(const TextTestPage());
        },
        link: true,
        type: 'primary',
        child: const ElText('性能测试'),
      ),
    ];
  }
}
