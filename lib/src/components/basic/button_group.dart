part of flutter_element_ui;

const String _assertButtonGroupChildrenLength = 'children至少需要两个元素';

enum _ButtonGroupType { base, single, multiple }

abstract class _ButtonGroupData extends InheritedWidget {
  const _ButtonGroupData({
    required super.child,
    required this.buttonGroupType,
    required this.type,
    required this.index,
    required this.indexList,
    required this.onChange,
    required this.onPressed,
    required this.onChangeList,
    required this.onEnterIndex,
    required this.setOnEnterIndex,
  });

  final _ButtonGroupType buttonGroupType;
  final ElThemeType? type;
  final int index;
  final List<int> indexList;
  final ValueSetter<int>? onPressed;
  final ValueSetter<int>? onChange;
  final ValueSetter<List<int>>? onChangeList;
  final int onEnterIndex;
  final void Function(int index) setOnEnterIndex;

  @override
  bool updateShouldNotify(_ButtonGroupData old) {
    return true;
  }
}

class _ElButtonGroupData extends _ButtonGroupData {
  const _ElButtonGroupData({
    required super.child,
    required this.children,
    required super.buttonGroupType,
    required super.type,
    required super.index,
    required super.indexList,
    required super.onChange,
    required super.onPressed,
    required super.onChangeList,
    required super.onEnterIndex,
    required super.setOnEnterIndex,
  });

  final List<ElButtonItem> children;

  static _ElButtonGroupData of(BuildContext context) {
    final _ElButtonGroupData? result = context.dependOnInheritedWidgetOfExactType<_ElButtonGroupData>();
    assert(result != null, 'ElButtonItem必须使用ElButtonGroup包裹');
    return result!;
  }
}

class _ElIconButtonGroupData extends _ButtonGroupData {
  const _ElIconButtonGroupData({
    required super.child,
    required this.children,
    required super.buttonGroupType,
    required super.type,
    required super.index,
    required super.indexList,
    required super.onChange,
    required super.onPressed,
    required super.onChangeList,
    required super.onEnterIndex,
    required super.setOnEnterIndex,
  });

  final List<ElIconButtonItem> children;

  static _ElIconButtonGroupData of(BuildContext context) {
    final _ElIconButtonGroupData? result = context.dependOnInheritedWidgetOfExactType<_ElIconButtonGroupData>();
    assert(result != null, 'ElIconButtonItem必须使用ElIconButtonGroup包裹');
    return result!;
  }
}

abstract class _ButtonGroup extends StatefulWidget {
  const _ButtonGroup({
    super.key,
    this.type,
    this.onPressed,
  })  : _buttonGroupType = _ButtonGroupType.base,
        index = -1,
        indexList = const [],
        onChange = null,
        onChangeList = null;

  const _ButtonGroup.single({
    super.key,
    this.type,
    this.index = -1,
    this.onChange,
  })  : _buttonGroupType = _ButtonGroupType.single,
        indexList = const [],
        onPressed = null,
        onChangeList = null;

  const _ButtonGroup.multiple({
    super.key,
    this.type,
    required this.indexList,
    this.onChangeList,
  })  : _buttonGroupType = _ButtonGroupType.multiple,
        index = -1,
        onPressed = null,
        onChange = null;

  final _ButtonGroupType _buttonGroupType;

  /// 指定按钮组的主题类型，如果是按钮组，[ElButton]的type属性不会生效
  final ElThemeType? type;

  /// 单选模式下绑定选中的索引
  final int index;

  /// 多选模式下绑定选中的索引
  final List<int> indexList;

  /// 普通模式按钮项响应的事件，注意：优先响应[ElButton]的点击事件，如果想要触发此事件，[ElButton]请不要设置onPressed
  final ValueSetter<int>? onPressed;

  /// 单选模式更新事件，注意：优先响应[ElButton]的点击事件，如果想要触发此事件，[ElButton]请不要设置onPressed
  final ValueSetter<int>? onChange;

  /// 多选模式更新事件，注意：优先响应[ElButton]的点击事件，如果想要触发此事件，[ElButton]请不要设置onPressed
  final ValueSetter<List<int>>? onChangeList;

  @override
  State<_ButtonGroup> createState();
}

abstract class _ButtonGroupState<T extends _ButtonGroup> extends State<T> {
  /// 用户鼠标、手指进入的按钮，效果相当于hover
  int onEnterIndex = 0;

  void setOnEnterIndex(int index) {
    setState(() {
      onEnterIndex = index;
    });
  }
}

/// Element UI 按钮组组件
class ElButtonGroup extends _ButtonGroup {
  /// 普通按钮组
  const ElButtonGroup({
    super.key,
    required this.children,
    super.type,
    super.onPressed,
  }) : assert(children.length >= 2, _assertButtonGroupChildrenLength);

  /// 单选按钮组
  const ElButtonGroup.single({
    super.key,
    required this.children,
    super.type,
    super.index,
    super.onChange,
  })  : assert(children.length >= 2, _assertButtonGroupChildrenLength),
        super.single();

  /// 多选按钮组
  const ElButtonGroup.multiple({
    super.key,
    required this.children,
    super.type,
    required super.indexList,
    super.onChangeList,
  })  : assert(children.length >= 2, _assertButtonGroupChildrenLength),
        super.multiple();

  /// 按钮数组项
  final List<ElButtonItem> children;

  @override
  State<ElButtonGroup> createState() => _ElButtonGroupState();
}

class _ElButtonGroupState extends _ButtonGroupState<ElButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return _ElButtonGroupData(
      buttonGroupType: widget._buttonGroupType,
      children: widget.children,
      type: widget.type,
      index: widget.index,
      indexList: widget.indexList,
      onPressed: widget.onPressed,
      onChange: widget.onChange,
      onChangeList: widget.onChangeList,
      onEnterIndex: onEnterIndex,
      setOnEnterIndex: setOnEnterIndex,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.children,
      ),
    );
  }
}

/// Element Icon按钮组
class ElIconButtonGroup extends _ButtonGroup {
  /// 普通图标按钮组
  const ElIconButtonGroup({
    super.key,
    required this.children,
    super.type,
    super.onPressed,
  }) : assert(children.length >= 2, _assertButtonGroupChildrenLength);

  /// 单选图标按钮组
  const ElIconButtonGroup.single({
    super.key,
    required this.children,
    super.type,
    super.index,
    super.onChange,
  })  : assert(children.length >= 2, _assertButtonGroupChildrenLength),
        super.single();

  /// 多选图标按钮组
  const ElIconButtonGroup.multiple({
    super.key,
    required this.children,
    super.type,
    required super.indexList,
    super.onChangeList,
  })  : assert(children.length >= 2, _assertButtonGroupChildrenLength),
        super.multiple();

  /// icon按钮数组项
  final List<ElIconButtonItem> children;

  @override
  State<ElIconButtonGroup> createState() => _ElIconButtonGroupState();
}

class _ElIconButtonGroupState extends _ButtonGroupState<ElIconButtonGroup> {
  @override
  Widget build(BuildContext context) {
    return _ElIconButtonGroupData(
      buttonGroupType: widget._buttonGroupType,
      children: widget.children,
      type: widget.type,
      index: widget.index,
      indexList: widget.indexList,
      onPressed: widget.onPressed,
      onChange: widget.onChange,
      onChangeList: widget.onChangeList,
      onEnterIndex: onEnterIndex,
      setOnEnterIndex: setOnEnterIndex,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widget.children,
      ),
    );
  }
}
