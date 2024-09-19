import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

import '../index.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title),
        ElLink(
          href: '/component/button#分割按钮',
          child: Builder(builder: (context) {
            return ElButton(
              onPressed: () {
                ElLink.to(context);
              },
              child: '跳转',
            );
          }),
        ),
        const Gap(8),
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
                      type: type,
                      plain: true,
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
                      type: type,
                      round: true,
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
                      type: type,
                      child: const ElIcon(ElIcons.aim),
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
                      type: type,
                      circle: true,
                      child: const ElIcon(ElIcons.aim),
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
ElButton(child: 'Hello'),
ElButton(child: 'Hello', type: 'primary'),
ElButton(child: 'Hello', type: 'primary', plain: true),
ElButton(child: 'Hello', type: 'primary', round: true),
ElButton(child: ElIcon(ElIcons.aim)),
ElButton(child: ElIcon(ElIcons.aim), circle: true)''';
