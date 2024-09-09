import 'package:example/global.dart';
import 'package:flutter/material.dart';

import '../../layout.dart';
import 'header.dart';
import 'sidebar.dart';

class ElementLayoutPage extends LayoutPageBase {
  const ElementLayoutPage(super.navigationShell, {super.key});

  @override
  Widget buildDesktopLayout(context) {
    return Row(
      children: [
        const LayoutSidebarWidget(),
        const ElDivider(vertical: true),
        Expanded(
          child: Column(
            children: [
              const LayoutHeaderWidget(),
              Expanded(child: navigationShell),
            ],
          ),
        ),
      ],
    );
    // return ElLayout(
    //   children: [
    //     const ElAside(child: LayoutSidebarWidget()),
    //     ElLayout(children: [
    //       const ElHeader(child: LayoutHeaderWidget()),
    //       ElMain(child: navigationShell),
    //     ]),
    //   ],
    // );
  }

  @override
  Widget buildMobileLayout(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Element UI'),
      ),
      drawer: Drawer(
        backgroundColor: context.elTheme.asideStyle.color,
        child: const SafeArea(child: LayoutSidebarWidget()),
      ),
      body: navigationShell,
    );
  }
}
