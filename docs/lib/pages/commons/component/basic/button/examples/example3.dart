import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

import '../index.dart';

class Example3 extends StatelessWidget {
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
          content: ['链接按钮的外观与普通文字完全一样，你可以搭配 ElLink 一起使用'],
        ),
        textGap,
        CodeExample(
          code: code,
          children: [
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: ButtonPage.buttonTypes
                  .map(
                    (type) => ElLink(
                      href: githubLink,
                      child: ElButton(
                        type: type,
                        link: true,
                        child: (type ?? 'Default').firstUpperCase,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const Gap(12),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: ButtonPage.buttonTypes
                  .map(
                    (type) => ElButton(
                      type: type,
                      link: true,
                      disabled: true,
                      child: (type ?? 'Default').firstUpperCase,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}

String get code => '''
ElButton(child: 'Hello', link: true),

const ElLink(
  href: 'https://github.com/luoyi58624/flutter_element_ui',
  child: ElButton(link: true, child: 'Hello'),
),''';
