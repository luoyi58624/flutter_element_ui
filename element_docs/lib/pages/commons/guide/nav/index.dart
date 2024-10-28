import 'package:element_docs/global.dart';
import 'package:element_docs/pages/commons/component/basic/button/examples/example6.dart';
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
    final isLoading = useState(false);
    return Column(
      children: [
        const Gap(8),
        AnimatedContainer(
          duration: context.elDuration(300.ms),
        ),
        AnimatedContainer(
          duration: context.elDuration(300.ms),
          width: 400,
          height: 400,
          color: context.elTheme.primary,
          child: Text(
            'hello',
            style: context.elTheme.textTheme.style,
          ),
        ),
        Container(
          width: 400,
          height: 36,
          color: context.elTheme.success,
          child: Center(
            child: Text('hihi' * 100),
          ),
        ),
      ],
    );
  }
}
