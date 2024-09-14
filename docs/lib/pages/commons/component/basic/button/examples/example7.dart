import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

class Example7 extends StatelessWidget {
  const Example7({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('块级按钮'),
        CodeExampleWidget(
          code: code,
          children: const [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElButton(child: 'Default', block: true),
                ElButton(child: 'Default', block: true, type: 'primary'),
                ElButton(
                    child: 'Default',
                    block: true,
                    type: 'primary',
                    round: true),
                ElButton(
                    child: 'Default',
                    block: true,
                    type: 'primary',
                    plain: true),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

String get code => '''
Wrap(
  spacing: 8,
  runSpacing: 8,
  children: [
    ElButton(child: 'Default', block: true),
    ElButton(child: 'Default', block: true, type: 'primary'),
    ElButton(child: 'Default', block: true, type: 'primary', round: true),
    ElButton(child: 'Default', block: true, type: 'primary', plain: true),
  ],
),''';
