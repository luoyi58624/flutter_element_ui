import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  List<ElMenuModel> get model => [
        ElMenuModel(title: '一级菜单', icon: Icons.home),
        ElMenuModel(
          title: '二级菜单',
          icon: Icons.add_card,
          children: [
            ElMenuModel(title: '子菜单1'),
            ElMenuModel(title: '子菜单2'),
            ElMenuModel(title: '子菜单3', children: [
              ElMenuModel(title: '子菜单3-1'),
              ElMenuModel(title: '子菜单3-2'),
            ]),
          ],
        ),
        ElMenuModel(title: '三级菜单'),
        ElMenuModel(title: '四级菜单'),
        ElMenuModel(title: '五级菜单'),
      ];

  @override
  Widget build(BuildContext context) {
    return ElMenu(model);
  }
}
