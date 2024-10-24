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
          children: [],
        ),
        const Gap(8),
        const ElButtonGroup(
          children: [
            ElButton(child: '选项一'),
          ],
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            iconSize: 18,
          ),
          child: const ElButtonGroup(
            children: [
              ElButton(
                leftIcon: ElIcon(ElIcons.arrowLeft),
                child: ElText(
                  '上一页',
                ),
              ),
              ElButton(
                rightIcon: ElIcon(ElIcons.arrowRight),
                child: ElText(
                  '下一页',
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        const ElButtonGroup(
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
          ],
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
            plain: true,
          ),
          child: const ElButtonGroup(
            children: [
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
            plain: true,
          ),
          child: const ElButtonGroup(
            children: [
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
            plain: true,
            round: true,
          ),
          child: const ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        const Gap(8),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ElButtonTheme.merge(
              data: const ElButtonThemeData(
                bgColor: Colors.purple,
                plain: true,
                round: true,
              ),
              child: const ElButtonGroup(
                children: [
                  ElButton(child: '选项一', disabled: true),
                  ElButton(child: '选项二'),
                  ElButton(child: '选项三', disabled: true),
                  ElButton(child: '选项四', disabled: true),
                  ElButton(child: '选项五'),
                ],
              ),
            ),
          ),
        ),
        const Gap(8),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ElButtonTheme.merge(
              data: const ElButtonThemeData(
                bgColor: Colors.cyan,
                round: true,
              ),
              child: const ElButtonGroup(
                children: [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二'),
                  ElButton(child: '选项三'),
                  ElButton(child: '选项四', disabled: true),
                  ElButton(child: '选项五', loading: true),
                ],
              ),
            ),
          ),
        ),
        const Gap(8),
        const ElButtonGroup(
          children: [
            ElButton(child: ElIcon(ElIcons.edit)),
            ElButton(child: ElIcon(ElIcons.share)),
            ElButton(child: ElIcon(ElIcons.delete)),
          ],
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
              ElButton(child: '选项一', flex: 2),
              ElButton(child: '选项二', block: false),
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
              ElButton(child: '选项四'),
            ],
          ),
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            text: true,
            round: true,
          ),
          child: const ElButtonGroup(
            children: [
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
            round: true,
            bg: true,
          ),
          child: const ElButtonGroup(
            children: [
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
            text: true,
            bg: true,
          ),
          child: const ElButtonGroup(
            children: [
              ElButton(child: ElIcon(ElIcons.edit)),
              ElButton(child: ElIcon(ElIcons.share)),
              ElButton(child: ElIcon(ElIcons.delete)),
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
        ElButtonGroup(
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
          ],
        ),
        Gap(8),
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
        ElButtonTheme(
          data: ElButtonThemeData(
            type: El.primary,
            block: true,
            round: true,
          ),
          child: ElButtonGroup(
            children: [
              ElButton(child: '选项一', flex: 2),
              ElButton(child: '选项二', block: false),
              ElButton(child: '选项三'),
            ],
          ),
        ),
      ],
    );
  }
}''';
