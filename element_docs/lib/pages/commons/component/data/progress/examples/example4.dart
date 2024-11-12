import 'dart:async';
import 'dart:math';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example4 extends HookWidget {
  const Example4({super.key, required this.title});

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
            '注意：进度条外部盒子就是一个简单的 SizedBox，它会受到父级约束影响从而改变自身尺寸，'
                '例如第一个垂直进度条的可交互范围就填充了整个区域，鼠标未悬停在进度条上便触发了悬停效果，'
                '这是 Flutter 布局约束的基础规则，要解决这个问题只需包裹 Align 即可。'
          ],
        ),
        textGap,
        CodeExample(
          code: code,
          children: const [
            SizedBox(
              height: 100,
              child: Row(
                children: [
                  Expanded(child: _Example2(true)),
                  Expanded(child: _Example(false)),
                  Expanded(child: Center(child: _Example2(false))),
                  Expanded(child: _Example(true)),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Timer? _timer;

class _Example extends HookWidget {
  const _Example(this.reverse);

  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final progress = useState(20.0);
    final isDrag = useState(false);

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onHorizontalDragDown: (e) {
          double value = e.localPosition.dx / constraints.maxWidth * 100;
          if (reverse) value = 100.0 - value;
          progress.value = value;
          if (_timer != null) {
            _timer!.cancel();
            _timer = null;
          }
          _timer = setTimeout(() {
            _timer = null;
            isDrag.value = true;
          }, 150);
        },
        onHorizontalDragUpdate: (e) {
          double value = e.localPosition.dx / constraints.maxWidth * 100;
          if (reverse) value = 100.0 - value;
          progress.value = min(100, max(value, 0));
        },
        onHorizontalDragEnd: (e) {
          if (_timer != null) {
            _timer!.cancel();
            _timer = null;
          }
          isDrag.value = false;
        },
        onHorizontalDragCancel: () {
          if (_timer != null) {
            _timer!.cancel();
            _timer = null;
          }
          isDrag.value = false;
        },
        child: ElHover(
          cursor: SystemMouseCursors.click,
          builder: (context) {
            final isHover = context.isHover;
            return ElProgress(
              progress.value,
              // 拖拽事件非常频繁，当开始拖拽时我们需要将 value 动画时间设置为 0
              duration: Duration(milliseconds: isDrag.value ? 0 : 150),
              axis: reverse ? AxisDirection.left : AxisDirection.right,
              strokeSize: isHover || isDrag.value ? 16 : 6,
              color: isHover || isDrag.value ? Colors.green : null,
            );
          },
        ),
      );
    });
  }
}

class _Example2 extends HookWidget {
  const _Example2(this.reverse);

  final bool reverse;

  @override
  Widget build(BuildContext context) {
    final progress = useState(20.0);
    final isDrag = useState(false);

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onHorizontalDragDown: (e) {
          double value = e.localPosition.dy / constraints.maxHeight * 100;
          if (reverse) value = 100.0 - value;
          progress.value = value;
          // 在当前帧构建完毕后再设置 isDrag，后续更新进度时禁用动画
          nextTick(() {
            isDrag.value = true;
          });
        },
        onHorizontalDragUpdate: (e) {
          double value = e.localPosition.dy / constraints.maxHeight * 100;
          if (reverse) value = 100.0 - value;
          progress.value = min(100, max(value, 0));
        },
        onHorizontalDragEnd: (e) {
          isDrag.value = false;
        },
        onHorizontalDragCancel: () {
          isDrag.value = false;
        },
        child: ElHover(
          cursor: SystemMouseCursors.click,
          builder: (context) {
            final isHover = context.isHover;
            return ElProgress(
              progress.value,
              // 拖拽事件非常频繁，当开始拖拽时我们需要将 value 动画时间设置为 0
              duration: Duration(milliseconds: isDrag.value ? 0 : 200),
              axis: reverse ? AxisDirection.up : AxisDirection.down,
              strokeSize: isHover || isDrag.value ? 16 : 6,
              color: isHover || isDrag.value ? Colors.green : null,
            );
          },
        ),
      );
    });
  }
}

String get code => '''
/// 由于篇幅有限，所以此示例只展示一个方向的交互
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
          // 下一帧更新 isDrag，这样第一次更新进度能够触发动画，后续拖拽时禁用动画
          nextTick((){
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
        child: ElHover(
          cursor: SystemMouseCursors.click,
          builder: (context) {
            final isHover = context.isHover;
            return ElProgress(
              progress.value,
              // 拖拽事件非常频繁，当开始拖拽时我们需要将 value 动画时间设置为 0
              duration: Duration(milliseconds: isDrag.value ? 0 : 200),
              strokeSize: isHover || isDrag.value ? 16 : 6,
              color: isHover || isDrag.value ? Colors.green : null,
            );
          },
        ),
      );
    });
  }
}''';
