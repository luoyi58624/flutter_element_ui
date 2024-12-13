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
          code: code1,
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
    final show = useState(true);
    final container = Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.only(top: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.elTheme.primary,
        borderRadius: context.commonSizePreset.cardRadius!,
      ),
      child: const ElText(
        'ElCollapseTransition',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButton(
          onPressed: () {
            show.value = !show.value;
          },
          type: 'primary',
          child: 'Click Me',
        ),
        ElCollapseTransition(
          show.value,
          child: Column(
            children: [container, container],
          ),
        ),
      ],
    );
  }
}

String get code1 => '''
class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final show = useState(true);
    final container = Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.only(top: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.elTheme.primary,
        borderRadius: context.commonSizePreset.cardRadius!,
      ),
      child: const ElText(
        'ElCollapseTransition',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElButton(
          onPressed: () {
            show.value = !show.value;
          },
          type: 'primary',
          child: 'Click Me',
        ),
        ElCollapseTransition(
          show.value,
          child: Column(
            children: [container, container],
          ),
        ),
      ],
    );
  }
}''';
