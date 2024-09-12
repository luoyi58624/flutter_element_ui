import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

import '../index.dart';

class Example2 extends StatelessWidget {
  const Example2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('禁用状态'),
        CodeExampleWidget(
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
        // const Gap(8),
        // CodeExampleWidget(
        //   code: code2,
        //   children: [
        //     buildWrap(
        //       buttonTypes.map(
        //         (type) => ElButton(
        //           child: (type ?? 'Default').firstUpperCase,
        //           onPressed: null,
        //           type: type,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

String get code1 => '''
ElButton(child: 'Hello', disabled: true),''';

String get code2 => '''
import 'package:docs/global.dart';

import 'package:flutter/material.dart';

class CollapsePage extends HookWidget {
  const CollapsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final expanded1 = useState([]);
    final expanded2 = useState([]);

    final children = [
      ElCollapseItem(
        id: '1',
        title: '菜单一',
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            children: [SelectableText('测试文字' * 20)],
          ),
        ),
      ),
      const ElCollapseItem(
        id: '2',
        title: '菜单二',
        child: TextSelectionTheme(
          data: TextSelectionThemeData(
            selectionColor: Color.fromRGBO(42, 65, 130, 1),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('内容二'),
          ),
        ),
      ),
      const ElCollapseItem(
        id: '3',
        title: '菜单三',
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('内容三'),
        ),
      ),
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElCollapse(expanded1, children: children),
            const Gap(16),
            const H4('手风琴模式'),
            const Gap(16),
            ElCollapse(expanded2, accordion: true, children: children),
          ],
        ),
      ),
    );
  }
}''';
