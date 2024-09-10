import 'package:docs/global.dart';
import 'package:docs/pages/commons/responsive_page.dart';

import 'package:flutter/material.dart';

import 'examples/example1.dart';

class CollapsePage extends ResponsivePage {
  const CollapsePage({super.key});

  @override
  String get title => 'Collapse 折叠面板';

  @override
  List<Widget> buildPage(BuildContext context) {
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

    return [
      const Example1(),
      ElCollapsePanel(expanded1, children: children),
      const Gap(16),
      const H4('手风琴模式'),
      const Gap(16),
      ElCollapsePanel(expanded2, accordion: true, children: children),
    ];
  }
}
