part of flutter_element_ui;

enum _ButtonGroupType { base, single, multiple }

class _ElButtonGroupData extends InheritedWidget {
  const _ElButtonGroupData({
    required super.child,
    required this.buttonGroupType,
    required this.children,
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
  final List<ElButton> children;
  final ElThemeType? type;
  final int index;
  final List<int> indexList;
  final ValueSetter<int>? onPressed;
  final ValueSetter<int>? onChange;
  final ValueSetter<List<int>>? onChangeList;
  final int onEnterIndex;
  final void Function(int index) setOnEnterIndex;

  static _ElButtonGroupData? of(BuildContext context) {
    final _ElButtonGroupData? result = context.dependOnInheritedWidgetOfExactType<_ElButtonGroupData>();
    return result;
  }

  @override
  bool updateShouldNotify(_ElButtonGroupData old) {
    return true;
  }
}

/// Element UI 按钮组组件
class ElButtonGroup extends StatefulWidget {
  /// 普通按钮组
  const ElButtonGroup({
    super.key,
    required this.children,
    this.type,
    this.onPressed,
  })  : _buttonGroupType = _ButtonGroupType.base,
        index = -1,
        indexList = const [],
        onChange = null,
        onChangeList = null;

  /// 单选按钮组，注意：子[ElButton]的type将不生效
  const ElButtonGroup.single({
    super.key,
    required this.children,
    this.type,
    this.index = -1,
    this.onChange,
  })  : _buttonGroupType = _ButtonGroupType.single,
        indexList = const [],
        onPressed = null,
        onChangeList = null;

  /// 多选按钮组，注意：子[ElButton]的type将不生效
  const ElButtonGroup.multiple({
    super.key,
    required this.children,
    this.type,
    required this.indexList,
    this.onChangeList,
  })  : _buttonGroupType = _ButtonGroupType.multiple,
        index = -1,
        onPressed = null,
        onChange = null;

  final _ButtonGroupType _buttonGroupType;

  /// [ElButton]数组，必须至少两个元素，同时[ElButton]必须设置当前下标key，用于获取自身当前的位置。
  ///
  /// 例：
  /// ```dart
  /// const ElButtonGroup(
  ///   children: [
  ///     ElButton(
  ///       key: ValueKey(0), // 下标位置
  ///       'Previous Page',
  ///       leftIcon: Icons.arrow_back_ios,
  ///     ),
  ///     ElButton(
  ///        key: ValueKey(1),
  ///       'Next Page',
  ///        rightIcon: Icons.arrow_forward_ios,
  ///     ),
  ///   ],
  /// ),
  /// ```
  final List<ElButton> children;

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
  State<ElButtonGroup> createState() => _ElButtonGroupState();
}

class _ElButtonGroupState extends State<ElButtonGroup> {
  /// 用户鼠标、手指进入的按钮，效果相当于hover
  int onEnterIndex = 0;

  void setOnEnterIndex(int index) {
    setState(() {
      onEnterIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(widget.children.length >= 2, 'ElButtonGroup的children至少需要两个元素');
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
