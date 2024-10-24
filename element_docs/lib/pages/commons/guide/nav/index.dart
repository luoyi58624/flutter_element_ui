import 'package:element_docs/global.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      const _Example(),
    ];
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final selectedList = useObs<List<int>>([]);

    return Column(
      children: [
        ElButtonTheme.merge(
          data: const ElButtonThemeData(
            type: El.success,
          ),
          child: ElButtonGroup.multi(
            selectedList,
            children: const [
              ElButton(child: '选项一'),
              ElButton(child: '选项二'),
              ElButton(child: '选项三'),
              ElButton(child: '选项四'),
            ],
          ),
        ),
      ],
    );
  }
}
