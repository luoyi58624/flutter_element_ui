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
    final selectedIndex = useState(-1);
    return Column(
      children: [
        ElFocusScope(
          child: ElButtonGroup.single(
            selectedIndex,
            type: El.primary,
            children: const [
              ElButtonGroupItem(child: '选项一'),
              ElButtonGroupItem(child: '选项二'),
              ElButtonGroupItem(child: '选项三'),
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
    final selectedIndex = useState(-1);
    return Column(
      children: [
        ElFocusScope(
          child: ElButtonGroup.single(
            selectedIndex,
            type: El.primary,
            children: const [
              ElButtonGroupItem(child: '选项一'),
              ElButtonGroupItem(child: '选项二'),
              ElButtonGroupItem(child: '选项三'),
            ],
          ),
        ),
      ],
    );
  }
}''';
