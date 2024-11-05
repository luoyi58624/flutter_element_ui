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
        onTap: (){
          w('parent');
        },
        builder: (context) {
          return Container(
            width: 300,
            height: 300,
            color: context.isTap ? Colors.red : Colors.green,
            child: Builder(
              builder: (context) {
                return ElButton(
                  onTapDown: (e){
                    context.stopPropagation();
                  },
                  onPressed: () {
                    i('child');
                  },
                  child: 'Hello',
                );
              }
            ),
          );
        },
      ),
    );
  }
}
