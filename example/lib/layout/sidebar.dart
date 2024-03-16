import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class LayoutSidebarWidget extends StatefulWidget {
  const LayoutSidebarWidget({super.key});

  @override
  State<LayoutSidebarWidget> createState() => _LayoutSidebarWidgetState();
}

class _LayoutSidebarWidgetState extends State<LayoutSidebarWidget> {
  List<ElMenuModel> get menuList => [
        ElMenuModel(title: '一级菜单', icon: Icons.home),
        ElMenuModel(
          title: '二级菜单',
          icon: Icons.add_card,
          children: [
            ElMenuModel(title: '子菜单1'),
            ElMenuModel(title: '子菜单2'),
            ElMenuModel(
                title: '子菜单3',
                children: List.generate(
                  5,
                  (index) => ElMenuModel(
                    title: '子菜单3-${index + 1}',
                    children: List.generate(
                      4,
                      (secondIndex) => ElMenuModel(title: '子菜单3 - ${index + 1} - ${secondIndex + 1}'),
                    ).toList(),
                  ),
                ).toList()),
          ],
        ),
        ElMenuModel(
          title: '三级菜单',
          children: List.generate(4, (index) => ElMenuModel(title: '子菜单${index + 1}')).toList(),
        ),
        ElMenuModel(title: '四级菜单'),
        ElMenuModel(title: '五级菜单'),
      ];

  @override
  Widget build(BuildContext context) {
    return ElMenu(menuList);
  }
}
