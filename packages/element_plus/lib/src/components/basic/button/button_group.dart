part of 'index.dart';

class ElButtonGroup extends StatelessWidget {
  /// Element UI 按钮组
  const ElButtonGroup(
    this.modelValue, {
    super.key,
    required this.children,
    this.type,
    this.axis = Axis.horizontal,
    this.onChanged,
  });

  /// 由于 Dart 不支持联合类型，所以在这里说明一下 [modelValue] 支持的类型：
  /// * null 按钮组无需选中状态
  /// * int || ValueNotifier<int> 选中的按钮索引，支持双向绑定
  /// * List<int> || ValueNotifier<List<int>> 选中多个按钮
  final dynamic modelValue;

  /// 按钮集合
  final List<ElButton> children;

  /// 主题类型，它会覆写 [ElButton] 的主题类型
  final String? type;

  /// 按钮组方向
  final Axis axis;

  /// 更新事件，建议使用双向绑定的方式更新数据
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    ElAssert.themeType(type, 'ElButtonGroup');
    final $children = children
        .mapIndexed(
          (i, e) => ChildIndexData(
            length: children.length,
            index: i,
            child: e,
          ),
        )
        .toList();
    late Widget result;
    if (axis == Axis.horizontal) {
      result = Row(
        children: $children,
      );
    } else {
      result = Column(
        children: $children,
      );
    }
    return _ElButtonGroupInheritedWidget(
      modelValue,
      type,
      axis,
      onChanged,
      child: result,
    );
  }
}

class _ElButtonGroupInheritedWidget extends InheritedWidget {
  const _ElButtonGroupInheritedWidget(
    this.modelValue,
    this.type,
    this.axis,
    this.onChanged, {
    required super.child,
  });

  final dynamic modelValue;
  final String? type;
  final Axis axis;
  final ValueChanged? onChanged;

  static _ElButtonGroupInheritedWidget? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElButtonGroupInheritedWidget>();

  @override
  bool updateShouldNotify(_ElButtonGroupInheritedWidget oldWidget) => true;
}
