import 'package:element_docs/global.dart';
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
    return Center(
      child: ElTapBuilder(
        onTapDown: (e) {
          context.stopPropagation();
          i(context.isTap);
        },
        builder: (context) {
          return ElHoverBuilder(builder: (context) {
            return Container(
              width: 300,
              height: 300,
              color: context.isHover ? Colors.red : Colors.green,
              child: ElStopPropagation(
                child: Builder(builder: (context) {
                  return ElButton(
                    onTapDown: (e) {
                      // context.stopPropagation();
                    },
                    onPressed: () {
                      i('hello');
                    },
                    child: 'Hello',
                  );
                }),
              ),
            );
          });
        },
      ),
    );
  }
}
