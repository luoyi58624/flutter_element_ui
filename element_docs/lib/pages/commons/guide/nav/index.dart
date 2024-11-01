import 'package:element_docs/global.dart';
import 'package:element_docs/pages/commons/guide/nav/my_scrollbar.dart';
import 'package:flutter/material.dart';

class NavPage extends ResponsivePage {
  const NavPage({super.key});

  @override
  String get title => '导航';

  @override
  List<Widget> buildPage(BuildContext context) {
    return <Widget>[
      const Gap(50),
      const _Example(),
    ];
  }
}

class _Example extends HookWidget {
  const _Example();

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    return SizedBox(
      height: 300,
      child: MyScrollbar(
        controller: controller,
        child: SingleChildScrollView(
          controller: controller,
          child: Column(
            children: List.generate(
              100,
              (index) => ListTile(
                onTap: () {},
                title: Text('item - ${index + 1}'),
              ),
            ),
          ),
        ).noScrollBehavior,
      ),
    );
  }
}
