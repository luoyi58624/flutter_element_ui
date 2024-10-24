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
          ],
        ),
      ],
    );
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final selected = useState(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButtonGroup.single(
          selected,
          children: const [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
            ElButton(child: '选项四'),
          ],
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            plain: true,
          ),
          child: ElButtonGroup.single(
            selected,
            children: const [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            type: El.primary,
          ),
          child: ElButtonGroup.single(
            selected,
            children: const [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            type: El.success,
          ),
          child: ElButtonGroup.single(
            selected,
            mandatory: true,
            children: const [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            type: El.warning,
            plain: true,
          ),
          child: ElButtonGroup.single(
            selected,
            children: const [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            type: El.error,
            plain: true,
            round: true,
          ),
          child: ElButtonGroup.single(
            selected,
            mandatory: true,
            children: const [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            text: true,
          ),
          child: ElButtonGroup.single(
            selected,
            children: const [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            type: El.success,
            text: true,
          ),
          child: ElButtonGroup.single(
            selected,
            mandatory: true,
            children: const [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: ElButtonThemeData(
            bgColor: context.isDark ? Colors.purpleAccent : Colors.purple,
            text: true,
          ),
          child: ElButtonGroup.single(
            selected,
            mandatory: true,
            children: const [
              ElButton(child: ElIcon(ElIcons.edit)),
              ElButton(child: ElIcon(ElIcons.share)),
              ElButton(child: ElIcon(ElIcons.delete)),
              ElButton(child: ElIcon(ElIcons.upload)),
            ],
          ),
        ),
      ],
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final selected = useState(-1);

    return Column(
      children: [
        ElButtonGroup.single(
          selected,
          children: const [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
            ElButton(child: '选项四'),
          ],
        ),
      ],
    );
  }
}''';
