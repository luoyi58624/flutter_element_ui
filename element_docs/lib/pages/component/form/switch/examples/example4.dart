import 'package:element_docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Example4 extends StatelessWidget {
  const Example4({super.key, required this.title});

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
            _SwitchExample(),
          ],
        ),
      ],
    );
  }
}

class _SwitchExample extends HookWidget {
  const _SwitchExample();

  @override
  Widget build(BuildContext context) {
    final flag = useState(true);
    final disabled = useState(true);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ElSwitch(disabled),
        ElSwitch(flag, disabled: disabled.value),
      ],
    );
  }
}

String get code => '''
class _SwitchExample extends HookWidget {
  const _SwitchExample();

  @override
  Widget build(BuildContext context) {
    final flag = useState(true);
    final disabled = useState(true);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ElSwitch(disabled),
        ElSwitch(flag, disabled: disabled.value),
      ],
    );
  }
}''';
