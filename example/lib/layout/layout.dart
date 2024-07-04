import 'package:defer_pointer/defer_pointer.dart';
import 'package:example/pages/components/layout/overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:go_router/go_router.dart';

import '../global.dart';
import '../pages/components/layout/drag.dart';
import 'header.dart';
import 'sidebar.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    // return Demo();
    return const OverlayPage();
    // return LayoutDragPage();
    // return ElLayout(
    //   children: [
    //     const ElAside(child: LayoutSidebarWidget()),
    //     const ElSplit(size: 1),
    //     ElLayout(
    //       children: [
    //         ElHeader(child: Container(color: Colors.purple)),
    //         const ElSplit(),
    //         ElLayout(children: [
    //           ElMain(child: Container(color: Colors.green)),
    //           const ElSplit(),
    //           ElMain(child: Container(color: Colors.grey)),
    //         ]),
    //       ],
    //     ),
    //     ElLayout(children: [
    //
    //       const ElSplit(size: 1),
    //       ElAside(
    //         layoutKey: 'aside-3',
    //         child: Container(color: Colors.grey),
    //       ),
    //     ]),
    //     ElMain(child: Container(color: Colors.green)),
    //     const ElSplit(size: 1),
    //     ElAside(
    //       child: Container(width: 200, color: Colors.grey),
    //     ),
    //
    //     ElLayout(children: [
    //       const ElHeader(child: LayoutHeaderWidget()),
    //       ElMain(child: navigationShell),
    //     ]),
    //   ],
    // );
  }
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  int count = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElButton(
          onPressed: () {
            setState(() {
              count++;
            });
          },
          child: 'count: $count',
        ),
        RepaintBoundary(child: Demo2()),
      ],
    );
  }
}

class Demo2 extends StatelessWidget {
  const Demo2({super.key});

  @override
  Widget build(BuildContext context) {
    i('demo2 build');
    return Text('xxx');
  }
}
