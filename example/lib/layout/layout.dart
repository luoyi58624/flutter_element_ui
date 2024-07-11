import 'package:flutter/material.dart';

import '../global.dart';
import 'header.dart';
import 'sidebar.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return context.sm
        ? Scaffold(
            appBar: AppBar(
              title: const Text('Element UI'),
            ),
            drawer: Drawer(
              backgroundColor: context.elTheme.asideBgColor,
              child: const SafeArea(child: LayoutSidebarWidget()),
            ),
            body: navigationShell,
          )
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
