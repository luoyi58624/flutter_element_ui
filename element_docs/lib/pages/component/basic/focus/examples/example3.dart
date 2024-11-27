import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example3 extends HookWidget {
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
    return const ElFocusScope(
      child: ElButtonTheme(
        data: ElButtonThemeData(
          type: El.primary,
        ),
        child: ElButtonGroup(
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
          ],
        ),
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
