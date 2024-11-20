import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class ButtonGroupTestPage extends HookWidget {
  const ButtonGroupTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('按钮组功能测试'),
      ),
      body: const _Example(),
    );
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final selected = useState(0);
    final selectedList = useState<List<int>>([]);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
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
            const ElButtonGroup(
              children: [
                ElButton(child: '选项一', disabled: true),
              ],
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                iconSize: 18,
              ),
              child: ElButtonGroup(
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
            const ElButtonTheme(
              data: ElButtonThemeData(
                iconSize: 18,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(
                    leftIcon: ElIcon(ElIcons.arrowLeft),
                    disabled: true,
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
                ElButton(child: '选项一', disabled: true),
                ElButton(child: '选项二'),
                ElButton(child: '选项三'),
              ],
            ),
            const Gap(8),
            const ElButtonGroup(
              children: [
                ElButton(child: '选项一'),
                ElButton(child: '选项二', disabled: true),
                ElButton(child: '选项三'),
              ],
            ),
            const Gap(8),
            const ElButtonGroup(
              children: [
                ElButton(child: '选项一', disabled: true),
                ElButton(child: '选项二', disabled: true),
                ElButton(child: '选项三'),
              ],
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                type: El.primary,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: '选项一', disabled: true),
                  ElButton(child: '选项二', disabled: true),
                  ElButton(child: '选项三'),
                ],
              ),
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                type: El.primary,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二', disabled: true),
                  ElButton(child: '选项三'),
                ],
              ),
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                type: El.success,
                round: true,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二'),
                  ElButton(child: '选项三'),
                ],
              ),
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                plain: true,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二'),
                  ElButton(child: '选项三'),
                  ElButton(child: '选项四'),
                ],
              ),
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                type: El.primary,
                plain: true,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二'),
                  ElButton(child: '选项三'),
                  ElButton(child: '选项四'),
                ],
              ),
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                type: El.success,
                plain: true,
                round: true,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二'),
                  ElButton(child: '选项三'),
                  ElButton(child: '选项四'),
                ],
              ),
            ),
            const Gap(8),
            const SizedBox(
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
            const SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ElButtonTheme(
                  data: ElButtonThemeData(
                    bgColor: Colors.purple,
                    round: true,
                  ),
                  child: ElButtonGroup(
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
            const ElButtonTheme(
              data: ElButtonThemeData(
                type: El.primary,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: ElIcon(ElIcons.edit)),
                  ElButton(child: ElIcon(ElIcons.share)),
                  ElButton(child: ElIcon(ElIcons.delete)),
                ],
              ),
            ),
            const Gap(8),
            const ElButtonTheme(
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
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                text: true,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二'),
                  ElButton(child: '选项三'),
                  ElButton(child: '选项四'),
                ],
              ),
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                text: true,
                round: true,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二'),
                  ElButton(child: '选项三'),
                  ElButton(child: '选项四'),
                ],
              ),
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                text: true,
                round: true,
                bg: true,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二'),
                  ElButton(child: '选项三'),
                  ElButton(child: '选项四'),
                ],
              ),
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                text: true,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: ElIcon(ElIcons.edit)),
                  ElButton(child: ElIcon(ElIcons.share)),
                  ElButton(child: ElIcon(ElIcons.delete)),
                ],
              ),
            ),
            const Gap(8),
            const ElButtonTheme(
              data: ElButtonThemeData(
                text: true,
                bg: true,
              ),
              child: ElButtonGroup(
                children: [
                  ElButton(child: ElIcon(ElIcons.edit)),
                  ElButton(child: ElIcon(ElIcons.share)),
                  ElButton(child: ElIcon(ElIcons.delete)),
                ],
              ),
            ),
            const Gap(8),
            ElButtonGroup.single(
              selected,
              children: const [
                ElButton(child: '选项一'),
                ElButton(child: '选项二', disabled: true),
                ElButton(child: '选项三', disabled: true),
                ElButton(child: '选项四'),
                ElButton(child: '选项五'),
              ],
            ),
            const Gap(8),
            ElButtonTheme(
              data: const ElButtonThemeData(type: El.primary),
              child: ElButtonGroup.single(
                selected,
                children: const [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二', disabled: true),
                  ElButton(child: '选项三', disabled: true),
                  ElButton(child: '选项四'),
                  ElButton(child: '选项五'),
                ],
              ),
            ),
            const Gap(8),
            ElButtonTheme(
              data: const ElButtonThemeData(
                type: El.primary,
                plain: true,
              ),
              child: ElButtonGroup.single(
                selected,
                children: const [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二', disabled: true),
                  ElButton(child: '选项三', disabled: true),
                  ElButton(child: '选项四'),
                  ElButton(child: '选项五'),
                ],
              ),
            ),
            const Gap(8),
            ElButtonTheme(
              data: const ElButtonThemeData(
                type: El.primary,
                round: true,
              ),
              child: ElButtonGroup.multi(
                selectedList,
                children: const [
                  ElButton(child: '选项一'),
                  ElButton(child: '选项二', disabled: true),
                  ElButton(child: '选项三', loading: true),
                  ElButton(child: '选项四'),
                  ElButton(child: '选项五'),
                  ElButton(child: '选项六'),
                  ElButton(child: '选项七', disabled: true),
                  ElButton(child: '选项八', disabled: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
