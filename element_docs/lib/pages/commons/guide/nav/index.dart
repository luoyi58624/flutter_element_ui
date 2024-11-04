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
    return TapWidget(
      onTapDown: (e) {
        i('parent');
      },
      child: Container(
        width: 300,
        height: 300,
        color: Colors.green,
        child: Center(
          child: Builder(
            builder: (context) {
              return TapWidget(
                onTapDown: (e) {
                  TapWidget.stopPropagation(context);
                  i('child');
                },
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.red,
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
