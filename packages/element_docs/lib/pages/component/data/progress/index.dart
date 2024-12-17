import 'package:element_docs/global.dart';

import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'examples/example4.dart';
import 'examples/example5.dart';
import 'examples/example6.dart';
import 'examples/example7.dart';

import 'performance_test.dart';

class ProgressPage extends ResponsivePage {
  const ProgressPage({super.key});

  @override
  String get title => 'Progress 进度条';

  static List<Color?> colors = [
    null,
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.cyan,
    Colors.blue,
    Colors.purple,
    Colors.grey,
    Colors.indigo,
    Colors.purpleAccent,
  ];

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Gap(16),
      ElLinkButton(
        onPressed: () {
          context.push(const PerformanceTestPage());
        },
        type: 'primary',
        child: const ElText('进度条性能测试'),
      ),
      const Example1(title: '直线进度条'),
      const Example2(title: '动画进度条'),
      const Example3(title: '不同方向进度条'),
      const Example4(title: '进度条交互'),
      const Example5(title: '视频进度条'),
      const Example6(title: '环形进度条'),
      const Example7(title: '仪表盘进度条'),
    ];
  }
}
