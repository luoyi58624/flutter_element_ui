import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/global.dart';

import '../../../utils/font.dart';
import '../../../utils/icons.dart';
import '../../basic/icon.dart';
import '../../basic/link/link.dart';
import '../../basic/text.dart';

part 'menu_modal.dart';

part 'menu_widget.dart';

class ElMenu extends StatefulWidget {
  /// 创建普通菜单导航
  const ElMenu(
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
  const ElMenu.router(
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

  /// 菜单栏背景颜色，默认跟随侧边栏背景色
  final Color? bgColor;

  /// 菜单图标大小，默认20
  final double iconSize;

  final void Function(ElMenuModel menu)? onChange;

  @override
  State<ElMenu> createState() => _ElMenuState();
}

class _ElMenuState extends State<ElMenu> {
  /// 激活的菜单层级链
  List<String> activeKeyList = [];

  /// 以路由地址作为菜单key，使用此变量前必须用 router 构造函数
  String get routeKey {
    assert(widget.router != null);
    return widget.router!.routerDelegate.currentConfiguration.uri.path;
  }

  @override
  void initState() {
    super.initState();
    if (widget.router != null) {
      setActiveKey(routeKey);
      widget.router!.routerDelegate.addListener(_routerListen);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.router != null) {
      widget.router!.routerDelegate.removeListener(_routerListen);
    }
  }

  @override
  void didUpdateWidget(covariant ElMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.router != oldWidget.router) {
      if (oldWidget.router != null) {
        oldWidget.router!.routerDelegate.removeListener(_routerListen);
      }
      if (widget.router != null) {
        widget.router!.routerDelegate.addListener(_routerListen);
      }
    }
  }

  void _routerListen() {
    final path = routeKey;
    if (path.startsWith(widget.rootRouterPath)) {
      if (activeKeyList.isEmpty || activeKeyList.last != path) {
        setState(() {
          setActiveKey(path);
        });
      }
    }
  }

  /// 设置激活的菜单key
  void setActiveKey(String key) {
    activeKeyList = _getKeys(widget.menuList, key, []).$2;
  }

  /// 使用递归找到当前 key，并返回完整的的菜单层级链
  (bool, List<String>) _getKeys(
    List<ElMenuModel> menuList,
    String key,
    List<String> parent,
  ) {
    bool flag = false;
    for (final $menu in menuList) {
      if ($menu.children.isEmpty) {
        if ($menu.key == key) {
          parent.add($menu.key);
          flag = true;
          break;
        } else if ($menu == menuList.last) {
          parent.removeLast();
        }
      } else {
        parent.add($menu.key);
        final result = _getKeys($menu.children, key, parent);
        if (result.$1) {
          flag = true;
          break;
        }
      }
    }
    return (flag, parent);
  }

  @override
  Widget build(BuildContext context) {
    final $bgColor = widget.bgColor ?? context.elTheme.asideBgColor;
    if (widget.router == null) setActiveKey(widget.activeKey!);
    return Material(
      color: $bgColor,
      child: SizedBox(
        width: widget.width,
        height: double.infinity,
        child: _ElMenuData(
          activeKeyList: activeKeyList,
          bgColor: $bgColor,
          iconSize: widget.iconSize,
          gap: widget.gap,
          router: widget.router,
          onChange: widget.onChange,
          child: SingleChildScrollView(
            child: _Menu(widget.menuList, widget.gap),
          ),
        ),
      ),
    );
  }
}
