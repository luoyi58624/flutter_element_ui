import 'package:example/global.dart';
import 'package:example/routes/element.dart';
import 'package:flutter/material.dart';

List<ElMenuModel> menuList = [
  ElMenuModel(
    title: '首页',
    icon: ElIcons.homeFilled,
    path: '${ElementRoutes.root}/home',
  ),
  ElMenuModel(
    title: '组件',
    icon: ElIcons.eleme,
    path: ElementRoutes.component,
    collapse: Obs(true),
    children: [
      ElMenuModel(
        title: 'Layout 布局组件',
        path: ElementRoutes.componentLayout,
        collapse: ValueNotifier(false),
        children: [
          ElMenuModel(
            title: '基础布局',
            path: '${ElementRoutes.componentLayout}/basic',
          ),
          ElMenuModel(
            title: '拖拽尺寸',
            path: '${ElementRoutes.componentLayout}/drag',
          ),
        ],
      ),
      ElMenuModel(
        title: 'Basic 基础组件',
        path: ElementRoutes.componentBasic,
        collapse: ValueNotifier(false),
        children: [
          ElMenuModel(
            title: 'Button 按钮',
            path: '${ElementRoutes.componentBasic}/button',
          ),
          ElMenuModel(
            title: 'Text 文字',
            path: '${ElementRoutes.componentBasic}/text',
          ),
          ElMenuModel(
            title: 'Color 颜色',
            path: '${ElementRoutes.componentBasic}/color',
          ),
          ElMenuModel(
            title: 'Font 字体',
            path: '${ElementRoutes.componentBasic}/font',
          ),
        ],
      ),
      ElMenuModel(
        title: 'Form 表单组件',
        path: ElementRoutes.componentForm,
        collapse: ValueNotifier(false),
        children: [
          ElMenuModel(
            title: 'Input 输入框',
            path: '${ElementRoutes.componentForm}/input',
          ),
          ElMenuModel(
            title: 'Radio 单选框',
            path: '${ElementRoutes.componentForm}/radio',
          ),
          ElMenuModel(
            title: 'Switch 开关',
            path: '${ElementRoutes.componentForm}/switch',
          ),
          ElMenuModel(
            title: 'Slider 滑块',
            path: '${ElementRoutes.componentForm}/slider',
          ),
          ElMenuModel(
            title: 'Form 表单',
            path: '${ElementRoutes.componentForm}/form',
          ),
        ],
      ),
      ElMenuModel(
        title: 'Data 数据展示',
        path: ElementRoutes.componentData,
        collapse: ValueNotifier(false),
        children: [
          ElMenuModel(
            title: 'Badge 徽章',
            path: '${ElementRoutes.componentData}/badge',
          ),
          ElMenuModel(
            title: 'Image 图片',
            path: '${ElementRoutes.componentData}/image',
          ),
          ElMenuModel(
            title: 'Table 表格',
            path: '${ElementRoutes.componentData}/table',
          ),
        ],
      ),
      ElMenuModel(
        title: 'FeedBack 反馈组件',
        path: ElementRoutes.componentFeedBack,
        collapse: ValueNotifier(false),
        children: [
          ElMenuModel(
            title: 'Dialog 对话框',
            path: '${ElementRoutes.componentFeedBack}/dialog',
          ),
        ],
      ),
    ],
  ),
  ElMenuModel(
    title: '测试',
    icon: ElIcons.comment,
    collapse: ValueNotifier(false),
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
  // ElMenuModel(
  //   title: '嵌套菜单',
  //   icon: ElIcons.folder,
  //   children: [
  //     ElMenuModel(title: '子菜单1'),
  //     ElMenuModel(title: '子菜单2'),
  //     ElMenuModel(
  //       title: '子菜单3',
  //       children: List.generate(
  //         10,
  //         (index) => ElMenuModel(
  //           title: '子菜单3-${index + 1}',
  //           children: List.generate(
  //             100,
  //             (secondIndex) => ElMenuModel(
  //                 title: '子菜单3 - ${index + 1} - ${secondIndex + 1}'),
  //           ).toList(),
  //         ),
  //       ).toList(),
  //     ),
  //   ],
  // ),
];

class LayoutSidebarWidget extends StatelessWidget {
  const LayoutSidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ObsBuilder(
      builder: (context) {
        return ElMenu(
          menuList,
          activePath: GlobalState.elMenu.value.activePath,
          collapse: GlobalState.elMenu.value.isCollapse,
          onChange: (menu) {
            if (menu.path != null &&
                menu.path != GlobalState.elMenu.value.activePath) {
              context.go(menu.path!);
              GlobalState.elMenu.value =
                  GlobalState.elMenu.value.copyWith(activePath: menu.path!);
            }
          },
        );
      },
    );
  }
}

/// 将go_router的路由转换成菜单
// List<ElMenuModel> routerToMenu(ShellRoute shellRoute) {
//   for (var route in shellRoute.routes) {
//     if (route is GoRoute) {}
//   }
// }
