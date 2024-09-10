import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'text_animate_test.dart';
import 'text_scroll_test.dart';

class TextPage extends ResponsivePage {
  const TextPage({super.key});

  @override
  String get title => 'Text 文本';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Gap(16),
      ElButton(
        onPressed: () {
          context.push(const TextAnimateTestPage());
        },
        link: true,
        type: 'primary',
        child: const ElText('文本动画性能测试'),
      ),
      ElButton(
        onPressed: () {
          context.push(const TextScrollTestPage());
        },
        link: true,
        type: 'primary',
        child: const ElText('文本滚动性能测试'),
      ),
      const Example1(),
      const Example2(),
      const Example3(),
      const Gap(50),
    ];
  }
}
