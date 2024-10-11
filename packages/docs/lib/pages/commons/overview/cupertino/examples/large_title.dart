import 'package:flutter/cupertino.dart';

class CupertinoLargeTitlePage extends StatelessWidget {
  const CupertinoLargeTitlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino 组件总览'),
        previousPageTitle: 'Cupertino',
      ),
      child: SizedBox(),
    );
  }
}
