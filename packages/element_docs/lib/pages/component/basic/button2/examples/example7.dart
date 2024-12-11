import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example7 extends StatelessWidget {
  const Example7({super.key, required this.title});

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
}

class _Example2 extends HookWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return Row(
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ElButton(
              onPressed: () {
                loading.value = true;
                setTimeout(() {
                  loading.value = false;
                }, 1000);
              },
              height: 32,
              iconSize: 18,
              text: true,
              loading: loading.value,
              padding: EdgeInsets.zero,
              child: const ElIcon(ElIcons.sHome),
            ),
            ElButton(
              height: 32,
              iconSize: 18,
              text: true,
              type: 'primary',
              loading: loading.value,
              padding: EdgeInsets.zero,
              child: const ElIcon(ElIcons.share),
            ),
            ElButton(
              height: 32,
              iconSize: 18,
              text: true,
              type: 'success',
              loading: loading.value,
              padding: EdgeInsets.zero,
              child: const ElIcon(ElIcons.editOutline),
            ),
            ElButton(
              height: 32,
              iconSize: 18,
              text: true,
              type: 'error',
              loading: loading.value,
              padding: EdgeInsets.zero,
              child: const ElIcon(ElIcons.delete),
            ),
          ],
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
