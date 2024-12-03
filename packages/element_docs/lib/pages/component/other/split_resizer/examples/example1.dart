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
            'ElSplitResizer 拖拽分割器，特点是在页面上可能是一个细小边框、或者根本不绘制任何元素，'
                '但它拥有比较大的实际可交互区域。',
            ElText([
              '受底层事件的',
              ElLink(
                href: 'https://github.com/flutter/flutter/issues/75747',
                decoration: ElLinkDecoration.hoverUnderline,
                child: '命中策略',
              ),
              '影响，绘制可交互的控件不能简单地使用 Stack 小部件，只能使用较复杂的 Overlay 小部件，'
                  '这导致当修改配置时，要刷新 Overlay 中的内容相当麻烦，为了减少源码复杂度，'
                  '我直接简单粗暴地通过对比新旧主题数据来移除、插入 Overlay，如果主题数据没有发生变化，'
                  '那么分割器将不会重建，否则每次 build 时都会地移除、插入 Overlay。',
            ]),
          ],
        ),
        textGap,
        const SectionCard(
          title: 'Tip',
          type: El.info,
          content: [
            '更新：经过测试即使频繁移除、插入 Overlay，对性能影响也不大，但如果你有强迫症，'
                '那么 onChanged、onEnd 不要设置为匿名函数即可。',
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

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final $left = useState(100.0);

    return LayoutBuilder(builder: (context, constraints) {
      final double left = min(max($left.value, 0), constraints.maxWidth);
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
                  onChanged: (double value) {
                    $left.value += value;
                  },
                  onEnd: () {
                    $left.value =
                        min(max($left.value, 0), constraints.maxWidth);
                  },
                ),
                child: const ElSplitResizer(),
              ),
            ),
          ],
        ),
      );
    });
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final \$left = useState(100.0);

    return LayoutBuilder(builder: (context, constraints) {
      final double left = min(max(\$left.value, 0), constraints.maxWidth);
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
                  onChanged: (double value) {
                    \$left.value += value;
                  },
                  onEnd: () {
                    \$left.value =
                        min(max(\$left.value, 0), constraints.maxWidth);
                  },
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
