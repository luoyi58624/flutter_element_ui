import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';
import 'examples/example4.dart';

class EventPage extends ResponsivePage {
  const EventPage({super.key});

  @override
  String get title => 'Event 交互事件';

  @override
  List<Widget> buildPage(BuildContext context) {
    return [
      titleGap,
      const SectionCard(
        title: 'Warning',
        type: El.warning,
        content: [
          ElText([
            'ElEvent 是 Element UI 所有小部件的事件监听类，它直接基于 ',
            LinkWidgets.listener,
            ' 小部件实现，这意味着它不参与手势竞技场的竞争，',
            '所以，你很容易遇到事件冒泡的情况，'
                '在处理事件冒泡的机制上和 ',
            LinkWidgets.gestureDetector,
            ' 小部件区别在于，一个是自动挡、另一个是手动挡，ElEvent 需要你手动处理事件冒泡，'
                '它的逻辑与 Web 上的事件冒泡机制十分相似'
          ]),
        ],
      ),
      const Example1(title: '基础使用'),
      const Example2(title: '事件冒泡'),
      const Example3(title: '解决 GestureDetector 事件冲突'),
      const Example4(title: '拖拽事件'),
    ];
  }
}
