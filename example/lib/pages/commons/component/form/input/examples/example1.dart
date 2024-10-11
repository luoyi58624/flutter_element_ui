import 'package:example/global.dart';
import 'package:flutter/material.dart';

class Example1 extends HookWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FlutterHookTip('ElInput'),
        SectionTitle(title),
        CodeExample(
          code: code,
          children: [
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: _InputExample(),
            ).noScrollBehavior,
          ],
        ),
      ],
    );
  }
}

class _InputExample extends HookWidget {
  const _InputExample();

  @override
  Widget build(BuildContext context) {
    final input = useState('');
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: ElInput(
            input,
            placeholder: '请输入内容',
          ),
        ),
        const Gap(8),
        ElText(' - ${input.value}'),
      ],
    );
  }
}

String get code => '''
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class _InputExample extends HookWidget {
  const _InputExample();

  @override
  Widget build(BuildContext context) {
    final input = useState('');
    return Row(
      children: [
        SizedBox(
          width: 200,
          child: ElInput(
            input,
            margin: EdgeInsets.zero,
            placeholder: '请输入内容',
          ),
        ),
        const Gap(8),
        ElText(' - \${input.value}'),
      ],
    );
  }
}''';
