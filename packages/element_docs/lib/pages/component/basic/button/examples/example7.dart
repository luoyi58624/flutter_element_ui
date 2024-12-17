import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example7 extends StatelessWidget {
  const Example7({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          children: const [_Example()],
        ),
      ],
    );
  }
}

class _Example extends StatelessWidget {
  const _Example({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElOutlineButton(child: 'Hello', block: true),
        ElButton(child: 'Hello', block: true, type: 'primary'),
        ElButton(
          child: 'Hello',
          block: true,
          type: 'primary',
          round: true,
        ),
        ElOutlineButton(
          child: 'Hello',
          block: true,
          type: 'primary',
        ),
      ],
    );
  }
}

String get code => '''
ElButton(child: 'Hello', block: true)''';
