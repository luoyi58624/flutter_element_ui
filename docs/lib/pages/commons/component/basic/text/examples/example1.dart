import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('普通文本'),
        CodeExample(
          code: code,
          children: const [
            ElText('Hello, 这是一段普通文本'),
          ],
        ),
      ],
    );
  }
}

String get code => '''ElText('Hello，这是一段普通文本'),''';
