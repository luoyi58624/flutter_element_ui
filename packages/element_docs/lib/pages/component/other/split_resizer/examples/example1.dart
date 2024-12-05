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
      return Container(
        height: 300,
        decoration: BoxDecoration(border: context.elBorder),
        child: Stack(
          children: [
            Positioned(
              left: left,
              top: 0,
              bottom: 0,
              child: ElSplitResizerTheme(
                data: ElSplitResizerThemeData(
                  size: 1,
                  activeColor: context.elTheme.primary,
                  onChanged: (double value) => $left.value += value,
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
                  // 使用匿名函数会导致主题对象永远不一致，进而引起分割器频繁 build，
                  // 不过这点性能影响并不大
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
