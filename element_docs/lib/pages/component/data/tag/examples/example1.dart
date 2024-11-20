import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example1 extends StatelessWidget {
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
            Gap(8),
            _Example2(),
            Gap(8),
            _Example3(),
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
      children: El.themeTypes
          .mapIndexed((i, e) => ElTag('Tag ${i + 1}', type: e))
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
      children: El.themeTypes
          .mapIndexed((i, e) => ElTag('Tag ${i + 1}', type: e, plain: true))
          .toList(),
    );
  }
}

class _Example3 extends StatelessWidget {
  const _Example3();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: El.themeTypes
          .mapIndexed((i, e) =>
              ElTag('Tag ${i + 1}', type: e, plain: true, round: true))
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
      spacing: 8,
      runSpacing: 8,
      children: El.themeTypes.map((e) => ElTag('Hello', type: e)).toList(),
    );
  }
}''';
