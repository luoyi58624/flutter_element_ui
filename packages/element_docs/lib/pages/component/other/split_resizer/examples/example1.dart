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
            'ElSplitResizer 拖拽分割器，这是一个偏底层的小部件，它只负责提供拖拽交互，'
                '其特点是它可以不占据页面空间，但依然允许用户进行拖拽交互，这是因为它通过 Overlay 小部件插入了一个较大范围的可交互区域。'
          ],
        ),
        const Gap(8),
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
    // useState 会引起整个 build 重建，会不断触发下面 LayoutBuilder 的条件
    final left = useObs(100.0);

    return LayoutBuilder(builder: (context, constraints) {
      // 布局尺寸如果变小，那么需要同步分隔条的位置，防止溢出
      if (left.value > constraints.maxWidth) {
        nextTick(() => left.value = constraints.maxWidth);
      }

      return Container(
        height: 300,
        decoration: BoxDecoration(border: context.elBorder),
        child: ObsBuilder(builder: (context) {
          // 拖拽的实际位置肯定需要跟随指针，但显示在页面上的位置必须施加限制
          final double positionLeft =
              min(max(left.value, 0), constraints.maxWidth);

          return Stack(
            children: [
              Positioned(
                left: positionLeft,
                top: 0,
                bottom: 0,
                child: ElSplitResizerTheme(
                  data: const ElSplitResizerThemeData(
                    size: 1,
                  ),
                  child: ElSplitResizer(
                    onChanged: (double value) => left.value += value,
                    onEnd: () => left.value = positionLeft,
                  ),
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    // useState 会引起整个 build 重建，会不断触发下面 LayoutBuilder 的条件
    final left = useObs(100.0);

    return LayoutBuilder(builder: (context, constraints) {
      // 布局尺寸如果变小，那么需要同步分隔条的位置，防止溢出
      if (left.value > constraints.maxWidth) {
        nextTick(() => left.value = constraints.maxWidth);
      }

      return Container(
        height: 300,
        decoration: BoxDecoration(border: context.elBorder),
        child: ObsBuilder(builder: (context) {
          // 拖拽的实际位置肯定需要跟随指针，但显示在页面上的位置必须施加限制
          final double positionLeft =
              min(max(left.value, 0), constraints.maxWidth);

          return Stack(
            children: [
              Positioned(
                left: positionLeft,
                top: 0,
                bottom: 0,
                child: ElSplitResizerTheme(
                  data: const ElSplitResizerThemeData(
                    size: 1,
                  ),
                  child: ElSplitResizer(
                    onChanged: (double value) => left.value += value,
                    onEnd: () => left.value = positionLeft,
                  ),
                ),
              ),
            ],
          );
        }),
      );
    });
  }
}''';
