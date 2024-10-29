import 'package:element_docs/global.dart';
import 'package:flutter/widgets.dart';

class Example3 extends StatelessWidget {
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

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final selectedList = useState<List<int>>([]);

    return Column(
      children: [
        ElButtonGroup.multi(
          selectedList,
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
          child: ElButtonGroup.multi(
            selectedList,
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
          child: ElButtonGroup.multi(
            selectedList,
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
          child: ElButtonGroup.multi(
            selectedList,
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
            round: true,
          ),
          child: ElButtonGroup.multi(
            selectedList,
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
          child: ElButtonGroup.multi(
            selectedList,
            mandatory: true,
            children: const [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
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
    final selectedList = useState<List<int>>([]);

    return Column(
      children: [
        ElButtonGroup.multi(
          selectedList,
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
