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
      onChange: (e) {
        context.go(e.key);
      },
    );
  }
}

List<ElMenuModel> menuList = const [
  ElMenuModel(
    title: 'Basic 基础组件',
    key: ElementRoutes.basic,
    children: [
      ElMenuModel(
        title: 'Button 按钮',
        key: '${ElementRoutes.basic}/button',
      ),
      ElMenuModel(
        title: 'Text 文字',
        key: '${ElementRoutes.basic}/text',
      ),
      ElMenuModel(
        title: 'Color 颜色',
        key: '${ElementRoutes.basic}/color',
      ),
      ElMenuModel(
        title: 'Font 字体',
        key: '${ElementRoutes.basic}/font',
      ),
    ],
  ),
  ElMenuModel(
    title: 'Layout 布局组件',
    key: ElementRoutes.layout,
    children: [
      ElMenuModel(
        title: '基础布局',
        key: '${ElementRoutes.layout}/basic',
      ),
      ElMenuModel(
        title: '拖拽尺寸',
        key: '${ElementRoutes.layout}/drag',
      ),
    ],
  ),

  ElMenuModel(
    title: 'Form 表单组件',
    key: ElementRoutes.form,
    children: [
      ElMenuModel(
        title: 'Input 输入框',
        key: '${ElementRoutes.form}/input',
      ),
      ElMenuModel(
        title: 'Radio 单选框',
        key: '${ElementRoutes.form}/radio',
      ),
      ElMenuModel(
        title: 'Switch 开关',
        key: '${ElementRoutes.form}/switch',
      ),
      ElMenuModel(
        title: 'Slider 滑块',
        key: '${ElementRoutes.form}/slider',
      ),
      ElMenuModel(
        title: 'Form 表单',
        key: '${ElementRoutes.form}/form',
      ),
    ],
  ),
  ElMenuModel(
    title: 'Data 数据展示',
    key: ElementRoutes.data,
    children: [
      ElMenuModel(
        title: 'Badge 徽章',
        key: '${ElementRoutes.data}/badge',
      ),
      ElMenuModel(
        title: 'Image 图片',
        key: '${ElementRoutes.data}/image',
      ),
      ElMenuModel(
        title: 'Table 表格',
        key: '${ElementRoutes.data}/table',
      ),
    ],
  ),
  ElMenuModel(
    title: 'Navigation 导航',
    key: ElementRoutes.navigation,
    children: [
      ElMenuModel(
        title: 'Menu 菜单',
        key: '${ElementRoutes.navigation}/menu',
      ),
    ],
  ),
  ElMenuModel(
    title: 'FeedBack 反馈组件',
    key: ElementRoutes.feedBack,
    children: [
      ElMenuModel(
        title: 'Dialog 对话框',
        key: '${ElementRoutes.feedBack}/dialog',
      ),
      ElMenuModel(
        title: 'Drawer 抽屉',
        key: '${ElementRoutes.feedBack}/drawer',
      ),
      ElMenuModel(
        title: 'Tooltip 文字提示',
        key: '${ElementRoutes.feedBack}/tooltip',
      ),
    ],
  ),
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
