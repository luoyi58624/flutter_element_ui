part of flutter_element_ui;

enum _ButtonGroupType { base, single, multiple }

class _ElButtonGroupData extends InheritedWidget {
  const _ElButtonGroupData({
    required super.child,
    required this.buttonGroupType,
    required this.children,
    required this.index,
    required this.indexList,
    required this.onChange,
    required this.onChangeList,
    required this.color,
  });

  final _ButtonGroupType buttonGroupType;

  /// [ElButton]数组
  final List<ElButton> children;

  /// 单选模式下绑定选中的索引
  final int index;

  /// 多选模式下绑定选中的索引
  final List<int> indexList;

  /// 单选模式更新事件
  final ValueSetter<int>? onChange;

  /// 多选模式更新事件
  final ValueSetter<List<int>>? onChangeList;

  /// 单选、多选按钮组的选中的主题颜色，默认primary
  final Color? color;

  static _ElButtonGroupData? of(BuildContext context) {
    final _ElButtonGroupData? result = context.dependOnInheritedWidgetOfExactType<_ElButtonGroupData>();
    return result;
  }

  @override
  bool updateShouldNotify(_ElButtonGroupData old) {
    return true;
  }
}

class ElButtonGroup extends StatefulWidget {
  /// 普通按钮组，不包含选中状态
  const ElButtonGroup({
    super.key,
    required this.children,
  })  : _buttonGroupType = _ButtonGroupType.base,
        index = -1,
        indexList = const [],
        onChange = null,
        onChangeList = null,
        color = null;

  /// 单选按钮组，注意：[ElButton]的type将不生效
  const ElButtonGroup.single({
    super.key,
    required this.children,
    this.index = -1,
    this.onChange,
    this.color,
  })  : _buttonGroupType = _ButtonGroupType.single,
        indexList = const [],
        onChangeList = null;

  /// 多选按钮组，注意：[ElButton]的type将不生效
  const ElButtonGroup.multiple({
    super.key,
    required this.children,
    required this.indexList,
    this.onChangeList,
    this.color,
  })  : _buttonGroupType = _ButtonGroupType.multiple,
        index = -1,
        onChange = null;

  final _ButtonGroupType _buttonGroupType;

  /// [ElButton]数组，必须至少两个元素
  final List<ElButton> children;

  /// 单选模式下绑定选中的索引
  final int index;

  /// 多选模式下绑定选中的索引
  final List<int> indexList;

  /// 单选模式更新事件
  final ValueSetter<int>? onChange;

  /// 多选模式更新事件
  final ValueSetter<List<int>>? onChangeList;

  /// 单选、多选按钮组的选中的主题颜色，默认primary
  final Color? color;

  @override
  State<ElButtonGroup> createState() => _ElButtonGroupState();
}

class _ElButtonGroupState extends State<ElButtonGroup> {
  @override
  Widget build(BuildContext context) {
    assert(widget.children.length >= 2, 'children至少需要两个元素');
    return _ElButtonGroupData(
      buttonGroupType: widget._buttonGroupType,
      children: widget.children,
      index: widget.index,
      indexList: widget.indexList,
      onChange: widget.onChange,
      onChangeList: widget.onChangeList,
      color: widget.color ?? ElApp.of(context).theme.primary,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.children,
      ),
    );
  }
}
