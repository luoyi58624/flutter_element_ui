import 'package:element_docs/global.dart';
import 'package:flutter/widgets.dart';

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
        const Gap(8),
        ElButtonTheme.merge(
          data: ElButtonThemeData(
            borderBuilder: (state) => Border.all(
              width: state.isActive ? 1.5 : 1.0,
              color: state.color,
            ),
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
            type: El.success,
            borderBuilder: (state) => Border.all(
              width: state.isActive ? 1.5 : 1.0,
              color: state.color,
            ),
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
