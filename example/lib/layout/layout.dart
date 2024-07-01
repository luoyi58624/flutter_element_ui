import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:go_router/go_router.dart';

import '../pages/components/layout/drag.dart';
import 'header.dart';
import 'sidebar.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return LayoutDragPage();
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
