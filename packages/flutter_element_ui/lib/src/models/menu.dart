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
