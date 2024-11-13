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
            'ElEvent 直接基于 ',
            LinkWidgets.listener,
            ' 小部件实现，这意味着它不参与手势竞技场的竞争，所以，你不能将它与 ',
            LinkWidgets.gestureDetector,
            ' 小部件进行嵌套，否则会出现事件冒泡。'
          ]),
        ],
      ),
      textGap,
      const SectionCard(
        title: 'Tip',
        content: [
          ElText([
            '究其原因是 Flutter 官方实现的手势竞技场灵活性比较低，所以我没有基于 ',
            LinkWidgets.gestureDetector,
            ' 小部件进行封装，而是使用最底层的 ',
            LinkWidgets.listener,
            ' 小部件重新实现了单击、双击、长按、右键等交互，Element UI 的所有小部件事件处理都是基于 ElEvent 实现，'
                '这也意味这当你使用 Element UI 任意一个组件时，若遇到嵌套事件的场景你必须使用 ElEvent，否则会发生事件冒泡。'
          ])
        ],
      ),
      const Example1(title: '基础使用'),
      const Example2(title: '事件冒泡'),
      const Example3(title: '双击事件冒泡'),
    ];
  }
}
