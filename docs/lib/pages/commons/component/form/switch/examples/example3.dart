import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Example3 extends StatelessWidget {
  const Example3({super.key, required this.title});

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
    final flag = useState(false);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ElSwitch(
          flag,
          bgColor: Colors.red,
          activeBgColor: Colors.green,
        ),
        ElSwitch(
          flag,
          bgColor: Colors.purple.shade200,
          activeBgColor: Colors.teal.shade200,
          color: Colors.purple,
          activeColor: Colors.teal,
        ),
      ],
    );
  }
}

String get code => '''
class _SwitchExample extends HookWidget {
  const _SwitchExample();

  @override
  Widget build(BuildContext context) {
    final flag = useState(false);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ElSwitch(
          flag,
          bgColor: Colors.red,
          activeBgColor: Colors.green,
        ),
        ElSwitch(
          flag,
          bgColor: Colors.purple.shade200,
          activeBgColor: Colors.teal.shade200,
          color: Colors.purple,
          activeColor: Colors.teal,
        ),
      ],
    );
  }
}''';
