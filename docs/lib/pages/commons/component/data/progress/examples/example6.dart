import 'dart:math';

import 'package:docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example6 extends HookWidget {
  const Example6({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final progress = useState(0.0);
    final color = ProgressPage.colors[(progress.value / 10).toInt()];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          children: [
            ElProgress.circle(
              progress.value,
              color: color,
              duration: const Duration(milliseconds: 600),
              curve: Curves.ease,
            ),
            const Gap(16),
            Row(
              children: [
                ElButton(
                  onPressed: () {
                    progress.value = max(0, progress.value - 10);
                  },
                  child: '-10',
                ),
                const Gap(8),
                ElButton(
                  onPressed: () {
                    progress.value = min(100, progress.value + 10);
                  },
                  child: '+10',
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

String get code => '''
SizedBox(
  height: 300,
  child: ElProgress(50, axis: AxisDirection.up),
),''';
