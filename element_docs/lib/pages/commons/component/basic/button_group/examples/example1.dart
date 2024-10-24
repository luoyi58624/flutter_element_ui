import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example1 extends HookWidget {
  const Example1({super.key, required this.title});

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
            '在按钮组模式下，height、type、plain、round、bgColor、text、bg 等属性只能通过 ElButtonTheme 统一指定',
          ],
        ),
        textGap,
        CodeExample(
          code: code,
          children: const [_Example()],
        ),
      ],
    );
  }
}

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const ElButtonGroup(
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
          ],
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: ElButtonThemeData(
            plain: true,
            borderBuilder: (state) => Border.all(
              width: state.isHover || state.isTap ? 1.5 : 1.0,
              color: Colors.red,
            ),
          ),
          child: const ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            type: El.primary,
          ),
          child: const ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            type: El.success,
            plain: true,
            round: true,
          ),
          child: const ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            text: true,
          ),
          child: const ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            text: true,
            round: true,
            bg: true,
          ),
          child: const ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            type: El.primary,
          ),
          child: const ElButtonGroup(
            children: [
              ElButton(child: ElIcon(ElIcons.edit)),
              ElButton(child: ElIcon(ElIcons.share)),
              ElButton(child: ElIcon(ElIcons.delete)),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            type: El.primary,
            block: true,
            round: true,
          ),
          child: const ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二', block: false),
              ElButton(child: '选项三', flex: 2),
            ],
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
    return const Column(
      children: [
        // 基础使用
        ElButtonGroup(
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
          ],
        ),
        Gap(8),
        // 使用 ElButtonTheme 设置主题
        ElButtonTheme(
          data: ElButtonThemeData(
            type: El.primary,
          ),
          child: ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
            ],
          ),
        ),
        Gap(8),
        // 使用 block 属性实现 flex 弹性布局
        ElButtonTheme(
          data: ElButtonThemeData(
            type: El.primary,
            block: true,
            round: true,
          ),
          child: ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二', block: false),
              ElButton(child: '选项三', flex: 2),
            ],
          ),
        ),
      ],
    );
  }
}''';
