import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:go_router/go_router.dart';

import 'header.dart';
import 'sidebar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const LayoutSidebarWidget(),
        Expanded(
          child: Column(
            children: [
              const LayoutHeaderWidget(),
              Expanded(
                child: widget.navigationShell,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
