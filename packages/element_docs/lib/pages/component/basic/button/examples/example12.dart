import 'dart:ui';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example12 extends StatelessWidget {
  const Example12({super.key, required this.title});

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
    return const ElButtonGroup2(
      children: [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: ElIcon(ElIcons.arrowDown)),
      ],
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return const ElButtonGroup2(
      children: [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: ElIcon(ElIcons.arrowDown)),
      ],
    );
  }
}''';
