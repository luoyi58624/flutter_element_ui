import 'package:docs/global.dart';

import 'package:flutter/material.dart';

import './examples/example1.dart';
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
      // const Example2(title: '直线进度条'),
    ];
  }
}
