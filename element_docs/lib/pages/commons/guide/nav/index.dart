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
        const ElButtonGroup(
          axis: Axis.vertical,
          children: [
            ElButton(child: '选项一'),
            ElButton(child: '选项二'),
            ElButton(child: '选项三'),
          ],
        ),
        const Gap(100),
        Stack(
          children: [
            IntrinsicWidth(
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 20,
                    color: Colors.green,
                  ),
                  const Gap(8),
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: Colors.red,
                  ),
                  const Gap(8),
                  Container(
                    width: 400,
                    height: 20,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
