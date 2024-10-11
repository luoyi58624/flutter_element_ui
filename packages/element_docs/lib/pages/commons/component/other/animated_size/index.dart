import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'text_animate_test.dart';
import 'text_scroll_test.dart';

class AnimatedSizePage extends ResponsivePage {
  const AnimatedSizePage({super.key});

  @override
  String get title => 'AnimatedSize 动画尺寸';

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
    ];
  }
}
