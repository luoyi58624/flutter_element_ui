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
        ElMenuModel(title: '首页', icon: ElIcons.homeFilled, path: '/'),
        ElMenuModel(
          title: '组件',
          icon: ElIcons.eleme,
          path: '/components',
          children: [
            ElMenuModel(
              title: 'Basic 基础组件',
              path: '/components/basic',
              children: [
                ElMenuModel(
                  title: 'Button 按钮',
                  path: '/components/basic/button',
                ),
                ElMenuModel(
                  title: 'Text 文字',
                  path: '/components/basic/text',
                ),
                ElMenuModel(
                  title: 'Color 颜色',
                  path: '/components/basic/color',
                ),
                ElMenuModel(
                  title: 'Font 字体',
                  path: '/components/basic/font',
                ),
              ],
            ),
            ElMenuModel(
              title: 'Form 表单组件',
              path: '/components/form',
              children: [
                ElMenuModel(
                  title: 'Input 输入框',
                  path: '/components/form/input',
                ),
                ElMenuModel(
                  title: 'Form 表单',
                  path: '/components/form/form',
                ),
              ],
            ),
            ElMenuModel(
              title: 'Data 数据展示',
              path: '/components/data',
              children: [
                ElMenuModel(
                  title: 'Badge 徽章',
                  path: '/components/data/badge',
                ),
                ElMenuModel(
                  title: 'Table 表格',
                  path: '/components/data/table',
                ),
              ],
            ),
            ElMenuModel(
              title: 'FeedBack 反馈组件',
              path: '/components/feedback',
              children: [
                ElMenuModel(
                  title: 'Dialog 对话框',
                  path: '/components/feedback/dialog',
                ),
              ],
            ),
          ],
        ),
        ElMenuModel(
          title: '测试',
          icon: ElIcons.comment,
          children: [
            ElMenuModel(
              title: '边框',
              path: '/tests/border',
            ),
            ElMenuModel(
              title: '图片列表',
              path: '/tests/image_list',
            ),
          ],
        ),
        ElMenuModel(
          title: '嵌套菜单',
          icon: ElIcons.folder,
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
                    (secondIndex) => ElMenuModel(
                        title: '子菜单3 - ${index + 1} - ${secondIndex + 1}'),
                  ).toList(),
                ),
              ).toList(),
            ),
          ],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ValueListenableBuilder(
        valueListenable: GlobalState.elMenu,
        builder: (context, value, child) => ElMenu(
          menuList,
          activePath: value.activePath,
          collapse: value.isCollapse,
          onChange: (menu) {
            if (menu.path != null &&
                menu.path != GlobalState.elMenu.value.activePath) {
              context.go(menu.path!);
              GlobalState.elMenu.value =
                  GlobalState.elMenu.value.copyWith(activePath: menu.path!);
            }
          },
        ),
      ),
    );
  }
}

/// 将go_router的路由转换成菜单
// List<ElMenuModel> routerToMenu(ShellRoute shellRoute) {
//   for (var route in shellRoute.routes) {
//     if (route is GoRoute) {}
//   }
// }
