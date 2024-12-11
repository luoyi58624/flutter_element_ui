import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example5 extends StatelessWidget {
  const Example5({super.key, required this.title});

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

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [null, ...El.themeTypes]
          .map((type) => ElLinkButton('Hello', type: type))
          .toList(),
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [null, ...El.themeTypes]
          .map((type) => ElLinkButton(type: type, child: 'Hello'))
          .toList(),
    );
  }
}''';
