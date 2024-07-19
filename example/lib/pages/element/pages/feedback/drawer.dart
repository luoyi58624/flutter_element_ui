import 'package:example/global.dart';
import 'package:flutter/material.dart';

class DrawerPage extends HookWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final showDrawer = useObs(false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ElDrawer(showDrawer, child: const ListViewDemoWidget()),
          ObsBuilder(builder: (context) {
            return ElButton(
              onPressed: () {
                showDrawer.value = true;
              },
              child: showDrawer.value ? '关闭Drawer' : '打开Drawer',
            );
          }),
        ],
      ),
    );
  }
}
