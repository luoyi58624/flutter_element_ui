import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example8 extends StatelessWidget {
  const Example8({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: ['Element UI 提供了 5 种预设尺寸样式，你可以通过嵌套 ElSize 小部件指定后代组件应用的尺寸'],
        ),
        textGap,
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
            Gap(8),
            _Example5(),
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
    return ElSize(
      El.mini,
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton(child: 'Hello', type: e),
          ),
        ],
      ),
    );
  }
}

class _Example2 extends StatelessWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    return ElSize(
      El.small,
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton(child: 'Hello', type: e),
          ),
        ],
      ),
    );
  }
}

class _Example3 extends StatelessWidget {
  const _Example3();

  @override
  Widget build(BuildContext context) {
    return ElSize(
      El.medium,
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton(child: 'Hello', type: e),
          ),
        ],
      ),
    );
  }
}

class _Example4 extends StatelessWidget {
  const _Example4();

  @override
  Widget build(BuildContext context) {
    return ElSize(
      El.large,
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton(child: 'Hello', type: e),
          ),
        ],
      ),
    );
  }
}

class _Example5 extends StatelessWidget {
  const _Example5();

  @override
  Widget build(BuildContext context) {
    return ElSize(
      El.xLarge,
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton(child: 'Hello', type: e),
          ),
        ],
      ),
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return ElSize(
      El.mini,
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton(child: 'Hello', type: e),
          ),
        ],
      ),
    );
  }
}''';
