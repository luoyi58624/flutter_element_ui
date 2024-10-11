import 'package:example/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'examples/example4.dart';

class SwitchPage extends ResponsivePage {
  const SwitchPage({super.key});

  @override
  String get title => 'Switch 开关';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      const Example1(title: '基础使用'),
      const Example2(title: '尺寸'),
      const Example3(title: '激活颜色'),
      const Example4(title: '禁用状态'),
    ];
  }
}
