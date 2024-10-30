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
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: context.elAnimatedTheme.primary
                .mix(const Color(0xffffffff), 50),
          ),
          child: ElText(
            'Hello',
            style: TextStyle(
              color: context.elTheme.bgColor.elTextColor(context),
            ),
          ),
        ),
        const Gap(8),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: context.elAnimatedTheme.primary.demo(context),
          ),
        ),
        const Gap(8),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: context.elAnimatedTheme.primary.elLight5(context),
          ),
        ),
      ],
    );
  }
}

extension ElColorExtension2 on Color {
  Color demo(BuildContext context) => mix(Colors.black, 50);

  Color demo2(BuildContext context) =>
      context.isDark ? mix(Colors.black, 50) : mix(Colors.white, 50);
}
