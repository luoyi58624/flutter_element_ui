import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';
import 'examples/example3.dart';

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
            'ElEvent 是 Element UI 大部分小部件的事件监听类，它直接基于 ',
            LinkWidgets.listener,
            ' 小部件实现，这意味着它不参与手势竞技场的竞争，',
            '对于嵌套事件默认情况下会产生事件冒泡，你可以插入 ElStopPropagation 小部件阻止事件冒泡，'
                '或者直接调用 context.stopPropagation() 方法阻止事件冒泡。'
          ]),
        ],
      ),
      textGap,
      const SectionCard(
        title: 'Tip',
        content: [
          'ElEvent 完全相当于 Listener 小部件的增强版，添加它的主要需求是为了能方便地阻止祖先 Listener 小部件的事件执行，'
              '其次在某些情况下需要允许事件冒泡。'
        ],
      ),
      const Example1(title: '基础使用'),
      const Example2(title: '事件冒泡'),
      const Example3(title: '解决 GestureDetector 事件冲突'),
    ];
  }
}
