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
            '对于嵌套事件你需要手动控制事件冒泡，其机制与 Web 类似。'
          ]),
        ],
      ),
      textGap,
      const SectionCard(
        title: 'Tip',
        content: [
          '之所以不使用 GestureDetector 体系进行二次封装，是因为在有些情况下需要允许事件冒泡。',
          '例如：ElLink + ElButton，如果使用 GestureDetector 进行封装，那么手势竞技场会导致 Button 阻止链接跳转事件，'
              '注意：即使你没有设置 onTap，ElLink 也不会触发，因为 Button 监听了 onTapDown 事件来更新样式，'
              '这就导致了用户必须在 Button 中手动跳转链接，很不方便。',
          '其次，手势竞技场无法阻止 Listener、onTapDown 事件的触发，如果父级监听了它们，'
              '你没有任何手段去阻止它们，即使有，也非常麻烦。'
        ],
      ),
      const Example1(title: '基础使用'),
      const Example2(title: '事件冒泡'),
      const Example3(title: '解决 GestureDetector 事件冲突'),
      const Example4(title: '拖拽事件'),
    ];
  }
}
