import 'package:element_docs/global.dart';
import 'package:flutter/widgets.dart';
import 'example6.dart';

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
            'Element UI 所有组件都没有提供 size 选项，你可以通过设置 width、height、padding、block 等属性自由地封装各种尺寸按钮。'
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
                    setTimeout(() {
                      loading.value = false;
                    }, 1000);
                  },
                  height: 20,
                  type: 'success',
                  loading: loading.value,
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
                ElHover(builder: (context) {
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
      leftIcon: ElIcon(ElIcons.delete),
      child: ElText('删除', style: TextStyle(fontSize: 12)),
    ),
    const ElButton(
      height: 48,
      block: true,
      type: 'primary',
      child: ElText('块级按钮', style: TextStyle(fontSize: 20)),
    ),
    ElHover(builder: (context) {
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
