import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/theme.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../utils/icons.dart';
import '../basic/icon.dart';
import '../basic/typography.dart';

/// 嵌套子菜单距离上一层级的间距
const double _defaultGap = 22;

class ElMenuModel {
  /// 菜单名字
  String title;

  /// 菜单图标
  dynamic icon;

  /// 菜单对应的路由地址
  String? path;

  /// 子菜单
  List<ElMenuModel>? children;

  ElMenuModel({
    required this.title,
    this.icon,
    this.path,
    this.children,
  });
}

class _ElMenuData extends InheritedWidget {
  const _ElMenuData({
    required super.child,
    required this.background,
    required this.activePath,
    required this.collapse,
    required this.iconSize,
    required this.collapseDuration,
    required this.expandDuration,
    required this.onChange,
  });

  final Color background;
  final String? activePath;
  final bool collapse;
  final double iconSize;
  final int collapseDuration;
  final int expandDuration;
  final void Function(ElMenuModel menu)? onChange;

  static _ElMenuData of(BuildContext context) {
    final _ElMenuData? result =
        context.dependOnInheritedWidgetOfExactType<_ElMenuData>();
    return result!;
  }

  @override
  bool updateShouldNotify(_ElMenuData old) {
    return true;
  }
}

/// Element UI 导航菜单组件
class ElMenu extends StatefulWidget {
  const ElMenu(
    this.menuList, {
    super.key,
    this.width = 240,
    this.background,
    this.activePath,
    this.collapse = false,
    this.iconSize = 20,
    this.collapseDuration = 250,
    this.expandDuration = 250,
    this.onChange,
  });

  final List<ElMenuModel> menuList;

  /// 菜单栏宽度
  final double width;

  /// 菜单栏背景颜色，默认跟随侧边栏背景色
  final Color? background;

  /// 激活的路由地址
  final String? activePath;

  /// 是否收起菜单
  final bool collapse;

  /// 菜单图标大小，默认20
  final double iconSize;

  /// 收起菜单动画过渡时间，单位：毫秒
  final int collapseDuration;

  /// 菜单折叠动画过渡时间，单位：毫秒
  final int expandDuration;

  final void Function(ElMenuModel menu)? onChange;

  @override
  State<ElMenu> createState() => _ElMenuState();
}

class _ElMenuState extends State<ElMenu> {
  Color get background => widget.background ?? context.elTheme.asideBgColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: widget.collapseDuration),
      curve: Curves.linear,
      width: widget.collapse ? _defaultGap * 2 + widget.iconSize : widget.width,
      height: double.infinity,
      child: _ElMenuData(
        background: background,
        activePath: widget.activePath,
        collapse: widget.collapse,
        iconSize: widget.iconSize,
        collapseDuration: widget.collapseDuration,
        expandDuration: widget.expandDuration,
        onChange: widget.onChange,
        child: SingleChildScrollView(
          child: _MenuWidget(
            menuList: widget.menuList,
            gap: _defaultGap,
          ),
        ),
      ),
    );
  }
}

class _MenuWidget extends StatefulWidget {
  const _MenuWidget({
    required this.menuList,
    required this.gap,
  });

  final List<ElMenuModel> menuList;

  /// 间距，每展开一层，子元素的间距越深
  final double gap;

  @override
  State<_MenuWidget> createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<_MenuWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.menuList
          .map(
            (e) => _MenuItemWidget(
              menuItem: e,
              gap: widget.gap,
            ),
          )
          .toList(),
    );
  }
}

class _MenuItemWidget extends StatefulWidget {
  const _MenuItemWidget({
    required this.menuItem,
    required this.gap,
  });

  final ElMenuModel menuItem;
  final double gap;

