import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        const FlutterHookTip('ElSlider'),
        textGap,
        CodeExample(
          code: code,
          children: const [
            _SliderExample(),
          ],
        ),
      ],
    );
  }
}

class _SliderExample extends HookWidget {
  const _SliderExample();

  @override
  Widget build(BuildContext context) {
    final progress = useState(0.0);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        ElSlider(progress),
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
        ElSwitch(flag),
        Switch(value: flag.value, onChanged: (v) => flag.value = v),
        CupertinoSwitch(value: flag.value, onChanged: (v) => flag.value = v),
        ElSwitch(flag.value, onChanged: (v) => flag.value = v),
      ],
    );
  }
}''';
