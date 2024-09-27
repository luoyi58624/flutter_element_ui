import 'package:docs/global.dart';

import 'package:flutter/material.dart';

import './examples/example1.dart';
import './examples/example2.dart';
import './examples/example3.dart';
import './examples/example4.dart';
import './examples/example9.dart';

import 'performance_test.dart';

class ProgressPage extends ResponsivePage {
  const ProgressPage({super.key});

  @override
  String get title => 'Progress 进度条';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Gap(16),
      ElButton(
        onPressed: () {
          context.push(const PerformanceTestPage());
        },
        link: true,
        type: 'primary',
        child: const ElText('进度条性能测试'),
      ),
      const Example1(title: '直线进度条'),
      const Example2(title: '动画进度条'),
      const Example3(title: '不同方向进度条'),
      const Example4(title: '进度条交互'),
      const Example9(title: '视频进度条'),
    ];
  }
}
