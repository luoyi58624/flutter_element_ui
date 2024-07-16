part of 'menu.dart';

class ElMenuModel {
  /// 菜单名字
  final String title;

  /// 菜单唯一标识，如果是路由菜单，key将为跳转地址
  final String key;

  /// 菜单图标
  final dynamic icon;

  /// 子菜单
  final List<ElMenuModel> children;

  const ElMenuModel({
    required this.title,
    required this.key,
    this.icon,
    this.children = const [],
  });

  @override
  String toString() {
    return 'ElMenuModel{title: $title, key: $key, icon: $icon, children: $children}';
  }
}

class _ElMenuData extends InheritedWidget {
  const _ElMenuData({
    required super.child,
    required this.activeKeyList,
    required this.router,
    required this.bgColor,
    required this.collapse,
    required this.iconSize,
    required this.gap,
    required this.onChange,
  });

  final List<String> activeKeyList;
  final GoRouter? router;
  final Color bgColor;
  final bool collapse;
  final double iconSize;

  /// 默认的 gap 间距
  final double gap;

  final void Function(ElMenuModel menu)? onChange;

  static _ElMenuData of(BuildContext context) {
    final _ElMenuData? result =
        context.dependOnInheritedWidgetOfExactType<_ElMenuData>();
    return result!;
  }

  @override
  bool updateShouldNotify(_ElMenuData old) => false;
}
