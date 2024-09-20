import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code,
          expanded: true,
          children: const [
            ElText([
              'hello, ',
              ElText(
                '这是一段富文本, ',
                style: TextStyle(color: Colors.green),
              ),
              ElLink(
                href: 'https://github.com/luoyi58624/flutter_element_ui',
                target: LinkTarget.blank,
                decoration: ElLinkDecoration.hoverUnderline,
                child: 'github链接',
              ),
              ' ',
              ElButton(child: '链接按钮', type: 'success', link: true),
              ' ',
              ElButton(child: 'Hello', type: 'primary'),
            ]),
          ],
        ),
      ],
    );
  }
}

String get code => '''
ElText([
  'hello, ',
  ElText(
    '这是一段富文本',
    style: TextStyle(color: Colors.green),
  ),
  ElLink(
    href: 'https://github.com/luoyi58624/flutter_element_ui',
    decoration: ElLinkDecoration.hoverUnderline,
    child: 'github链接',
  ),
  ElButton(child: '链接按钮', type: 'success', link: true),
  ElButton(child: 'Hello', type: 'primary'),
]),''';
