import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import 'header.dart';
import 'sidebar.dart';

class LayoutPage extends HookWidget {
  const LayoutPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final enableResampling = useState(false);
    useEffect(() {
      GestureBinding.instance.resamplingEnabled = enableResampling.value;
      return null;
    }, [enableResampling.value]);
    return context.sm
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Element UI'),
              actions: [
                Switch(
                  value: enableResampling.value,
                  onChanged: (v) => enableResampling.value = v,
                ),
              ],
            ),
            drawer: Drawer(
              backgroundColor: context.elTheme.asideBgColor,
              child: const SafeArea(child: LayoutSidebarWidget()),
            ),
            body: navigationShell,
          )
        // Column(
        //         children: [
        //           Container(
        //             child: const Text('Element UI'),
        //           ),
        //           Expanded(child: navigationShell),
        //         ],
        //       )
        : ElLayout(
            children: [
              const ElAside(child: LayoutSidebarWidget()),
              ElLayout(children: [
                const ElHeader(child: LayoutHeaderWidget()),
                ElMain(child: navigationShell),
              ]),
            ],
          );
  }
}
