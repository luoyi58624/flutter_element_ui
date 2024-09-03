import 'package:docs/global.dart';
import 'package:flutter/widgets.dart';

class Example1 extends StatelessWidget {
  const Example1({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonTypes = [null, ...el.themeTypes];
    Widget buildTitle(String title) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(28),
            H4(title),
            const Gap(16),
          ],
        );
    Widget buildWrap(Iterable<Widget> children) =>
        Wrap(children: children.toList());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('基础用法'),
        CodeExampleWidget(
          code: code1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildWrap([
                ...buttonTypes.map(
                  (type) => ElButton(
                    child: (type ?? 'Default').firstUpperCase,
                    onPressed: null,
                    type: type,
                  ),
                ),
              ]),
              buildWrap(
                buttonTypes.map(
                  (type) => ElButton(
                    child: (type ?? 'Default').firstUpperCase,
                    onPressed: null,
                    type: type,
                    plain: true,
                  ),
                ),
              ),
              buildWrap(
                buttonTypes.map(
                  (type) => ElButton(
                    child: (type ?? 'Default').firstUpperCase,
                    onPressed: null,
                    type: type,
                    round: true,
                  ),
                ),
              ),
              buildWrap(
                buttonTypes.map(
                  (type) => ElButton(
                    onPressed: null,
                    type: type,
                    child: const ElIcon(ElIcons.aim),
                  ),
                ),
              ),
              buildWrap(
                buttonTypes.map(
                  (type) => ElButton(
                    onPressed: null,
                    type: type,
                    circle: true,
                    child: const ElIcon(ElIcons.aim),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        CodeExampleWidget(
          code: code2,
          child: Column(
            children: [
              buildWrap(
                buttonTypes.map(
                  (type) => ElButton(
                    child: (type ?? 'Default').firstUpperCase,
                    onPressed: null,
                    type: type,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String get code1 => '''
ElButton(onPressed: () {}, child: 'Default'),
ElButton(onPressed: () {}, child: 'Primary', type: 'primary'),
ElButton(onPressed: () {}, child: 'Primary', type: 'success', plain: true),
ElButton(onPressed: () {}, child: 'Primary', type: 'warning', round: true),
ElButton(onPressed: () {}, child: const ElIcon(ElIcons.aim)),
ElButton(onPressed: () {}, child: const ElIcon(ElIcons.aim), circle: true)''';

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
