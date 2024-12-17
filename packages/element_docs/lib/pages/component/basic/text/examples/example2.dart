import 'package:element_docs/global.dart';
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
    return const SelectionArea(
      child: ElEventTheme(
        data: ElEventThemeData(
          canRequestFocus: false,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                cursor: SystemMouseCursors.click,
                child: 'github链接',
              ),
              ' ',
              ElLinkButton(child: '链接按钮', type: 'success'),
              ' ',
              SelectionContainer.disabled(
                child: ElButton(
                  child: 'Hello',
                  type: El.primary,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

String get code => '''
class _Example extends StatelessWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    return const SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              cursor: SystemMouseCursors.click,
              child: 'github链接',
            ),
            ' ',
            ElLinkButton(child: '链接按钮', type: 'success'),
            ' ',
            SelectionContainer.disabled(
              child: ElButton(
                child: 'Hello',
                type: El.primary,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}''';
