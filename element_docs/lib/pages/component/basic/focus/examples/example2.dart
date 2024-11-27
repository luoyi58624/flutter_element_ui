import 'dart:math';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../button/index.dart';

class Example2 extends HookWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          allowSelected: true,
          content: [
            '如果按钮处于焦点组中，那么按下它便可得到焦点',
          ],
        ),
        textGap,
        CodeExample(
          code: code,
          children: const [
            _Example(),
            Gap(20),
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
    return ElFocusScope(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [null, ...El.themeTypes]
            .map((type) => ElButton(child: 'Hello', type: type))
            .toList(),
      ),
    );
  }
}

class _Example2 extends StatelessWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    return ElFocusScope(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [null, ...El.themeTypes]
            .map((type) => ElLink(
                href: githubLink,
                child: ElButton(child: 'Link', type: type, link: true)))
            .toList(),
      ),
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return ElFocusScope(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        children: [null, ...El.themeTypes]
            .map((type) => ElButton(child: 'Hello', type: type))
            .toList(),
      ),
    );
  }
}''';
