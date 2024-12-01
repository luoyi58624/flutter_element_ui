import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example4 extends HookWidget {
  const Example4({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: [
            '对于支持双向绑定的元素，如果通过键盘切换焦点会立即同步绑定的值（多选除外）',
          ],
        ),
        textGap,
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
    final loading = useState(false);
    final selectedIndex = useState(-1);
    return Column(
      children: [
        ElFocusScope(
          child: ElButtonTheme(
            data: const ElButtonThemeData(
              type: El.primary,
            ),
            child: ElButtonGroup.single(
              selectedIndex,
              children: const [
                ElButton(child: '选项一'),
                ElButton(child: '选项二'),
                ElButton(child: '选项三'),
              ],
            ),
          ),
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
