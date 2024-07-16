import 'package:example/global.dart';
import 'package:example/routes/element.dart';
import 'package:flutter/material.dart';

class LayoutSidebarWidget extends StatelessWidget {
  const LayoutSidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElMenu.router(
      menuList,
      router: router,
      rootRouterPath: ElementRoutes.root,
    );
  }
}

List<ElMenuModel> menuList = [
  const ElMenuModel(
    title: '首页',
    icon: ElIcons.homeFilled,
    key: '${ElementRoutes.root}/home',
  ),
  const ElMenuModel(
    title: '组件',
    icon: ElIcons.eleme,
    key: ElementRoutes.component,
    children: [
      ElMenuModel(
        title: 'Layout 布局组件',
        key: ElementRoutes.componentLayout,
        children: [
          ElMenuModel(
            title: '基础布局',
            key: '${ElementRoutes.componentLayout}/basic',
          ),
          ElMenuModel(
            title: '拖拽尺寸',
            key: '${ElementRoutes.componentLayout}/drag',
          ),
        ],
      ),
      ElMenuModel(
        title: 'Basic 基础组件',
        key: ElementRoutes.componentBasic,
        children: [
          ElMenuModel(
            title: 'Button 按钮',
            key: '${ElementRoutes.componentBasic}/button',
          ),
          ElMenuModel(
            title: 'Text 文字',
            key: '${ElementRoutes.componentBasic}/text',
          ),
          ElMenuModel(
            title: 'Color 颜色',
            key: '${ElementRoutes.componentBasic}/color',
          ),
          ElMenuModel(
            title: 'Font 字体',
            key: '${ElementRoutes.componentBasic}/font',
          ),
        ],
      ),
      ElMenuModel(
        title: 'Form 表单组件',
        key: ElementRoutes.componentForm,
        children: [
          ElMenuModel(
            title: 'Input 输入框',
            key: '${ElementRoutes.componentForm}/input',
          ),
          ElMenuModel(
            title: 'Radio 单选框',
            key: '${ElementRoutes.componentForm}/radio',
          ),
          ElMenuModel(
            title: 'Switch 开关',
            key: '${ElementRoutes.componentForm}/switch',
          ),
          ElMenuModel(
            title: 'Slider 滑块',
            key: '${ElementRoutes.componentForm}/slider',
          ),
          ElMenuModel(
            title: 'Form 表单',
            key: '${ElementRoutes.componentForm}/form',
          ),
        ],
      ),
      ElMenuModel(
        title: 'Data 数据展示',
        key: ElementRoutes.componentData,
        children: [
          ElMenuModel(
            title: 'Badge 徽章',
            key: '${ElementRoutes.componentData}/badge',
          ),
          ElMenuModel(
            title: 'Image 图片',
            key: '${ElementRoutes.componentData}/image',
          ),
          ElMenuModel(
            title: 'Table 表格',
            key: '${ElementRoutes.componentData}/table',
          ),
        ],
      ),
      ElMenuModel(
        title: 'Navigation 导航',
        key: ElementRoutes.componentNavigation,
        children: [
          ElMenuModel(
            title: 'Menu 菜单',
            key: '${ElementRoutes.componentNavigation}/menu',
          ),
        ],
      ),
      ElMenuModel(
        title: 'FeedBack 反馈组件',
        key: ElementRoutes.componentFeedBack,
        children: [
          ElMenuModel(
            title: 'Dialog 对话框',
            key: '${ElementRoutes.componentFeedBack}/dialog',
          ),
        ],
      ),
    ],
  ),
  // const ElMenuModel(
  //   title: '测试',
  //   key: '/tests',
  //   icon: ElIcons.comment,
  //   children: [
  //     ElMenuModel(
  //       title: '边框',
  //       key: '/tests/border',
  //     ),
  //     ElMenuModel(
  //       title: '图片列表',
  //       key: '/tests/image_list',
  //     ),
  //   ],
  // ),
  // ElMenuModel(
  //   title: '嵌套菜单',
  //   icon: ElIcons.folder,
  //   key: '1',
  //   children: [
  //     const ElMenuModel(title: '子菜单1', key: '1-1'),
  //     const ElMenuModel(title: '子菜单2', key: '1-2'),
  //     ElMenuModel(
  //       title: '子菜单3',
  //       key: '1-3',
  //       children: List.generate(
  //         10,
  //         (index) => ElMenuModel(
  //           title: '子菜单3-${index + 1}',
  //           key: '1-3-$index',
  //           children: List.generate(
  //             100,
  //             (secondIndex) => ElMenuModel(
  //               title: '子菜单3 - ${index + 1} - ${secondIndex + 1}',
  //               key: '1-3-$index-$secondIndex',
  //             ),
  //           ).toList(),
  //         ),
  //       ).toList(),
  //     ),
  //   ],
  // ),
];
