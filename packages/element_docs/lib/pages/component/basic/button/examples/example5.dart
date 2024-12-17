import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class Example5 extends StatelessWidget {
  const Example5({super.key, required this.title});

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

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElTextButton(child: ElIcon(ElIcons.sHome)),
        ElTextButton(type: El.primary, child: ElIcon(ElIcons.edit)),
        ElTextButton(type: El.success, child: ElIcon(ElIcons.share)),
        ElTextButton(type: El.warning, child: ElIcon(ElIcons.warning)),
        ElTextButton(type: El.error, child: ElIcon(ElIcons.delete)),
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
        ElTextButton(disabled: true, child: ElIcon(ElIcons.sHome)),
        ElTextButton(
            type: El.primary, disabled: true, child: ElIcon(ElIcons.edit)),
        ElTextButton(
            type: El.success, disabled: true, child: ElIcon(ElIcons.share)),
        ElTextButton(
            type: El.warning, disabled: true, child: ElIcon(ElIcons.warning)),
        ElTextButton(
            type: El.error, disabled: true, child: ElIcon(ElIcons.delete)),
      ],
    );
  }
}

class _Example3 extends StatelessWidget {
  const _Example3();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElTextButton(bg: true, child: ElIcon(ElIcons.sHome)),
        ElTextButton(type: El.primary, bg: true, child: ElIcon(ElIcons.edit)),
        ElTextButton(type: El.success, bg: true, child: ElIcon(ElIcons.share)),
        ElTextButton(
            type: El.warning, bg: true, child: ElIcon(ElIcons.warning)),
        ElTextButton(type: El.error, bg: true, child: ElIcon(ElIcons.delete)),
      ],
    );
  }
}

class _Example4 extends StatelessWidget {
  const _Example4();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        ElTextButton(bg: true, disabled: true, child: ElIcon(ElIcons.sHome)),
        ElTextButton(
            type: El.primary,
            bg: true,
            disabled: true,
            child: ElIcon(ElIcons.edit)),
        ElTextButton(
            type: El.success,
            bg: true,
            disabled: true,
            child: ElIcon(ElIcons.share)),
        ElTextButton(
            type: El.warning,
            bg: true,
            disabled: true,
            child: ElIcon(ElIcons.warning)),
        ElTextButton(
            type: El.error,
            bg: true,
            disabled: true,
            child: ElIcon(ElIcons.delete)),
      ],
    );
  }
}

String get code => '''
// 透明背景色的图标按钮会对图标进行 1.2 倍放大，你可以设置 iconScale 调整这一行为
ElTextButton(child: ElIcon(ElIcons.sHome)),
ElTextButton(disabled: true, child: ElIcon(ElIcons.sHome)),
ElTextButton(bg: true, child: ElIcon(ElIcons.sHome)),
ElTextButton(bg: true, disabled: true, child: ElIcon(ElIcons.sHome)),''';
