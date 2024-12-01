import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example3 extends HookWidget {
  const Example3({super.key, required this.title});

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
            '按钮组不能存在轮廓环，因为按钮组和轮廓环都是基于 Stack 小部件实现，'
                '但 Stack 不支持类似 CSS 中的 z-index 功能，'
                '这会导致轮廓环被后面的按钮覆盖，或许可以通过重排序解决此问题，'
                '但是代价会造成按钮组极其频繁的 build',
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
    return Column(
      children: [
        const ElFocusScope(
          child: ElButtonGroup(
            children: [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
            ],
          ),
        ),
        const Gap(8),
        ElFocusScope(
          child: ElButtonTheme(
            data: const ElButtonThemeData(
              type: El.primary,
            ),
            child: ElButtonGroup(
              children: [
                const ElButton(child: '选项一'),
                ElButton(
                  onPressed: () {
                    loading.value = true;
                    setTimeout(() {
                      loading.value = false;
                    }, 1000);
                  },
                  child: '选项二',
                  loading: loading.value,
                ),
                const ElButton(child: '选项三'),
              ],
            ),
          ),
        ),
        const Gap(8),
        const ElFocusScope(
          child: ElButtonTheme(
            data: ElButtonThemeData(
              type: El.success,
              plain: true,
            ),
            child: ElButtonGroup(
              children: [
                ElButton(child: '选项一'),
                ElButton(child: '选项二'),
                ElButton(child: '选项三'),
              ],
            ),
          ),
        ),
        const Gap(8),
        const ElFocusScope(
          child: ElButtonTheme(
            data: ElButtonThemeData(
              type: El.success,
              text: true,
            ),
            child: ElButtonGroup(
              children: [
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
