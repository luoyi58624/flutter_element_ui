import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class Example1 extends HookWidget {
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
          children: const [
            _Example(),
          ],
        ),
      ],
    );
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ElSwitch(flag),
            const Gap(8),
            ElText('rootOverlay: ${flag.value}'),
          ],
        ),
        const Gap(8),
        ElDrag(
          rootOverlay: flag.value,
          feedback: Container(
            width: 100,
            height: 100,
            color: Colors.green,
          ),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

String get code => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ElSwitch(flag),
            const Gap(8),
            ElText('rootOverlay: \${flag.value}'),
          ],
        ),
        const Gap(8),
        ElDrag(
          rootOverlay: flag.value,
          feedback: Container(
            width: 100,
            height: 100,
            color: Colors.green,
          ),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}''';
