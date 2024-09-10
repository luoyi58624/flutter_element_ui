import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';

import 'examples/01.dart';

class CupertinoOverviewPage extends StatelessWidget {
  const CupertinoOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Cupertino'),
            previousPageTitle: '组件',
            border: null,
            trailing: ObsBuilder(builder: (context) {
              return CupertinoSwitch(
                value: GlobalState.isDark,
                onChanged: (v) => GlobalState.isDark = v,
              );
            }),
          ),
          const SliverToBoxAdapter(
            child: Example1(),
          ),
          SuperSliverList.builder(
            itemCount: 1000,
            itemBuilder: (context, index) => CupertinoListTile(
              onTap: () {},
              title: Text('列表 - ${index + 1}'),
            ),
          )
        ],
      ),
    );
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino 组件总览'),
        previousPageTitle: '组件',
      ),
      child: SafeArea(
        child: ColumnWidget(
          scroll: true,
          repaintBoundary: true,
          padding: EdgeInsets.all(8),
          children: [
            Example1(),
          ],
        ),
      ),
    );
  }
}
