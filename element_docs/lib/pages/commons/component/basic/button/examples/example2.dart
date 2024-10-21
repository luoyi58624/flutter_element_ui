import 'package:element_docs/global.dart';
import 'package:flutter/widgets.dart';

import '../index.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        CodeExample(
          code: code1,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ButtonPage.buttonTypes
                  .map(
                    (type) => ElButton(
                      onPressed: null,
                      type: type,
                      disabled: true,
                      child: (type ?? 'Default').firstUpperCase,
                    ),
                  )
                  .toList(),
            ),
            const Gap(8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: ButtonPage.buttonTypes
                  .map(
                    (type) => ElButton(
                      onPressed: null,
                      type: type,
                      plain: true,
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

String get code1 => '''
ElButton(child: 'Hello', disabled: true),''';