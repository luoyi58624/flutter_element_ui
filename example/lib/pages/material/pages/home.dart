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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Page'),
        centerTitle: false,
      ),
      drawer: const Drawer(
        child: ListViewDemoWidget(),
      ),
      body: SingleChildScrollView(
        child: ColumnWidget(children: [
          const CardWidget( title: '通用组件', children: [
            CellWidget(
              title: 'Hook 测试',
              page: HookDemoPage(),
            ),
            CellWidget(
              title: '1000个Slider 测试',
              page: SliderTestPage(),
            ),
          ]),
          const Gap(8),
          const ButtonWidgets(),
          const FormWidgets(),
          const TabWidget(),
          // const CupertinoWidgets(),
          ...List.generate(
            20,
            (index) => CellWidget(
              onTap: () {},
              title: '列表 - ${index + 1}',
            ),
          ),
        ]),
      ),
    );
  }
}
