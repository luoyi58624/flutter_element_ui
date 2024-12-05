import 'dart:math';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example1 extends HookWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: [
            'ElSplitResizer 主要特点是它在页面上可能是一个细小边框、或者根本不绘制任何元素，'
                '但它需要较大的交互区域范围，否则鼠标不易触发。',
            ElText([
              '但是受底层事件的',
              ElLink(
                href: 'https://github.com/flutter/flutter/issues/75747',
                decoration: ElLinkDecoration.hoverUnderline,
                child: '命中策略',
              ),
              '影响，绘制可交互的控件不能简单地使用 Stack 小部件，只能使用较复杂的 Overlay 小部件，'
                  '这导致当修改配置时，要刷新 Overlay 中的内容相当麻烦，为了减少源码复杂度，'
                  '我直接简单粗暴地通过对比新旧主题数据来移除、插入 Overlay，所以在 build 过程中，'
                  '请保证传递的主题对象不会发生变化，否则会频繁地移除、插入 Overlay。',
            ]),
          ],
        ),
        textGap,
        CodeExample(
          code: code,
          children: const [
            _Example(),
          ],
        ),
      ],
    );
  }
}

class _Example extends StatefulWidget {
  const _Example();

  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example> {
  late BoxConstraints _constraints;
  double _left = 100;

  void onChanged(double value) {
    setState(() {
      _left += value;
    });
  }

  void onEnd() {
    setState(() {
      _left = min(max(_left, 0), _constraints.maxWidth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}

String get code => '''
class _Example extends StatefulWidget {
  const _Example();

  @override
  State<_Example> createState() => _ExampleState();
}

class _ExampleState extends State<_Example> {
  late BoxConstraints _constraints;
  double _left = 100;

  void onChanged(double value) {
    setState(() {
      _left += value;
    });
  }

  void onEnd() {
    setState(() {
      _left = min(max(_left, 0), _constraints.maxWidth);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      _constraints = constraints;
      final double left = min(max(_left, 0), _constraints.maxWidth);
      return SizedBox(
        height: 300,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: left,
                height: 300,
                color: Colors.green,
              ),
            ),
            Positioned(
              left: left,
              right: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: double.infinity,
                height: 300,
                color: Colors.grey,
              ),
            ),
            Positioned(
              left: left,
              top: 0,
              bottom: 0,
              child: ElSplitResizerTheme(
                data: ElSplitResizerThemeData(
                  activeColor: context.elTheme.primary,
                  // 避免匿名函数，否则对象一定不相等
                  onChanged: onChanged,
                  onEnd: onEnd,
                ),
                child: const ElSplitResizer(),
              ),
            ),
          ],
        ),
      );
    });
  }
}''';
