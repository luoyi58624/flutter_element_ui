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
          '你可以将 ElEvent 完全当做 Listener 小部件，不过它简单实现了一些点击、双击、右键、长按等常用事件，'
              '最重要的还是手动控制事件冒泡。',
          '手势竞技场功能很强大，但也存在一些缺点，你无法阻止祖先 Listener 的事件、包括 onTapDown 事件你也无法阻止，'
              '或许有解决方案只是我不知道，但应该不简单，使用 ElEvent 只需要简单地插入 ElStopPropagation 即可解决上面问题。',
          '其次是在某些情况下需要允许事件冒泡，例如 ElLink，由于默认会触发事件冒泡，'
              '所以即使 ElLink 嵌套 ElButton 等小部件也能直接触发链接跳转，当然这个问题不是重点，'
              '使用 GestureDetector 小部件只需要重写点击手势即可解决此问题。'
        ],
      ),
      const Example1(title: '基础使用'),
      const Example2(title: '事件冒泡'),
      const Example3(title: '解决 GestureDetector 事件冲突'),
    ];
  }
}
