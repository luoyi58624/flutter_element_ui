import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example3 extends StatelessWidget {
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
      spacing: 16,
      runSpacing: 8,
      children: [null, ...El.themeTypes]
          .map((type) => ElLinkButton(type: type, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example2 extends StatelessWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [null, ...El.themeTypes]
          .map((type) =>
              ElLinkButton(type: type, disabled: true, child: 'Hello'))
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
