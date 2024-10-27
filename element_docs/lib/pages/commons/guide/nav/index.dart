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
        AnimatedContainer(
          duration: context.elDuration(300.ms),
        ),
        AnimatedContainer(
          duration: context.elDuration(300.ms),
          width: 400,
          height: 400,
          color: ElTheme.of(context).primary,
          child: Text(
            'hello',
            style: ElTheme.of(context).textTheme.style,
          ),
        ),
        Container(
          width: 400,
          height: 400,
          color: ElTheme.of(context).success,
        ),
      ],
    );
  }
}
