part of 'index.dart';

enum _ButtonGroupType {
  none,
  single,
  multi,
}

class _ElButtonGroupInheritedWidget extends InheritedWidget {
  const _ElButtonGroupInheritedWidget({
    required this.type,
    required this.modelValue,
    required this.axis,
    required this.hoverIndex,
    required this.activeIndex,
    required this.divideColor,
    required this.dividePositionList,
    required this.onChanged,
    required super.child,
  });

  final _ButtonGroupType type;
  final dynamic modelValue;
  final Axis axis;
  final Obs<int> hoverIndex;
  final Obs<int> activeIndex;
  final Obs<Color?> divideColor;
  final Obs<List<double>> dividePositionList;
  final ValueChanged onChanged;

  static _ElButtonGroupInheritedWidget? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElButtonGroupInheritedWidget>();

  @override
  bool updateShouldNotify(_ElButtonGroupInheritedWidget oldWidget) => true;
}

class ElButtonGroup extends StatefulWidget {
  /// Element UI 按钮组
  const ElButtonGroup({
    super.key,
    required this.children,
    this.axis = Axis.horizontal,
  })  : _type = _ButtonGroupType.none,
        modelValue = null,
        mandatory = false,
        onChanged = null;

  /// Element UI 单选按钮组，[modelValue] 支持 [int]、[ValueNotifier] 类型
  ElButtonGroup.single(
    this.modelValue, {
    super.key,
    required this.children,
    this.axis = Axis.horizontal,
    this.mandatory = false,
    this.onChanged,
  })  : _type = _ButtonGroupType.single,
        assert(() {
          if ((modelValue is int? ||
                  modelValue is int ||
                  modelValue is ValueNotifier<int?> ||
                  modelValue is ValueNotifier<int>) ==
              false) {
            throw 'ElButtonGroup.single 单选按钮组 modelValue 类型错误，参数类型必须明确指定 int 或者 int? 类型';
          }
          return true;
        }());

  /// Element UI 多选按钮组，[modelValue] 支持 [List]、[ValueNotifier] 类型
  ElButtonGroup.multi(
    this.modelValue, {
    super.key,
    required this.children,
    this.axis = Axis.horizontal,
    this.mandatory = false,
    this.onChanged,
  })  : _type = _ButtonGroupType.multi,
        assert(() {
          if ((modelValue is List<int> ||
                  modelValue is ValueNotifier<List<int>>) ==
              false) {
            throw 'ElButtonGroup.multi 多选按钮组 modelValue 类型错误，参数类型必须明确指定为 List<int>';
          }
          return true;
        }());

  /// 按钮组类型
  final _ButtonGroupType _type;

  /// 按钮组绑定选中的值
  final dynamic modelValue;

  /// 按钮集合
  final List<ElButton> children;

  /// 按钮组方向
  final Axis axis;

  /// 当选中的值只剩一个时，是否固定它，默认 false
  final bool mandatory;

  /// 更新事件
  final ValueChanged? onChanged;

  @override
  State<ElButtonGroup> createState() => _ElButtonGroupState();
}

class _ElButtonGroupState extends State<ElButtonGroup> {
  /// 当前鼠标悬停的按钮
  final _hoverIndex = Obs(-1);

  /// 当前鼠标激活的按钮
  final _activeIndex = Obs(-1);

  /// 按钮组分割线颜色，它的颜色会和按钮边框同步
  final _divideColor = Obs<Color?>(null);

  /// 需要绘制分割线的按钮 key 列表，当构建完成按钮组后，会在下一帧通过这些 key 计算每个分割线的位置
  List<GlobalKey> _childrenKeyList = [];

  /// 按钮组分割线的偏移位置，分割线是通过 Stack 布局绘制上去的，为的就是分割线不占用按钮空间
  final _dividePositionList = Obs<List<double>>([]);

  get _modelValue => widget.modelValue is ValueNotifier
      ? (widget.modelValue as ValueNotifier).value
      : widget.modelValue;

