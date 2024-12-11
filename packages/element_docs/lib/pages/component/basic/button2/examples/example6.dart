import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example6 extends StatelessWidget {
  const Example6({super.key, required this.title});

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
    return const Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        ElButton2(type: 'primary', child: ElIcon(ElIcons.edit)),
        ElButton2(type: 'primary', child: ElIcon(ElIcons.share)),
        ElButton2(type: 'primary', child: ElIcon(ElIcons.delete)),
        ElButton(
          type: 'primary',
          leftIcon: ElIcon(ElIcons.search),
          child: 'Search',
        ),
        ElButton(
          type: 'primary',
          rightIcon: ElIcon(ElIcons.upload2),
          child: '上传',
        ),
      ],
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
