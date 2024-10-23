part of 'index.dart';

class _ElButtonGroupInheritedWidget extends InheritedWidget {
  const _ElButtonGroupInheritedWidget({
    required this.modelValue,
    required this.axis,
    required this.hoverIndex,
    required this.activeIndex,
    required this.divideColor,
    required this.onChanged,
    required super.child,
  });

  final dynamic modelValue;
  final Axis axis;
  final Obs<int> hoverIndex;
  final Obs<int> activeIndex;
  final Obs<Color?> divideColor;
  final ValueChanged onChanged;

  static _ElButtonGroupInheritedWidget? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElButtonGroupInheritedWidget>();

  @override
  bool updateShouldNotify(_ElButtonGroupInheritedWidget oldWidget) => true;
}

class ElButtonGroup extends StatefulWidget {
  /// Element UI 按钮组
  const ElButtonGroup(
    this.modelValue, {
    super.key,
    required this.children,
    this.axis = Axis.horizontal,
    this.mandatory = false,
    this.onChanged,
  });

  /// 支持的类型：
  /// * null 按钮组无需选中状态
  /// * int || ValueNotifier<int> 选中的按钮索引，支持双向绑定
  /// * List<int> || ValueNotifier<List<int>> 选中多个按钮，支持双向绑定
  final dynamic modelValue;

  /// 按钮集合
  final List<ElButton> children;

  /// 按钮组方向
  final Axis axis;

  /// 是否必须选择一个值，默认 false
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

  get _modelValue => widget.modelValue is ValueNotifier
      ? (widget.modelValue as ValueNotifier).value
      : widget.modelValue;

  /// 计算按钮组选中逻辑
  void _onChange(dynamic value) {
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

    if (widget.modelValue is ValueNotifier) {
      (widget.modelValue as ValueNotifier).value = $value;
    }

    if (widget.onChanged != null) widget.onChanged!($value);
  }

  @override
  Widget build(BuildContext context) {
    final $data = ElButtonTheme.of(context);
    ElAssert.themeType($data.type, 'ElButtonGroup');
    final List<Widget> $children = [];
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
      if ($data.text != true && i < $length - 1) {
        $children.add(_GroupDivide(
          length: $length,
          index: i,
        ));
      }
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
      modelValue: _modelValue,
      axis: widget.axis,
      hoverIndex: _hoverIndex,
      activeIndex: _activeIndex,
      divideColor: _divideColor,
      onChanged: _onChange,
      child: result,
    );
  }
}

/// 按钮组分割线
class _GroupDivide extends StatelessWidget {
  const _GroupDivide({
    required this.length,
    required this.index,
  });

  /// 按钮组的按钮数量
  final int length;

  /// 当前分割线的索引位置
  final int index;

  // bool _isActive(int targetIndex) {
  //   int $hoverIndex = hoverIndex.value;
  //   int? activeIndex;
  //   if (_ButtonGroupUtil.isSelected(modelValue, index)) {
  //     activeIndex = index;
  //   }
  //
  //   if ($hoverIndex == targetIndex) {
  //     return true;
  //   }
  //   if (activeIndex != null && activeIndex == targetIndex) {
  //     return true;
  //   }
  //   return false;
  // }

  bool matchIndex(int targetIndex) {
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

  Color? calcIndexColor(int targetIndex, Color? activeColor) {
    if (length == 2) {
      if (targetIndex != -1) return activeColor;
    } else if (length > 2) {
      if (targetIndex == 0) {
        if (index == targetIndex) return activeColor;
      } else if (targetIndex == length - 1) {
        if (index == targetIndex - 1) return activeColor;
      } else if (targetIndex != -1) {
        if (index == targetIndex - 1 || index == targetIndex) {
          return activeColor;
        }
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final $data = ElButtonTheme.of(context);
    final $groupData = _ElButtonGroupInheritedWidget.maybeOf(context)!;

    Color $defaultColor = _Preset.defaultButton(context).borderColor!;
    Color? $hoverColor;
    Color? $activeColor;

    Color? $selectedColor;
    late final double $width;
    final $height = $data.height ?? context.elConfig.size;

    if ($data.type == null && $data.bgColor == null) {
      $width = 1.0;
      $hoverColor = _Preset.defaultButtonHover(context).borderColor!;
      $activeColor = _Preset.defaultButtonActive(context).borderColor!;

      if (_ButtonGroupUtil.isSelected($groupData.modelValue, index)) {
        $selectedColor = _Preset.defaultButtonActive(context).borderColor!;
      } else {
        $selectedColor = null;
      }
    } else {
      final $themeColor = $data.bgColor ?? context.elThemeColors[$data.type]!;
      if ($data.plain == true) {
        $width = 1.0;
        $defaultColor = _Preset.plainButton(
          context,
          type: $data.type,
          bgColor: $data.bgColor,
        ).borderColor!;
        $hoverColor = _Preset.plainButtonHover(
          context,
          type: $data.type,
          bgColor: $data.bgColor,
        ).borderColor!;
        $activeColor = _Preset.plainButtonActive(
          context,
          type: $data.type,
          bgColor: $data.bgColor,
        ).borderColor!;
      } else {
        $width = 1.0;
        $defaultColor = $themeColor.mix(context.lightTheme.bgColor, 50);
      }
    }

    return ObsBuilder(builder: (context) {
      final $hoverIndex = $groupData.hoverIndex.value;
      final $activeIndex = $groupData.activeIndex.value;

      Color? $color;
      if ($activeIndex != -1) {
        if (matchIndex($activeIndex)) {
          $color = $activeColor;
        }
      } else if ($hoverIndex != -1) {
        if (matchIndex($hoverIndex)) {
          $color = $hoverColor;
        }
      }
      return AnimatedColoredBox(
        duration: context.elDuration(_duration),
        color: $selectedColor ?? $color ?? $defaultColor,
        child: SizedBox(
          width: $width,
          height: $height,
        ),
      );
    });
  }
}
