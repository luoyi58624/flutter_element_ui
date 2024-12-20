import 'package:element_docs/global.dart';
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
      ElLinkButton(
        onPressed: () {
          context.push(const TextAnimateTestPage());
        },
        type: 'primary',
        child: const ElText('文本动画性能测试'),
      ),
      const Gap(8),
      ElLinkButton(
        onPressed: () {
          context.push(ScrollPerformanceTest(
            title: '文本滚动性能测试',
            leftBuilder: (context, index) => Text('Text - ${index + 1}'),
            rightBuilder: (context, index) => ElText('ElText - ${index + 1}'),
          ));
        },
        type: 'primary',
        child: const ElText('文本滚动性能测试'),
      ),
      const Example1(title: '普通文本'),
      const Example2(title: '富文本'),
      const Example3(title: '自定义文本组件'),
      const Gap(50),
    ];
  }
}
