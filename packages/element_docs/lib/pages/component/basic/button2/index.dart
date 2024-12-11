import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../../../../router/router_config.dart';
import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'examples/example4.dart';
import 'examples/example5.dart';
import 'examples/example6.dart';

class ButtonPage2 extends ResponsivePage {
  const ButtonPage2({super.key});

  static final buttonTypes = [null, ...El.themeTypes];

  @override
  String get title => 'Button2 按钮';

  @override
  String get path => '/${RootRoute.component.$2}/button2';

  @override
  List<Widget> buildPage(BuildContext context) {
    return const [
      Example1(title: '基础使用'),
      Example2(title: '自定义颜色'),
      Example3(title: '边框按钮'),
      Example4(title: '文字按钮'),
      Example5(title: '链接按钮'),
      Example6(title: '图标按钮'),
    ];
  }
}
