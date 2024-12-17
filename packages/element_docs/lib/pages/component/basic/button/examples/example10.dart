import 'dart:ui';

import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example10 extends StatelessWidget {
  const Example10({super.key, required this.title});

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
            Gap(8),
            _Example3(),
            Gap(8),
            _Example4(),
          ],
        ),
      ],
    );
  }
}

/// 普通按钮组示例
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return const ElButtonGroup(children: [
      ElButtonGroupItem(child: '选项一'),
      ElButtonGroupItem(child: '选项二'),
      ElButtonGroupItem(child: '选项三'),
    ]);
  }
}

/// 单选按钮组示例
class _Example2 extends HookWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    return ElButtonGroup.single(
      selectedIndex,
      type: El.success,
      children: const [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: '选项二'),
        ElButtonGroupItem(child: '选项三'),
      ],
    );
  }
}

/// 多选按钮组示例
class _Example3 extends HookWidget {
  const _Example3();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<List<int>>([]);
    return ElButtonGroup.multi(
      selectedIndex,
      type: El.info,
      children: const [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: '选项二'),
        ElButtonGroupItem(child: '选项三'),
      ],
    );
  }
}

/// 自定义颜色
class _Example4 extends HookWidget {
  const _Example4();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<List<int>>([]);
    return ElButtonGroup.multi(
      selectedIndex,
      bgColor: Colors.purple,
      children: const [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: '选项二'),
        ElButtonGroupItem(child: '选项三'),
      ],
    );
  }
}

String get code => '''
/// 普通按钮组示例
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return const ElButtonGroup(children: [
      ElButtonGroupItem(child: '选项一'),
      ElButtonGroupItem(child: '选项二'),
      ElButtonGroupItem(child: '选项三'),
    ]);
  }
}

/// 单选按钮组示例
class _Example2 extends HookWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(0);
    return ElButtonGroup.single(
      selectedIndex,
      type: El.success,
      children: const [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: '选项二'),
        ElButtonGroupItem(child: '选项三'),
      ],
    );
  }
}

/// 多选按钮组示例
class _Example3 extends HookWidget {
  const _Example3();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<List<int>>([]);
    return ElButtonGroup.multi(
      selectedIndex,
      type: El.info,
      children: const [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: '选项二'),
        ElButtonGroupItem(child: '选项三'),
      ],
    );
  }
}

/// 自定义颜色
class _Example4 extends HookWidget {
  const _Example4();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState<List<int>>([]);
    return ElButtonGroup.multi(
      selectedIndex,
      bgColor: Colors.purple,
      children: const [
        ElButtonGroupItem(child: '选项一'),
        ElButtonGroupItem(child: '选项二'),
        ElButtonGroupItem(child: '选项三'),
      ],
    );
  }
}''';
