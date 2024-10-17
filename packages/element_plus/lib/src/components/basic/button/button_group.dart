part of 'index.dart';

class ElButtonGroup extends StatefulWidget {
  /// Element UI 按钮组
  const ElButtonGroup(
    this.modelValue, {
    super.key,
    required this.children,
    this.type,
    this.axis = Axis.horizontal,
    this.mandatory = false,
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

  /// 是否必须强制选择一个值，默认 false
  final bool mandatory;

  /// 更新事件，建议使用双向绑定的方式更新数据
  final ValueChanged? onChanged;

  @override
  State<ElButtonGroup> createState() => _ElButtonGroupState();
}

class _ElButtonGroupState extends State<ElButtonGroup> {
  int hoverIndex = 0;

  void setHoverIndex(int index) {
    if (hoverIndex != index) {
      setState(() {
        hoverIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ElAssert.themeType(widget.type, 'ElButtonGroup');
    final $children = widget.children
        .mapIndexed(
          (i, e) => ChildIndexData(
            length: widget.children.length,
            index: i,
            child: e,
          ),
        )
        .toList();
    late Widget result;
    if (widget.axis == Axis.horizontal) {
      result = Row(
        children: $children,
      );
    } else {
      result = Column(
        children: $children,
      );
    }
    return _ElButtonGroupInheritedWidget(
      modelValue: widget.modelValue,
      type: widget.type,
      axis: widget.axis,
      hoverIndex: hoverIndex,
      setHoverIndex: setHoverIndex,
      onChanged: widget.onChanged,
      child: result,
    );
  }
}

class _ElButtonGroupInheritedWidget extends InheritedWidget {
  const _ElButtonGroupInheritedWidget({
    required this.modelValue,
    required this.type,
    required this.axis,
    required this.hoverIndex,
    required this.setHoverIndex,
    required this.onChanged,
    required super.child,
  });

  final dynamic modelValue;
  final String? type;
  final Axis axis;
  final int hoverIndex;
  final void Function(int index) setHoverIndex;
  final ValueChanged? onChanged;

  static _ElButtonGroupInheritedWidget? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElButtonGroupInheritedWidget>();

  @override
  bool updateShouldNotify(_ElButtonGroupInheritedWidget oldWidget) => true;
}
