import 'dart:ui';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example11 extends StatelessWidget {
  const Example11({super.key, required this.title});

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
            Row(
              children: [
                _Example(),
                Gap(8),
                _Example2(),
                Gap(8),
                _Example3(),
              ],
            ),
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
    return const ElButtonGroup2(
      axis: Axis.vertical,
      children: [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: '选项二'),
        ElButtonGroupItem(child: '选项三'),
      ],
    );
  }
}

class _Example2 extends HookWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    return ElButtonGroup2.single(
      selectedIndex,
      type: El.success,
      axis: Axis.vertical,
      children: const [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: '选项二'),
        ElButtonGroupItem(child: '选项三'),
      ],
    );
  }
}

class _Example3 extends HookWidget {
  const _Example3();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<List<int>>([]);
    return ElButtonGroup2.multi(
      selectedIndex,
      type: El.info,
      axis: Axis.vertical,
      children: const [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: '选项二'),
        ElButtonGroupItem(child: '选项三'),
      ],
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return const ElButtonGroup2(
      axis: Axis.vertical,
      children: [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: '选项二'),
        ElButtonGroupItem(child: '选项三'),
      ],
    );
  }
}''';
