import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example1 extends HookWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('基本使用'),
        CodeExample(
          code: code,
          children: [
            ElSwitch(flag),
            const Gap(8),
            ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(8),
              child: AnimatedColoredBox(
                duration: 300.ms,
                curve: Curves.ease,
                color: flag.value ? Colors.lightBlue : Colors.lightGreen,
                child: AnimatedSize(
                  duration: 300.ms,
                  curve: Curves.ease,
                  child: SizedBox(
                    width: flag.value ? 150 : 50,
                    height: flag.value ? 150 : 50,
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

String get code => '''ElText('Hello，这是一段普通文本'),''';
