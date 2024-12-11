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
        ElButton2(type: 'primary', child: ElIcon(ElIcons.edit)),
        ElButton2(type: 'primary', child: ElIcon(ElIcons.share)),
        ElButton2(type: 'primary', child: ElIcon(ElIcons.delete)),
        ElButton2(
          type: 'primary',
          leftIcon: ElIcon(ElIcons.search),
          child: 'Search',
        ),
        ElButton2(
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
    return const ElConfig(
      data: ElConfigData(elSize: ElSize.small),
      child: Wrap(
        spacing: 8,
        children: [
          ElTextButton(
            padding: EdgeInsets.zero,
            child: ElIcon(ElIcons.sHome),
          ),
          ElTextButton(
            type: El.primary,
            padding: EdgeInsets.zero,
            child: ElIcon(ElIcons.share),
          ),
          ElTextButton(
            type: El.success,
            padding: EdgeInsets.zero,
            child: ElIcon(ElIcons.editOutline),
          ),
          ElTextButton(
            type: El.warning,
            padding: EdgeInsets.zero,
            child: ElIcon(ElIcons.warning),
          ),
          ElTextButton(
            type: El.error,
            padding: EdgeInsets.zero,
            child: ElIcon(ElIcons.delete),
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
    return const Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        ElButton2(type: 'primary', child: ElIcon(ElIcons.edit)),
        ElButton2(type: 'primary', child: ElIcon(ElIcons.share)),
        ElButton2(type: 'primary', child: ElIcon(ElIcons.delete)),
        ElButton2(
          type: 'primary',
          leftIcon: ElIcon(ElIcons.search),
          child: 'Search',
        ),
        ElButton2(
          type: 'primary',
          rightIcon: ElIcon(ElIcons.upload2),
          child: '上传',
        ),
      ],
    );
  }
}''';
