import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import 'examples/example1.dart';
import 'examples/example2.dart';

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
            'ElEvent 直接基于 ',
            LinkWidgets.listener,
            ' 小部件实现，这意味着它不参与手势竞技场的竞争，所以，你不能将它与 ',
            LinkWidgets.gestureDetector,
            ' 小部件进行嵌套，否则会出现事件冒泡。'
          ]),
        ],
      ),
      const Example1(title: '基础使用'),
      const Example2(title: '事件冒泡'),
    ];
  }
}
