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
    return ElConfig(
      data: const ElConfigData(elSize: ElSize.mini),
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton2(child: 'Hello', type: e),
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
    return ElConfig(
      data: const ElConfigData(elSize: ElSize.small),
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton2(child: 'Hello', type: e),
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
    return ElConfig(
      data: const ElConfigData(elSize: ElSize.medium),
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton2(child: 'Hello', type: e),
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
    return ElConfig(
      data: const ElConfigData(elSize: ElSize.large),
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton2(child: 'Hello', type: e),
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
    return ElConfig(
      // 将按钮设置为 mini 尺寸
      data: const ElConfigData(elSize: ElSize.mini),
      child: Wrap(
        spacing: 8,
        children: [
          ...El.themeTypes.map(
            (e) => ElButton2(child: 'Hello', type: e),
          ),
        ],
      ),
    );
  }
}''';
