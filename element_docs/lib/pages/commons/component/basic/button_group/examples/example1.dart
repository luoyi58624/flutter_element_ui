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
            '在按钮组模式下，height、type、plain、round、bgColor、text、bg 等属性只能通过 ElButtonTheme 指定',
          ],
        ),
        textGap,
        const SectionCard(
          type: 'warning',
          title: 'Warning',
          content: [
            '按钮组不支持 cricle、link 等属性，在构建过程中，这些属性会强制设置为 false',
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
    return const Column(
      children: [
        ElButtonGroup(
          null,
          children: [],
        ),
        Gap(8),
        ElButtonGroup(
          null,
          children: [
            ElButton(child: '选项一'),
          ],
        ),
        Gap(8),
        ElButtonTheme(
          data: ElButtonThemeData(
            iconSize: 18,
          ),
          child: ElButtonGroup(
            null,
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
        Gap(8),
        ElButtonGroup(
          null,
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
          ],
        ),
        Gap(8),
        ElButtonGroup(
          null,
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
            ElButton(child: '选项四'),
          ],
        ),
        Gap(8),
        ElButtonTheme(
          data: ElButtonThemeData(
            type: El.primary,
          ),
          child: ElButtonGroup(
            null,
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
            type: El.success,
            round: true,
          ),
          child: ElButtonGroup(
            null,
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
            plain: true,
          ),
          child: ElButtonGroup(
            null,
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        Gap(8),
        ElButtonTheme(
          data: ElButtonThemeData(
            type: El.success,
            plain: true,
            round: true,
          ),
          child: ElButtonGroup(
            null,
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        Gap(8),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ElButtonTheme(
              data: ElButtonThemeData(
                bgColor: Colors.purple,
                plain: true,
                round: true,
              ),
              child: ElButtonGroup(
                null,
                children: [
                  ElButton(child: '选项一', disabled: true),
                  ElButton(child: '选项二'),
                  ElButton(child: '选项三'),
                  ElButton(child: '选项四', disabled: true),
                  ElButton(child: '选项五'),
                ],
              ),
            ),
          ),
        ),
        Gap(8),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ElButtonTheme(
              data: ElButtonThemeData(
                bgColor: Colors.cyan,
                round: true,
              ),
              child: ElButtonGroup(
                null,
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
        Gap(8),
        ElButtonGroup(
          null,
          children: [
            ElButton(child: ElIcon(ElIcons.edit)),
            ElButton(child: ElIcon(ElIcons.share)),
            ElButton(child: ElIcon(ElIcons.delete)),
          ],
        ),
        Gap(8),
        ElButtonTheme(
          data: ElButtonThemeData(
            type: El.primary,
          ),
          child: ElButtonGroup(
            null,
            children: [
              ElButton(child: ElIcon(ElIcons.edit)),
              ElButton(child: ElIcon(ElIcons.share)),
              ElButton(child: ElIcon(ElIcons.delete)),
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
            null,
            children: [
              ElButton(child: '选项一', flex: 2),
              ElButton(child: '选项二', block: false),
              ElButton(child: '选项三'),
            ],
          ),
        ),
        Gap(8),
        ElButtonTheme(
          data: ElButtonThemeData(
            text: true,
          ),
          child: ElButtonGroup(
            null,
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        Gap(8),
        ElButtonTheme(
          data: ElButtonThemeData(
            text: true,
            round: true,
          ),
          child: ElButtonGroup(
            null,
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        Gap(8),
        ElButtonTheme(
          data: ElButtonThemeData(
            text: true,
            round: true,
            bg: true,
          ),
          child: ElButtonGroup(
            null,
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
        Gap(8),
        ElButtonTheme(
          data: ElButtonThemeData(
            text: true,
          ),
          child: ElButtonGroup(
            null,
            children: [
              ElButton(child: ElIcon(ElIcons.house)),
              ElButton(child: ElIcon(ElIcons.edit)),
              ElButton(child: ElIcon(ElIcons.delete)),
              ElButton(child: ElIcon(ElIcons.upload2)),
            ],
          ),
        ),
        Gap(8),
        ElButtonTheme(
          data: ElButtonThemeData(
            text: true,
            bg: true,
          ),
          child: ElButtonGroup(
            null,
            children: [
              ElButton(child: ElIcon(ElIcons.house)),
              ElButton(child: ElIcon(ElIcons.edit)),
              ElButton(child: ElIcon(ElIcons.delete)),
              ElButton(child: ElIcon(ElIcons.upload2)),
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
          null,
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
            null,
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
            ],
          ),
        ),
        Gap(8),
        // 设置 block 属性可以让按钮填充剩余空间，内部会给按钮包裹 Expanded 小部件，
        // 你还可以设置按钮的 flex 属性控制它的空间比例
        ElButtonTheme(
          data: ElButtonThemeData(
            type: El.primary,
            block: true,
            round: true,
          ),
          child: ElButtonGroup(
            null,
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
