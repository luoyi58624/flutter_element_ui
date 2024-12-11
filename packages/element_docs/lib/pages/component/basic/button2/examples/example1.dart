import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

const _buttonTypes = [null, ...El.themeTypes];

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
            Gap(8),
            _Example4(),
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
      children: _buttonTypes
          .map((type) => ElButton2(type: type, child: 'Hello'))
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
      children: _buttonTypes
          .map((type) => ElOutlineButton(type: type, child: 'Hello'))
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
      children: _buttonTypes
          .map((type) => ElTextButton(type: type, child: 'Hello'))
          .toList(),
    );
  }
}

class _Example4 extends StatelessWidget {
  const _Example4();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: _buttonTypes
          .map((type) => ElTextButton(type: type, bg: true, child: 'Hello'))
          .toList(),
    );
  }
}

String get code => '''
ElButton(child: 'Hello'),
ElOutlineButton(child: 'Hello'),
ElTextButton(child: 'Hello'),
ElTextButton(bg: true, child: 'Hello'),''';
