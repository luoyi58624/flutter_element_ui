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

GlobalKey<ElProgressState> _progressKey = GlobalKey();

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final progress = useState(20.0);
    final isDrag = useState(false);

    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onHorizontalDragDown: (e) {
          isDrag.value = true;

          progress.value = e.localPosition.dx / constraints.maxWidth * 100;
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
              key: _progressKey,
              progress.value,
              size: isHover || isDrag.value ? 16 : 6,
              color: isHover || isDrag.value ? Colors.green : null,
              boxSize: 16,
            );
          },
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
    final progress = useState(20.0);
    final isDrag = useState(false);
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onHorizontalDragDown: (e) {
          isDrag.value = true;
          progress.value = e.localPosition.dx / constraints.maxWidth * 100;
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
              size: isHover || isDrag.value ? 16 : 6,
              boxSize: 16,
            );
          },
        ),
      );
    });
  }
}''';
