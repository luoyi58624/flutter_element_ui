import 'package:example/global.dart';
import 'package:flutter/widgets.dart';

class Example8 extends StatelessWidget {
  const Example8({super.key, required this.title});
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
