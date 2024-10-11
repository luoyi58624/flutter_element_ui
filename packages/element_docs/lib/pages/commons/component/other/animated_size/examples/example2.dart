import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example2 extends HookWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    final username = useState('');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('文本内容动画尺寸填充'),
        CodeExample(
          code: code,
          children: [
            ElInput(username),
            const Gap(8),
            ColoredBox(
              color: Colors.green,
              child: AnimatedSize(
                duration: 300.ms,
                curve: Curves.ease,
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElText(username.value),
                  ),
                ),
              ),
            ),
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
