import 'package:example/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';

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
      ElCollapseItem(
        id: '2',
        title: '菜单二',
        child: TextSelectionTheme(
          data: const TextSelectionThemeData(
            selectionColor: Color.fromRGBO(42, 65, 130, 1),
          ),
          child: SyntaxView(
            code: _code,
            syntax: Syntax.DART,
            syntaxTheme: SyntaxTheme(
              linesCountColor: const Color(0xFF000000).withOpacity(.7),
              backgroundColor: const Color.fromRGBO(43, 43, 43, 1),
              baseStyle:
                  const TextStyle(color: Color.fromRGBO(171, 183, 198, 1)),
              numberStyle: const TextStyle(color: Color(0xFF098658)),
              commentStyle: const TextStyle(color: Color(0xFF008000)),
              keywordStyle:
                  const TextStyle(color: Color.fromRGBO(195, 124, 55, 1)),
              stringStyle:
                  const TextStyle(color: Color.fromRGBO(110, 134, 89, 1)),
              punctuationStyle:
                  const TextStyle(color: Color.fromRGBO(171, 183, 198, 1)),
              classStyle:
                  const TextStyle(color: Color.fromRGBO(248, 200, 112, 1)),
              constantStyle: const TextStyle(color: Color(0xFF0070C1)),
              zoomIconColor: const Color(0xFF0D1429),
            ),
            fontSize: 16.0,
            withZoom: false,
            withLinesCount: false,
            expanded: false,
            selectable: true,
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
            ElCollapsePanel(expanded1, children: children),
            const Gap(16),
            const H4('手风琴模式'),
            const Gap(16),
            ElCollapsePanel(expanded2, accordion: true, children: children),
          ],
        ),
      ),
    );
  }
}

String get _code => '''
import 'package:example/global.dart';
import 'package:flutter/widgets.dart';

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
        child: Wrap(
          children: [Text('测试文字' * 20)],
        ),
      ),
      const ElCollapseItem(id: '2', title: '菜单二', child: Text('内容二')),
      const ElCollapseItem(id: '3', title: '菜单三', child: Text('内容三')),
    ];

    return Padding(
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
    );
  }
}
''';
