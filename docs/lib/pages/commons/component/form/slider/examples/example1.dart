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
            _Example(),
            Gap(16),
            _Example2(),
            Gap(16),
            _Example3(),
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
    final progress = useState(0.0);
    return Column(
      children: [
        ElText(progress.value.toString()),
        ElSlider(progress),
      ],
    );
  }
}

class _Example2 extends HookWidget {
  const _Example2();

  @override
  Widget build(BuildContext context) {
    final progress = useState(0.0);
    return Column(
      children: [
        ElText(progress.value.toString()),
        Slider(
          value: progress.value,
          max: 100,
          thumbColor: Colors.red,
          onChanged: (v) => progress.value = v,
        ),
      ],
    );
  }
}

class _Example3 extends HookWidget {
  const _Example3();

  @override
  Widget build(BuildContext context) {
    final progress = useState(0.0);
    return Column(
      children: [
        ElText(progress.value.toString()),
        CupertinoSlider(
          value: progress.value,
          max: 100,
          onChanged: (v) => progress.value = v,
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
    final progress = useState(0.0);
    return Column(
      children: [
        ElText(progress.value.toString()),
        ElSlider(progress),
      ],
    );
  }
}''';
