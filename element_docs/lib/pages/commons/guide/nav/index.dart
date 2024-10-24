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
    final selected = useState(-1);
    final loading = useState(false);

    return Column(
      children: [
        const Gap(8),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: context.elTheme.primary.mix(Colors.white, 70),
            border: Border.all(
              width: 5,
              color: context.elTheme.primary.mix(Colors.white, 70),
            ),
          ),
        ),
        const Gap(8),
        const ElButton(
          child: '选项一',
          type: El.primary,
        ),
        const Gap(8),
        ElButtonTheme.merge(
          data: ElButtonThemeData(
            type: El.primary,
            plain: true,
            borderBuilder: (state) => Border.all(width: 5),
          ),
          child: const ElButtonGroup(
            children: [
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