  bool get _hasSelected => _modelValue is List
      ? (_modelValue as List).isNotEmpty
      : _modelValue != null;

  @override
  void initState() {
    super.initState();
    _setChildrenKeyList(widget.children.length);
  }

  @override
  void didUpdateWidget(covariant ElButtonGroup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.children.length != oldWidget.children.length) {
      _setChildrenKeyList(widget.children.length);
    }
  }

  void _setChildrenKeyList(int length) {
    if (length <= 1) {
      _childrenKeyList.clear();
    } else {
      _childrenKeyList =
          List.generate(widget.children.length - 1, (i) => GlobalKey())
              .toList();
    }
  }

  /// 计算按钮组选中逻辑
  void _onChange(dynamic value) {
    if (widget._type == _ButtonGroupType.none) return;

    dynamic $modelValue = widget.modelValue;
    dynamic $value;

    if (widget.modelValue is ValueNotifier) {
      $modelValue = (widget.modelValue as ValueNotifier).value;
    }

    if ($modelValue is int) {
      if ($modelValue == value) {
        if (widget.mandatory == false) {
          $value = -1;
        }
      } else {
        $value = value;
      }
    } else if ($modelValue is List) {
      final list = List<int>.from($modelValue);
      if (list.contains(value)) {
        if (list.length == 1) {
          if (widget.mandatory == false) {
            list.clear();
          }
        } else {
          list.remove(value);
        }
      } else {
        list.add(value);
      }
      $value = list;
    } else {
      return;
    }

    if ($value != null) {
      if (widget.modelValue is ValueNotifier) {
        (widget.modelValue as ValueNotifier).value = $value;
      }

      if (widget.onChanged != null) widget.onChanged!($value);
    }
  }

  /// 更新分割线的位置，只有当分割线位置明确发生变化时才更新它们
  void _updateDivideOffset() {
    nextTick(() {
      List<double> $list = [];
      for (int i = 0; i < _childrenKeyList.length; i++) {
        final offset = _childrenKeyList[i].currentContext!.getOffset(context);
        $list.add(widget.axis == Axis.horizontal ? offset.dx : offset.dy);
      }
      if (_dividePositionList.value.eq($list) == false) {
        _dividePositionList.value = $list;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final $data = ElButtonTheme.of(context);
    ElAssert.themeType($data.type, 'ElButtonGroup');
    List<Widget> $children = [];

    int $length = widget.children.length;
    for (int i = 0; i < $length; i++) {
      Widget itemWidget = ElChildIndex(
        length: $length,
        index: i,
        child: widget.children[i],
      );

      int? flex = widget.children[i].flex;
      if (flex == null || flex < 1) flex = 1;
      if ($data.block == true) {
        if (widget.children[i].block == null) {
          itemWidget = Expanded(flex: flex, child: itemWidget);
        } else {
          if (widget.children[i].block != false) {
            itemWidget = Expanded(flex: flex, child: itemWidget);
          }
        }
      } else {
        if (widget.children[i].block == true) {
          itemWidget = Expanded(flex: flex, child: itemWidget);
        }
      }
      $children.add(itemWidget);
    }

    if ($length > 1 && $data.text != true) {
      $children = [
        $children.first,
        ...$children.sublist(1).mapIndexed((i, e) {
          return Builder(
            key: _childrenKeyList[i],
            builder: (context) => e,
          );
        }),
      ];
      _updateDivideOffset();
    }

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
      type: widget._type,
      modelValue: _modelValue,
      axis: widget.axis,
      hoverIndex: _hoverIndex,
      activeIndex: _activeIndex,
      divideColor: _divideColor,
      dividePositionList: _dividePositionList,
      onChanged: _onChange,
      child: ObsBuilder(builder: (context) {
        return Stack(
          children: [
            result,
            ..._childrenKeyList.mapIndexed(
              (i, e) => _GroupDivide(
                length: $length,
                index: i,
                hasSelected: _hasSelected,
              ),
            ),
          ],
        );
      }),
    );
  }
}

/// 按钮组分割线
class _GroupDivide extends StatelessWidget {
  const _GroupDivide({
    required this.length,
    required this.index,
    required this.hasSelected,
  });

  /// 按钮组的按钮数量
  final int length;

  /// 当前分割线的索引位置
  final int index;

  /// 存在选中的按钮
  final bool hasSelected;

  /// 将指定的索引与当前索引进行匹配
  bool matchIndex(int? targetIndex) {
    if (targetIndex == null) return false;
    if (length == 2) {
      if (targetIndex != -1) return true;
    } else if (length > 2) {
      if (targetIndex == 0) {
        if (index == targetIndex) return true;
      } else if (targetIndex == length - 1) {
        if (index == targetIndex - 1) return true;
      } else if (targetIndex != -1) {
        if (index == targetIndex - 1 || index == targetIndex) {
          return true;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final $data = ElButtonTheme.of(context);
    final $groupData = _ElButtonGroupInheritedWidget.maybeOf(context)!;

    Color $defaultColor = _ButtonColors.button(context).borderColor!;
    Color? $hoverColor;
    Color? $activeColor;
    Color? $selectedColor;

    final $height = $data.height ?? context.elConfig.size;

    if ($data.type == null && $data.bgColor == null) {
      $hoverColor = _ButtonColors.buttonHover(context).borderColor!;
      $activeColor = _ButtonColors.buttonActive(context).borderColor!;
      $selectedColor =
          _ButtonGroupColors.defaultButtonSelected(context).borderColor!;
    } else {
      final $themeColor = $data.bgColor ?? context.elThemeColors[$data.type]!;
      if ($data.plain == true) {
        $defaultColor = _ButtonColors.plainButton(
          context,
          type: $data.type,
          bgColor: $data.bgColor,
        ).borderColor!;
        $hoverColor = _ButtonColors.plainButtonHover(
          context,
          type: $data.type,
          bgColor: $data.bgColor,
        ).borderColor!;
        $activeColor = _ButtonColors.plainButtonActive(
          context,
          type: $data.type,
          bgColor: $data.bgColor,
        ).borderColor!;
      } else {
        $defaultColor = $themeColor.mix(context.lightTheme.bgColor, 50);
      }
    }

    return ObsBuilder(builder: (context) {
      final $dividePositionList = $groupData.dividePositionList.value;
      if ($dividePositionList.length != length - 1) return const SizedBox();

      final $hoverIndex = $groupData.hoverIndex.value;
      final $activeIndex = $groupData.activeIndex.value;
      bool $isHover = false;
      bool $isTap = false;
      bool $isSelected = false;
      Color? $color;
      Color? $$selectedColor;

      if (hasSelected) {
        if ($groupData.type == _ButtonGroupType.single) {
          if (matchIndex($groupData.modelValue)) {
            $$selectedColor = $selectedColor;
            $isSelected = true;
          }
        } else {
          for (int i in $groupData.modelValue as List<int>) {
            if (matchIndex(i)) {
              $$selectedColor = $selectedColor;
              $isSelected = true;
              break;
            }
          }
        }
      }

      if ($activeIndex != -1) {
        if (matchIndex($activeIndex)) {
          $color = $activeColor;
          $isTap = true;
        }
      } else if ($hoverIndex != -1) {
        if (matchIndex($hoverIndex)) {
          $color = $hoverColor;
          $isHover = true;
        }
      }

      final double $width =
          ($data.borderBuilder ?? _ButtonProp.defaultBorderBuilder)(
        ElButtonBorderState(
          isActive: $isHover || $isTap || $isSelected,
        ),
      ).maxWidth;

      return Positioned(
        left: $dividePositionList[index],
        child: IgnorePointer(
          child: AnimatedContainer(
            duration: context.elDuration(_duration),
            width: $width,
            height: $height,
            color: $$selectedColor ?? $color ?? $defaultColor,
          ),
        ),
      );
    });
  }
}