import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example4 extends StatelessWidget {
  const Example4({super.key, required this.title});

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
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElButton(type: 'primary', child: ElIcon(ElIcons.edit)),
        ElButton(type: 'primary', child: ElIcon(ElIcons.share)),
        ElButton(type: 'primary', child: ElIcon(ElIcons.delete)),
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

class _Example2 extends StatelessWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElButton(type: 'primary', disabled: true, child: ElIcon(ElIcons.edit)),
        ElButton(type: 'primary', disabled: true, child: ElIcon(ElIcons.share)),
        ElButton(
            type: 'primary', disabled: true, child: ElIcon(ElIcons.delete)),
        ElButton(
          type: 'primary',
          disabled: true,
          leftIcon: ElIcon(ElIcons.search),
          child: 'Search',
        ),
        ElButton(
          type: 'primary',
          disabled: true,
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
    return const Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        ElButton(type: 'primary', child: ElIcon(ElIcons.edit)),
        ElButton(type: 'primary', child: ElIcon(ElIcons.share)),
        ElButton(type: 'primary', child: ElIcon(ElIcons.delete)),
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
}''';
