import 'package:example/global.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/cupertino.dart';
import '../widgets/form.dart';
import '../widgets/simple_widgets.dart';
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
          buildCardWidget(context, title: '通用组件', children: [
            buildCellWidget(context,
                title: 'Hook 测试', page: const HookDemoPage()),
          ]),
          const Gap(8),
          const ButtonWidgets(),
          const FormWidgets(),
          const TabWidget(),
          const CupertinoWidgets(),
          ...List.generate(
            20,
            (index) => buildCellWidget(
              context,
              onTap: () {},
              title: '列表 - ${index + 1}',
            ),
          ),
        ]),
      ),
    );
  }
}
