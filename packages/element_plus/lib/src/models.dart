import 'package:flutter/widgets.dart';

class ElMenuModel {
  /// 菜单唯一标识
  final String key;

  /// 菜单名字
  final String title;

  /// 菜单图标
  final Widget? icon;

  /// 子菜单
  final List<ElMenuModel> children;

  const ElMenuModel({
    required this.key,
    required this.title,
    this.icon,
    this.children = const [],
  });

  @override
  String toString() {
    return 'ElMenuModel{title: $title, key: $key, icon: $icon, children: $children}';
  }
}