  @override
  State<_MenuItemWidget> createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<_MenuItemWidget> {
  bool _expand = false;

  bool get hasChild =>
      widget.menuItem.children != null && widget.menuItem.children!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            if (hasChild) {
              setState(() {
                _expand = !_expand;
              });
            } else {
              if (_ElMenuData.of(context).onChange != null) {
                _ElMenuData.of(context).onChange!(widget.menuItem);
              }
            }
          },
          child: _MenuItemContentWidget(
            menuItem: widget.menuItem,
            hasChild: hasChild,
            expand: _expand,
            gap: widget.gap,
          ),
        ),
        if (hasChild && !_ElMenuData.of(context).collapse) buildChildMenu()
      ],
    );
  }

  Widget buildChildMenu() {
    return AnimatedCrossFade(
      firstChild: const SizedBox(width: 0, height: 0),
      secondChild: _MenuWidget(
        menuList: widget.menuItem.children!,
        gap: widget.gap + _defaultGap,
      ),
      firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
      secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
      sizeCurve: Curves.fastOutSlowIn,
      crossFadeState:
          _expand ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: Duration(milliseconds: _ElMenuData.of(context).expandDuration),
    );
  }
}

class _MenuItemContentWidget extends StatefulWidget {
  const _MenuItemContentWidget({
    required this.menuItem,
    required this.hasChild,
    required this.expand,
    required this.gap,
  });

  final ElMenuModel menuItem;
  final bool hasChild;
  final bool expand;
  final double gap;

  @override
  State<_MenuItemContentWidget> createState() => _MenuItemContentWidgetState();
}

class _MenuItemContentWidgetState extends State<_MenuItemContentWidget> {
  Color get parentBgColor => _ElMenuData.of(context).background;

  String? get activePath => _ElMenuData.of(context).activePath;

  String? get currentPath => widget.menuItem.path;

  Color get _textColor => parentBgColor.isDark
      ? context.darkTheme.textColor
      : context.theme.textColor;

  Color get menuItemColor {
    if (currentPath == '/') {
      return activePath == '/' ? context.elTheme.menuActiveColor : _textColor;
    } else {
      if (activePath != null &&
          currentPath != null &&
          activePath!.contains(currentPath!)) {
        return context.elTheme.menuActiveColor;
      }
    }
    return _textColor;
  }

  Color get hoverColor => parentBgColor.hsp < 50
      ? parentBgColor.brighten(15)
      : parentBgColor.darken(15);

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      builder: (isHover) => AnimatedContainer(
        duration: Duration(milliseconds: context.elConfig.bgColorTransition),
        curve: Curves.easeOut,
        height: 56,
        padding: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isHover ? hoverColor : parentBgColor,
        ),
        child: Row(
          children: [
            SizedBox(width: widget.gap),
            if (widget.menuItem.icon != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ElIcon(
                  widget.menuItem.icon!,
                  color: menuItemColor,
                  size: _ElMenuData.of(context).iconSize,
                ),
              ),
            if (!_ElMenuData.of(context).collapse)
              Expanded(
                child: ElText(
                  widget.menuItem.title,
                  style: TextStyle(
                    color: menuItemColor,
                    fontSize: 14,
                  ),
                  // maxLines: 1,
                  // overflow: TextOverflow.clip,
                ),
              ),
            if (widget.hasChild && !_ElMenuData.of(context).collapse)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 40,
                  margin: const EdgeInsets.only(left: 8),
                  child: AnimatedRotation(
                    duration: Duration(
                        milliseconds: max(
                            _ElMenuData.of(context).expandDuration - 50, 0)),
                    turns: widget.expand ? 0.5 : 0,
                    child: ElIcon(
                      ElIcons.arrowDown,
                      color: menuItemColor,
                      size: 12,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// 收缩状态下的菜单
class _CollapseMenuWidget extends StatefulWidget {
  const _CollapseMenuWidget();

  @override
  State<_CollapseMenuWidget> createState() => _CollapseMenuWidgetState();
}

class _CollapseMenuWidgetState extends State<_CollapseMenuWidget> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [],
    );
  }
}
