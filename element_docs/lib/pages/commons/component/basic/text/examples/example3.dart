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
          '通过继承 ElText 小部件，你可以轻松地让它们和富文本一起工作，不过这些组件 element_plus 包没有提供，你需要自行封装，',
          ElLink(
            href:
                'https://github.com/luoyi58624/flutter_element_ui/tree/main/packages/element_extension/lib/src/widgets/html/typography.dart',
            decoration: ElLinkDecoration.hoverUnderline,
            child: '查看示例',
          ),
        ]),
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

class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H1('一级标题 (H1)'),
          H2('二级标题 (H2)'),
          H3('三级标题 (H3)'),
          H4('四级标题 (H4)'),
          H5('五级标题 (H5)'),
          H6('六级标题 (H6)'),
          const ElText('普通文本 (ElText)'),
          const Gap(16),
          const ElText('===================================='),
          const ElText('=============  富文本  =============='),
          const ElText('===================================='),
          const Gap(16),
          ElText([
            const P('普通文本'),
            B('加粗文本'),
            I('斜体文本'),
            Del('删除线文本'),
            H1('一级标题', style: const TextStyle(color: Colors.red)),
            H2('二级标题', style: const TextStyle(color: Colors.orange)),
            H3('三级标题', style: const TextStyle(color: Colors.green)),
            H4('四级标题', style: const TextStyle(color: Colors.cyan)),
            H5('五级标题', style: const TextStyle(color: Colors.purple)),
            H6('六级标题', style: const TextStyle(color: Colors.grey)),
          ]),
        ],
      ),
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          H1('一级标题 (H1)'),
          H2('二级标题 (H2)'),
          H3('三级标题 (H3)'),
          H4('四级标题 (H4)'),
          H5('五级标题 (H5)'),
          H6('六级标题 (H6)'),
          const ElText('普通文本 (ElText)'),
          const Gap(16),
          const ElText('===================================='),
          const ElText('=============  富文本  =============='),
          const ElText('===================================='),
          const Gap(16),
          ElText([
            const P('普通文本'),
            B('加粗文本'),
            I('斜体文本'),
            Del('删除线文本'),
            H1('一级标题', style: const TextStyle(color: Colors.red)),
            H2('二级标题', style: const TextStyle(color: Colors.orange)),
            H3('三级标题', style: const TextStyle(color: Colors.green)),
            H4('四级标题', style: const TextStyle(color: Colors.cyan)),
            H5('五级标题', style: const TextStyle(color: Colors.purple)),
            H6('六级标题', style: const TextStyle(color: Colors.grey)),
          ]),
        ],
      ),
    );
  }
}
''';
