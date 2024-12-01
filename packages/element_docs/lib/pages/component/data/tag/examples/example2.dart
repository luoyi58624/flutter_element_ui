import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key, required this.title});

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
      children: El.themeTypes
          .mapIndexed((i, e) => ElTag(
                'Tag ${i + 1}',
                type: e,
                closable: true,
                onClose: () {
                  el.message.show('点击了关闭按钮', type: e);
                },
              ))
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
          .mapIndexed((i, e) => ElTag(
                'Tag ${i + 1}',
                type: e,
                plain: true,
                closable: true,
                onClose: () {
                  el.message.show('点击了关闭按钮', type: e);
                },
              ))
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
      children: El.themeTypes
          .mapIndexed((i, e) => ElTag(
                'Tag \${i + 1}',
                type: e,
                closable: true,
                onClose: () {
                  el.message.show('点击了关闭按钮', type: e);
                },
              ))
          .toList(),
    );
  }
}''';
