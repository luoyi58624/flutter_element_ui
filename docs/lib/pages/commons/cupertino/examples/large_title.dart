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
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            // heroTag: 'user_hero',
            largeTitle: const Text(
              '个人中心',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            trailing: CupertinoButton(
              onPressed: () {},
              padding: EdgeInsets.zero,
              child: const Text(
                '设置',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            border: null,
            backgroundColor:
                CupertinoColors.systemGroupedBackground.resolveFrom(context),
          ),
        ],
      ),
    );
  }
}
