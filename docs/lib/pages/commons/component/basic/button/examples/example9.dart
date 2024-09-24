import 'package:docs/global.dart';
import 'package:docs/pages/commons/component/basic/button/examples/example6.dart';
import 'package:flutter/widgets.dart';

class Example9 extends HookWidget {
  const Example9({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final loading = useState(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionCard(
          title: 'Tip',
          content: [
            'Element UI 没有提供 size 选项，你可以通过设置 width、height、padding、block 等属性自由地创建各种尺寸按钮，'
          ],
        ),
        textGap,
        CodeExample(
          code: code,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                const ElButton(
                  height: 20,
                  type: 'primary',
                  child: ElText('小型按钮', style: TextStyle(fontSize: 12)),
                ),
                ElButton(
                  onPressed: () {
                    loading.value = true;
                    () {
                      loading.value = false;
                    }.delay(1000);
                  },
                  height: 20,
                  type: 'success',
                  loading: loading.value,
                  iconSize: 10,
                  leftIcon: const ElIcon(ElIcons.delete),
                  loadingBuilder: loadingBuilder,
                  child: const ElText('删除', style: TextStyle(fontSize: 12)),
                ),
                const ElButton(
                  height: 48,
                  block: true,
                  type: 'primary',
                  child: ElText('块级按钮', style: TextStyle(fontSize: 20)),
                ),
                HoverBuilder(builder: (context) {
                  return ElButton(
                    width: 80,
                    height: 80,
                    padding: EdgeInsets.zero,
                    borderRadius:
                        BorderRadius.circular(context.isHover ? 40 : 16),
                    type: 'primary',
                    child: const ElText(
                      '按钮',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }),
                ElButton(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 26),
                  borderRadius: BorderRadius.circular(16),
                  type: 'primary',
                  child: const ElText('按钮', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

String get code => '''
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: [
    ElButton(
      height: 20,
      type: 'primary',
      child: ElText('小型按钮', style: TextStyle(fontSize: 12)),
    ),
    const ElButton(
      height: 20,
      type: 'success',
      iconSize: 10,
      leftIcon: ElIcon(ElIcons.delete),
      child: ElText('删除', style: TextStyle(fontSize: 12)),
    ),
    const ElButton(
      height: 48,
      block: true,
      type: 'primary',
      child: ElText('块级按钮', style: TextStyle(fontSize: 20)),
    ),
    HoverBuilder(builder: (context) {
      return ElButton(
        width: 80,
        height: 80,
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.circular(context.isHover ? 40 : 16),
        type: 'primary',
        child: const ElText(
          '按钮',
          style: TextStyle(fontSize: 20),
        ),
      );
    }),
    ElButton(
      padding: EdgeInsets.symmetric(horizontal: 80, vertical: 26),
      borderRadius: BorderRadius.circular(16),
      type: 'primary',
      child: ElText('按钮', style: TextStyle(fontSize: 20)),
    ),
  ],
),''';
