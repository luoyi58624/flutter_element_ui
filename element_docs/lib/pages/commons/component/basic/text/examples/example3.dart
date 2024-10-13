import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example3 extends StatelessWidget {
  const Example3({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const SectionText([
          '这些组件 Element UI 没有提供，你需要自行封装，',
          ElLink(
            href:
                'https://gitee.com/luoyi666/flutter_base/blob/main/lib/src/widgets/html/typography.dart',
            decoration: ElLinkDecoration.hoverUnderline,
            child: '查看示例',
          ),
        ]),
        textGap,
        CodeExample(
          code: code,
          children: const [
            H1('一级标题 (H1)'),
            H2('二级标题 (H2)'),
            H3('三级标题 (H3)'),
            H4('四级标题 (H4)'),
            H5('五级标题 (H5)'),
            H6('六级标题 (H6)'),
            ElText('普通文本 (ElText)'),
            Gap(16),
            ElText('===================================='),
            ElText('=============  富文本  =============='),
            ElText('===================================='),
            Gap(16),
            ElText([
              H1('一级标题', style: TextStyle(color: Colors.red)),
              H2('二级标题', style: TextStyle(color: Colors.orange)),
              H3('三级标题', style: TextStyle(color: Colors.green)),
              H4('四级标题', style: TextStyle(color: Colors.cyan)),
              H5('五级标题', style: TextStyle(color: Colors.purple)),
              H6('六级标题', style: TextStyle(color: Colors.grey)),
            ]),
          ],
        ),
      ],
    );
  }
}

String get code => '''
H1('一级标题 (H1)'),
H2('二级标题 (H2)'),
H3('三级标题 (H3)'),
H4('四级标题 (H4)'),
H5('五级标题 (H5)'),
H6('六级标题 (H6)'),
ElText('普通文本 (ElText)'),
Gap(16),
ElText('===================================='),
ElText('=============  富文本  =============='),
ElText('===================================='),
Gap(16),
ElText([
  H1('一级标题', style: TextStyle(color: Colors.red)),
  H2('二级标题', style: TextStyle(color: Colors.orange)),
  H3('三级标题', style: TextStyle(color: Colors.green)),
  H4('四级标题', style: TextStyle(color: Colors.cyan)),
  H5('五级标题', style: TextStyle(color: Colors.purple)),
  H6('六级标题', style: TextStyle(color: Colors.grey)),
]),''';
