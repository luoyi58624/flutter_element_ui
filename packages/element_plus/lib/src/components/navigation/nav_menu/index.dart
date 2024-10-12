import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';

import '../../../models/menu.dart';
import '../../../utils/font.dart';
import '../../basic/link/index.dart';

part 'state.dart';

part 'style.dart';

part '../../../generates/components/navigation/nav_menu/index.g.dart';

class ElNavMenu extends StatefulWidget {
  /// 创建普通菜单导航
  const ElNavMenu(
    this.menuList, {
    super.key,
    this.activeKey = '',
    this.width = 240,
    this.collapseWidth = 64,
    this.gap = 20,
    this.bgColor,
    this.iconSize = 20,
    this.onChange,
  })  : assert(activeKey != null),
        router = null,
        rootRouterPath = '/';

  /// 创建路由菜单导航，你必须使用声明式路由构建App: [MaterialApp.router]
  const ElNavMenu.router(
    this.menuList, {
    super.key,
    required this.router,
    this.rootRouterPath = '/',
    this.width = 240,
    this.collapseWidth = 64,
    this.gap = 20,
    this.bgColor,
    this.iconSize = 20,
    this.onChange,
  })  : assert(router != null),
        assert(rootRouterPath != ''),
        activeKey = null;

  /// 菜单模型集合
  final List<ElMenuModel> menuList;

  /// 声明式路由实例对象，内部将监听 url 的变化，并将 url 作为菜单 key
  final RouterConfig? router;

  /// 当前菜单所对应的根路由，设置它可以缩小监听的范围
  final String rootRouterPath;

  /// 普通菜单激活的key
  final String? activeKey;

  /// 菜单栏宽度
  final double width;

  /// 菜单收起宽度
  final double collapseWidth;

  /// 嵌套子菜单距离上一层级的间距
  final double gap;

  /// 菜单栏背景颜色，默认: theme.asideTheme.color
  final Color? bgColor;

  /// 菜单图标大小，默认20
  final double iconSize;

  final void Function(ElMenuModel menu)? onChange;

  @override
  State<ElNavMenu> createState() => _ElNavMenuState();
}
