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
