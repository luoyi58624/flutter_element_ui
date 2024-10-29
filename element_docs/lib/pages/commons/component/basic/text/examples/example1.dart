import 'package:element_docs/global.dart';
import 'package:flutter/widgets.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key, required this.title});

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
          children: [
            ElText(
              'Hello, 这是一段普通文本',
              style: TextStyle(
                color: context.elTheme.textTheme.regularStyle.color,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String get code => '''ElText('Hello，这是一段普通文本'),''';
