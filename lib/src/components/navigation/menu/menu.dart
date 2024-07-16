import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/extensions/color.dart';
import 'package:go_router/go_router.dart';

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
    this.collapse = false,
    this.iconSize = 20,
    this.onChange,
  })  : assert(activeKey != null),
        router = null,
        rootRouterPath = '/';

  /// 创建路由菜单导航，注意：ElMenu 只支持官方实现的声明式路由[go_router]
  const ElMenu.router(
    this.menuList, {
    super.key,
    required this.router,
    this.rootRouterPath = '/',
    this.width = 240,
    this.collapseWidth = 64,
    this.gap = 20,
    this.bgColor,
    this.collapse = false,
    this.iconSize = 20,
  })  : assert(router != null),
        assert(rootRouterPath != ''),
        activeKey = null,
        onChange = null;

  /// 菜单模型集合
  final List<ElMenuModel> menuList;

  /// 启用路由模式，接收路由实例对象，内部将监听 url 的变化
  final GoRouter? router;

  /// 当前菜单支持的根路由地址，如果当前路由菜单属于某个路由的子级，设置它可以缩小监听的范围
  final String rootRouterPath;

  /// 激活的菜单key
  final String? activeKey;

  /// 菜单栏宽度
  final double width;

  /// 菜单收起宽度
  final double collapseWidth;

  /// 嵌套子菜单距离上一层级的间距
  final double gap;

  /// 菜单栏背景颜色，默认跟随侧边栏背景色
  final Color? bgColor;

  /// 是否收起菜单
  final bool collapse;

  /// 菜单图标大小，默认20
  final double iconSize;

  final void Function(ElMenuModel menu)? onChange;

  @override
  State<ElMenu> createState() => _ElMenuState();
}

class _ElMenuState extends State<ElMenu> {
  /// 激活的菜单层级链
  List<String> activeKeyList = [];

  /// 以路由地址作为菜单key
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
      if (activeKeyList.last != path) {
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

  (bool, List<String>) _getKeys(
      List<ElMenuModel> list, String key, List<String> parent) {
    bool flag = false;
    for (final $menu in list) {
      if ($menu.children.isEmpty) {
        if ($menu.key == key) {
          parent.add($menu.key);
          flag = true;
          break;
        } else if ($menu == list.last) {
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
    return AnimatedColoredBox(
      duration: Duration(milliseconds: context.elConfig.bgTransition),
      color: $bgColor,
      child: AnimatedContainer(
        duration: Duration(milliseconds: context.elConfig.collapseDuration),
        curve: Curves.linear,
        width:
            widget.collapse ? widget.gap * 2 + widget.iconSize : widget.width,
        height: double.infinity,
        child: _ElMenuData(
          activeKeyList: activeKeyList,
          router: widget.router,
          bgColor: $bgColor,
          collapse: widget.collapse,
          iconSize: widget.iconSize,
          gap: widget.gap,
          onChange: widget.onChange,
          child: SingleChildScrollView(
            child: _Menu(widget.menuList, widget.gap),
          ),
        ),
      ),
    );
  }
}
