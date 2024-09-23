import 'package:docs/global.dart';

import 'package:flutter/material.dart';

import './examples/example1.dart';
import './examples/example2.dart';

class ProgressPage extends ResponsivePage {
  const ProgressPage({super.key});

  @override
  String get title => 'Progress 进度条';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '直线进度条'),
      const Example2(title: '直线进度条'),
    ];
  }
}
