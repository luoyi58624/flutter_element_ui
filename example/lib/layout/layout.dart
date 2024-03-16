import 'package:flutter/material.dart';

import 'header.dart';
import 'main.dart';
import 'sidebar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Row(
        children: [
          LayoutSidebarWidget(),
          Expanded(
            child: Column(
              children: [
                LayoutHeaderWidget(),
                Expanded(
                  child: LayoutMainWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
