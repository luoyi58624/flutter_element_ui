import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('富文本'),
        CodeExampleWidget(
          code: code,
          children: const [
            ElText([
              'hello, ',
              ElText(
                '这是一段富文本, ',
                style: TextStyle(color: Colors.green),
              ),
              ElLink(
                href: 'https://github.com/luoyi58624/flutter_element_ui',
                decoration: ElLinkDecoration.hoverUnderline,
                child: 'github链接',
              ),
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
  ElButton(child: 'Hello', type: 'primary'),
]),''';
