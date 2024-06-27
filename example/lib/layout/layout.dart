import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:go_router/go_router.dart';

import 'header.dart';
import 'sidebar.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return ElLayout(
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
