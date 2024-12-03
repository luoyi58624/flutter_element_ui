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
            '这只是分割器的基本使用，页面分割器实际上就是绘制一个可拖拽控件，'
                '主要特点是它在页面上可能是一个细小边框、或者根本不绘制任何元素，'
                '同时要求能够产生交互，交互区域范围需要比较大，否则鼠标不易触发。',
            ElText([
              '要在 Flutter 当中要实现这个功能可并不简单，'
                  '由于底层事件的',
              ElLink(
                href: 'https://github.com/flutter/flutter/issues/75747',
                decoration: ElLinkDecoration.hoverUnderline,
                child: '命中策略',
              ),
              '，绘制可交互的控件将直接排除 Stack 小部件，我目前能够想到的只有 Overlay 小部件，'
                  '下面这个示例展示了 ElSplit 基本用法。',
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
              child: ElSplitTheme(
                // 为了解决 Flutter 中事件命中限制，ElSplit 可交互拖拽器是通过 Overlay 插入的，
                // 请保证在拖拽过程中主题对象是相同的，否则会不断触发 Overlay 的删除、插入
                data: ElSplitThemeData(
                  size: 1,
                  color: context.elTheme.layoutTheme.borderColor!,
                  activeColor: context.elTheme.primary,
                  // 避免匿名函数，否则对象一定不相等
                  onChanged: onChanged,
                  onEnd: onEnd,
                ),
                child: const ElSplit(),
              ),
            ),
          ],
        ),
      );
    });
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
              child: ElSplitTheme(
                // 为了解决 Flutter 中事件命中限制，ElSplit 可交互拖拽器是通过 Overlay 插入的，
                // 请保证在拖拽过程中主题对象是相同的，否则会不断触发 Overlay 的删除、插入
                data: ElSplitThemeData(
                  size: 1,
                  color: context.elTheme.layoutTheme.borderColor!,
                  activeColor: context.elTheme.primary,
                  // 避免匿名函数，否则对象一定不相等
                  onChanged: onChanged,
                  onEnd: onEnd,
                ),
                child: const ElSplit(),
              ),
            ),
          ],
        ),
      );
    });
  }
}''';
