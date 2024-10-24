import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'performance_test.dart';
import 'test.dart';

class ButtonGroupPage extends ResponsivePage {
  const ButtonGroupPage({super.key});

  @override
  String get title => 'ButtonGroup 按钮组';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      textGap,
      ElButton(
        onPressed: () {
          context.push(const ButtonGroupTestPage());
        },
        link: true,
        type: 'primary',
        child: const ElText('按钮组功能测试'),
      ),
      const Gap(8),
      ElButton(
        onPressed: () {
          context.push(const PerformanceTestPage());
        },
        link: true,
        type: 'primary',
        child: const ElText('按钮组滚动性能测试'),
      ),
      const Example1(title: '基础用法'),
      const Example2(title: '单选按钮组'),
      const Example3(title: '多选按钮组'),
    ];
  }
}
