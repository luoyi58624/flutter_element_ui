import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

import '../index.dart';

class ElMaterialTabs extends StatefulWidget {
  /// Flutter Material 原生实现的 Tabs 标签
  const ElMaterialTabs({super.key});

  @override
  State<ElMaterialTabs> createState() => _ElMaterialTabsState();
}

class _ElMaterialTabsState extends State<ElMaterialTabs>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  late int tabLength;

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final $data = ElTabs.of(context);
    if (controller == null) {
      tabLength = $data.children.length;
      controller = TabController(length: tabLength, vsync: this);
    } else {
      if (tabLength != $data.children.length) {
        tabLength = $data.children.length;
        controller!.dispose();
        setTimeout(() {
          controller = TabController(length: tabLength, vsync: this);
        }, 1);
      }
    }
    return TabBar(
      controller: controller,
      tabs: $data.children.map((e) {
        Widget? icon;
        if (e.icon is Widget) icon = e.icon;
        return Tab(icon: icon, text: e.title);
      }).toList(),
    );
  }
}
