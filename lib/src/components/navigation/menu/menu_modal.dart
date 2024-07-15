part of 'menu.dart';

class ElMenuModel {
  /// 菜单名字
  String title;

  /// 菜单图标
  dynamic icon;

  /// 菜单对应的路由地址
  String? path;

  /// 控制菜单项折叠状态，折叠状态不应由控件内部去维护，因为当收缩[Drawer]、
  /// 响应式缩放均会导致状态丢失
  ValueNotifier<bool>? collapse;

  /// 子菜单
  List<ElMenuModel>? children;

  ElMenuModel({
    required this.title,
    this.icon,
    this.path,
    this.collapse,
    this.children,
  });
}

class _ElMenuData extends InheritedWidget {
  const _ElMenuData({
    required super.child,
    required this.activePath,
    required this.bgColor,
    required this.collapse,
    required this.iconSize,
    required this.gap,
    required this.onChange,
  });

  final String? activePath;
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
