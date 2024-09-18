import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

import '../index.dart';

class Example4 extends StatelessWidget {
  const Example4({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExampleWidget(
          code: code,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ButtonPage.buttonTypes
                  .map(
                    (type) => ElButton(
                      type: type,
                      text: true,
                      child: (type ?? 'Default').firstUpperCase,
                    ),
                  )
                  .toList(),
            ),
            const Gap(12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ButtonPage.buttonTypes
                  .map(
                    (type) => ElButton(
                      type: type,
                      text: true,
                      bg: true,
                      child: (type ?? 'Default').firstUpperCase,
                    ),
                  )
                  .toList(),
            ),
            const Gap(12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ButtonPage.buttonTypes
                  .map(
                    (type) => ElButton(
                      type: type,
                      text: true,
                      disabled: true,
                      child: (type ?? 'Default').firstUpperCase,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}

String get code => '''
ElButton(child: 'Hello', text: true),
ElButton(child: 'Hello', text: true, bg: true),''';
