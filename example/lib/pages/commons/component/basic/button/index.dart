import 'package:example/global.dart';
import 'package:flutter/material.dart';

import '../../../../../router/router_config.dart';
import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'examples/example4.dart';
import 'examples/example5.dart';
import 'examples/example6.dart';
import 'examples/example7.dart';
import 'examples/example8.dart';
import 'examples/example9.dart';
import 'examples/example10.dart';

class ButtonPage extends ResponsivePage {
  const ButtonPage({super.key});

  static final buttonTypes = [null, ...elThemeTypes];

  @override
  String get title => 'Button 按钮';

  @override
  String get path => '/${RootRoute.component.$2}/button';

  @override
  List<Widget> buildPage(BuildContext context) {
    return const [
      Example1(title: '基础用法'),
      Example2(title: '禁用状态'),
      Example3(title: '链接按钮'),
      Example4(title: '文字按钮'),
      Example5(title: '图标按钮'),
      Example6(title: '加载状态'),
      Example7(title: '自定义颜色'),
      Example8(title: '块级按钮'),
      Example9(title: '自定义尺寸'),
      Example10(title: '分割按钮'),
    ];
  }
}
