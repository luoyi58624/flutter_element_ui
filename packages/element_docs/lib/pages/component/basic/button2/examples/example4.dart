import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example4 extends StatelessWidget {
  const Example4({super.key, required this.title});

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
            Gap(8),
            _Example2(),
          ],
        ),
      ],
    );
  }
}

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [null, ...El.themeTypes]
          .map((type) => ElTextButton(type: type, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example2 extends StatelessWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [null, ...El.themeTypes]
          .map((type) => ElTextButton(type: type, bg: true, child: 'Hello'))
          .toList(),
    );
  }
}

String get code => '''
ElTextButton(type: type, child: 'Hello'),
ElTextButton(type: type, bg: true, child: 'Hello'),''';
