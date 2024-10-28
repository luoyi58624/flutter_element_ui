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
    return Column(
      children: [
        const Gap(8),
        ElHoverBuilder(builder: (context) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: context.isHover ? Colors.green : context.elTheme.bgColor,
              border: Border.all(),
            ),
          );
        }),
        const Gap(8),
        ElHoverBuilder(builder: (context) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: context.isHover
                  ? Colors.green
                  : context.elAnimatedTheme.bgColor,
              border: Border.all(),
            ),
          );
        }),
        const Gap(8),
        ElHoverBuilder(builder: (context) {
          return AnimatedContainer(
            duration: context.elDuration(500.ms),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: context.isHover ? Colors.green : context.elTheme.bgColor,
              border: Border.all(),
            ),
          );
        }),
      ],
    );
  }
}
