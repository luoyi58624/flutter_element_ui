import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

class Example5 extends StatelessWidget {
  const Example5({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('图标按钮'),
        CodeExampleWidget(
          code: code,
          children: const [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(type: 'primary', child: ElIcon(ElIcons.edit)),
                ElButton(type: 'primary', child: ElIcon(ElIcons.share)),
                ElButton(type: 'primary', child: ElIcon(ElIcons.delete)),
                ElButton(
                  type: 'primary',
                  leftIcon: ElIcon(ElIcons.search),
                  child: '搜索',
                ),
                ElButton(
                  type: 'primary',
                  rightIcon: ElIcon(ElIcons.upload2),
                  child: '上传',
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
  children: [
    ElButton(type: 'primary', child: ElIcon(ElIcons.edit)),
    ElButton(type: 'primary', child: ElIcon(ElIcons.share)),
    ElButton(type: 'primary', child: ElIcon(ElIcons.delete)),
    ElButton(
      type: 'primary',
      leftIcon: ElIcon(ElIcons.search),
      child: '搜索',
    ),
    ElButton(
      type: 'primary',
      rightIcon: ElIcon(ElIcons.upload2),
      child: '上传',
    ),
  ],
),''';
