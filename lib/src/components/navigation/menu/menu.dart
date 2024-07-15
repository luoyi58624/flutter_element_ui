import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';
import 'package:flutter_element_ui/src/extensions/color.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

part 'menu_modal.dart';

part 'menu_widget.dart';

class ElMenu extends StatelessWidget {
  const ElMenu(
    this.menuList, {
    super.key,
    this.width = 240,
    this.collapseWidth = 64,
    this.gap = 20,
    this.bgColor,
    this.activePath,
    this.collapse = false,
    this.iconSize = 20,
    this.onChange,
  });

  final List<ElMenuModel> menuList;

  /// 菜单栏宽度
  final double width;

  /// 菜单收起宽度
  final double collapseWidth;

  /// 嵌套子菜单距离上一层级的间距
  final double gap;

  /// 菜单栏背景颜色，默认跟随侧边栏背景色
  final Color? bgColor;

  /// 激活的路由地址
  final String? activePath;

  /// 是否收起菜单
  final bool collapse;

  /// 菜单图标大小，默认20
  final double iconSize;

  final void Function(ElMenuModel menu)? onChange;

  @override
  Widget build(BuildContext context) {
    final $bgColor = bgColor ?? context.elTheme.asideBgColor;
    return AnimatedColoredBox(
      duration: Duration(milliseconds: context.elConfig.bgTransition),
      color: $bgColor,
      child: AnimatedContainer(
        duration: Duration(milliseconds: context.elConfig.collapseDuration),
        curve: Curves.linear,
        width: collapse ? gap * 2 + iconSize : width,
        height: double.infinity,
        child: _ElMenuData(
          activePath: activePath,
          bgColor: $bgColor,
          collapse: collapse,
          iconSize: iconSize,
          gap: gap,
          onChange: onChange,
          child: SingleChildScrollView(
            child: _Menu(menuList, gap),
          ),
        ),
      ),
    );
  }
}
