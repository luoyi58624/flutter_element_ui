import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../../../../router/router_config.dart';
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
import 'examples/example11.dart';
import 'examples/example12.dart';

class ButtonPage extends ResponsivePage {
  const ButtonPage({super.key});

  static final buttonTypes = [null, ...El.themeTypes];

  @override
  String get title => 'Button 按钮';

  @override
  String get path => '/${RootRoute.component.$2}/button';

  @override
  List<Widget> buildPage(BuildContext context) {
    return const [
      textGap,
      _Test(),
      Example1(title: '基础使用'),
      Example2(title: '禁用按钮'),
      Example3(title: '链接按钮'),
      Example4(title: '图标按钮'),
      Example5(title: '文字图标按钮'),
      Example6(title: '加载动画'),
      Example7(title: '块级按钮'),
      Example8(title: '自定义尺寸'),
      Example9(title: '自定义按钮'),
      Example10(title: '按钮组'),
      Example11(title: '垂直按钮组'),
      Example12(title: '分割按钮'),
    ];
  }
}

class _Test extends StatelessWidget {
  const _Test();

  @override
  Widget build(BuildContext context) {
    return ElLinkButton(
      onPressed: () {
        context.push(ScrollPerformanceTest(
          title: '按钮性能测试',
          itemCount: 1000,
          leftBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElevatedButton(
              onPressed: () {},
              child: ElText('Item - ${index + 1}'),
            ),
          ),
          rightBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 8),
            child: ElButton(
              type: El.primary,
              child: ElText('Item - ${index + 1}'),
            ),
          ),
        ));
      },
      type: El.primary,
      child: const ElText('按钮性能测试'),
    );
  }
}
