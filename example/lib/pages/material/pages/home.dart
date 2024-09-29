import 'package:example/global.dart';
import 'package:example/pages/material/pages/slider_test.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/form.dart';
import '../widgets/tab.dart';
import 'hook.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    10.ms;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Page'),
        centerTitle: false,
      ),
      drawer: const Drawer(
        child: ListViewDemoWidget(),
      ),
      body: ObsBuilder(builder: (context) {
        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: CardWidget(title: '通用组件', children: [
                CellWidget(
                  title: 'Hook 测试',
                  page: HookDemoPage(),
                ),
                CellWidget(
                  title: '1000个Slider 测试',
                  page: SliderTestPage(),
                ),
              ]),
            ),
            const SliverToBoxAdapter(child: Gap(8)),
            const SliverToBoxAdapter(child: ButtonWidgets()),
            const SliverToBoxAdapter(child: FormWidgets()),
            const SliverToBoxAdapter(child: TabWidget()),
            // const CupertinoWidgets(),
            SuperSliverList.builder(
              itemCount: 10000,
              itemBuilder: (context, index) => ListTile(
                onTap: (){},
                title: Text('列表 - ${index + 1}'),
              ),
            )
          ],
        );
      }),
    );
  }
}
