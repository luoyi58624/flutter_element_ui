import 'dart:math';

import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class Example3 extends HookWidget {
  const Example3({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
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
    final progress = useState(20.0);
    final isDrag = useState(false);

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onHorizontalDragDown: (e) {
          progress.value = e.localPosition.dx / constraints.maxWidth * 100;
          // 在当前帧构建完毕后再设置 isDarg，后续更新进度时禁用动画
          ElUtil.nextTick((){
            isDrag.value = true;
          });
        },
        onHorizontalDragUpdate: (e) {
          final value = e.localPosition.dx / constraints.maxWidth * 100;
          progress.value = min(100, max(value, 0));
        },
        onHorizontalDragEnd: (e) {
          isDrag.value = false;
        },
        onHorizontalDragCancel: () {
          isDrag.value = false;
        },
        child: HoverBuilder(
          cursor: SystemMouseCursors.click,
          builder: (context) {
            final isHover = context.isHover;
            return ElProgress(
              progress.value,
              disabledAnimate: isDrag.value,
              size: isHover || isDrag.value ? 16 : 6,
              color: isHover || isDrag.value ? Colors.green : null,
            );
          },
        ),
      );
    });
  }
}

String get code => '''
/// 此示例实现一个简易的 Slider 滑块
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final progress = useState(20.0);
    final isDrag = useState(false);

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onHorizontalDragDown: (e) {
          progress.value = e.localPosition.dx / constraints.maxWidth * 100;
          // 在当前帧构建完毕后再设置 isDarg，后续更新进度时禁用动画
          ElUtil.nextTick((){
            isDrag.value = true;
          });
        },
        onHorizontalDragUpdate: (e) {
          final value = e.localPosition.dx / constraints.maxWidth * 100;
          progress.value = min(100, max(value, 0));
        },
        onHorizontalDragEnd: (e) {
          isDrag.value = false;
        },
        onHorizontalDragCancel: () {
          isDrag.value = false;
        },
        child: HoverBuilder(
          cursor: SystemMouseCursors.click,
          builder: (context) {
            final isHover = context.isHover;
            return ElProgress(
              progress.value,
              disabledAnimate: isDrag.value,
              size: isHover || isDrag.value ? 16 : 6,
              color: isHover || isDrag.value ? Colors.green : null,
            );
          },
        ),
      );
    });
  }
}''';
