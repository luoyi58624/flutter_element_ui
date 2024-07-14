import 'package:flutter/cupertino.dart';
import 'package:example/global.dart';

class CupertinoWidgets extends HookWidget {
  const CupertinoWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      children: const [
        CupertinoListTile(
          title: Text('用户名'),
          additionalInfo: Text('hihi'),
        ),
        CupertinoListTile(
          title: Text('用户名'),
          additionalInfo: Text('hihi'),
        ),
      ],
    );
  }
}
