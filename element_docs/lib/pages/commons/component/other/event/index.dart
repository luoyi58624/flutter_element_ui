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
            'ElEvent 是 Element UI 所有小部件的事件监听类，它直接基于 ',
            LinkWidgets.listener,
            ' 小部件实现，这意味着它不参与手势竞技场的竞争，你可以直接将它当作 ',
            LinkWidgets.listener,
            ' 小部件的加强版，所以，如果你使用 ',
            LinkWidgets.gestureDetector,
            ' 小部件进行嵌套，将会出现事件冒泡。'
          ]),
        ],
      ),
      const Example1(title: '基础使用'),
      const Example2(title: '事件冒泡'),
    ];
  }
}
