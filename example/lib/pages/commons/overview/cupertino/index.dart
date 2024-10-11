import 'package:example/global.dart';
import 'package:flutter/cupertino.dart';

import 'examples/example1.dart';

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
  }
}
