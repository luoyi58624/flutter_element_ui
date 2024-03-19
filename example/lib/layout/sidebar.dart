import 'package:example/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:go_router/go_router.dart';

class LayoutSidebarWidget extends StatefulWidget {
  const LayoutSidebarWidget({super.key});

  @override
  State<LayoutSidebarWidget> createState() => _LayoutSidebarWidgetState();
}

class _LayoutSidebarWidgetState extends State<LayoutSidebarWidget> {
  List<ElMenuModel> get menuList => [
        ElMenuModel(title: '首页', icon: const ElIcon.svg(ElIcons.homeFilled), path: '/'),
        ElMenuModel(title: '组件', icon: const ElIcon.svg(ElIcons.eleme), path: '/components'),
        ElMenuModel(title: '测试', icon: const ElIcon.svg(ElIcons.comment), path: '/test'),
        ElMenuModel(
          title: '嵌套菜单',
          icon: const ElIcon.svg(ElIcons.folder),
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
                    10,
                    (secondIndex) => ElMenuModel(title: '子菜单3 - ${index + 1} - ${secondIndex + 1}'),
                  ).toList(),
                ),
              ).toList(),
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: GlobalState.activePath,
      builder: (context, value, child) => ElMenu(
        menuList,
        activePath: value,
        onChange: (menu) {
          if (menu.path != null && menu.path != GlobalState.activePath.value) {
            context.go(menu.path!);
            GlobalState.activePath.value = menu.path!;
          }
        },
      ),
    );
  }
}