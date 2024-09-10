import 'package:docs/global.dart';
import 'package:flutter/material.dart';

class Example1 extends HookWidget {
  const Example1({super.key});

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
        borderRadius: context.elTheme.cardStyle.radius,
      ),
      child: const ElText(
        'ElCollapseTransition',
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('折叠动画'),
        CodeExampleWidget(
          code: code1,
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
        ),
      ],
    );
  }
}

String get code1 => '''
final show = useState(true);

final container = Container(
  width: 200,
  height: 100,
  margin: const EdgeInsets.only(top: 8),
  alignment: Alignment.center,
  decoration: BoxDecoration(
    color: context.elTheme.primary,
    borderRadius: context.elTheme.cardStyle.radius,
  ),
  child: const ElText(
   'ElCollapseTransition',
    style: TextStyle(color: Colors.white, fontSize: 14),
  ),
);

Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    ElButton(
      onPressed: () {
        show.value = !show.value;
      },
      child: 'Click Me',
    ),
    ElCollapseTransition(
      show.value,
      child: Column(
        children: [container, container],
      ),
    ),
  ],
),''';
