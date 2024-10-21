part of 'index.dart';

class ElButtonGroup extends HookWidget {
  /// Element UI 按钮组，可以在 [ElButtonThemeData] 中进行更多配置
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

  /// 按钮集合，注意：在按钮组模式下，[ElButton] 的很多属性不能直接使用
  final List<ElButton> children;

  /// 按钮组方向
  final Axis axis;

  /// 是否必须选择一个值，默认 false
  final bool mandatory;

  /// 更新事件
  final ValueChanged? onChanged;

  /// 计算按钮组选中逻辑
  void _onChange(dynamic value) {
    dynamic $modelValue = modelValue;
    dynamic $value;

    if (modelValue is ValueNotifier) {
      $modelValue = (modelValue as ValueNotifier).value;
    }

    if ($modelValue is int) {
      if ($modelValue == value) {
        if (mandatory == false) {
          $value = -1;
        }
      } else {
        $value = value;
      }
    } else if ($modelValue is List) {
      final list = List<int>.from($modelValue);
      if (list.contains(value)) {
        if (list.length == 1) {
          if (mandatory == false) {
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

    if (modelValue is ValueNotifier) {
      (modelValue as ValueNotifier).value = $value;
    }

    if (onChanged != null) onChanged!($value);
  }

  @override
  Widget build(BuildContext context) {
    final $hoverIndex = useObs(-1);
    final $borderColor = Obs<Color?>(null);
    final $data = ElButtonTheme.of(context);
    final $modelValue = modelValue is ValueNotifier
        ? (modelValue as ValueNotifier).value
        : modelValue;
    ElAssert.themeType($data.type, 'ElButtonGroup');
    final List<Widget> $children = [];
    int $length = children.length;
    for (int i = 0; i < $length; i++) {
      Widget itemWidget = ChildIndexData(
        length: $length,
        index: i,
        child: children[i],
      );
      if ($data.block == true) {
        if (children[i].block == null) {
          itemWidget = Expanded(child: itemWidget);
        } else {
          if (children[i].block != false) {
            itemWidget = Expanded(child: itemWidget);
          }
        }
      } else {
        if (children[i].block == true) {
          itemWidget = Expanded(child: itemWidget);
        }
      }
      $children.add(itemWidget);
      if ($data.text != true && i < $length - 1) {
        $children.add(_GroupDivide(
          modelValue: $modelValue,
          length: $length,
          index: i,
          hoverIndex: $hoverIndex,
          borderColor: $borderColor,
        ));
      }
    }

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
      modelValue: $modelValue,
      axis: axis,
      hoverIndex: $hoverIndex,
      borderColor: $borderColor,
      onChanged: _onChange,
      child: result,
    );
  }
}

/// 按钮组分割线
class _GroupDivide extends StatelessWidget {
  const _GroupDivide({
    required this.modelValue,
    required this.length,
    required this.index,
    required this.hoverIndex,
    required this.borderColor,
  });

  final dynamic modelValue;
  final int length;
  final int index;
  final Obs<int> hoverIndex;
  final Obs<Color?> borderColor;

  bool _isActive(int targetIndex) {
    int $hoverIndex = hoverIndex.value;
    int? activeIndex;
    if (_ButtonGroupUtil.isSelected(modelValue, index)) {
      activeIndex = index;
    }

    if ($hoverIndex == targetIndex) {
      return true;
    }
    if (activeIndex != null && activeIndex == targetIndex) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final $data = ElButtonTheme.of(context);
    final $groupData = _ElButtonGroupInheritedWidget.maybeOf(context)!;
    late final Color $borderColor;
    late final double $width;
    final $height = $data.height ?? context.elConfig.size;

    if ($data.type == null && $data.bgColor == null) {
      $width = 1.0;
      // if (_ButtonGroupUtil.isSelected($groupData.modelValue, index)) {
      //   $borderColor = _ButtonStyleUtil.defaultStyle(
      //     context,
      //     disabled: false,
      //     isHover: true,
      //   ).borderColor!;
      // } else {
      //   $borderColor = context.elTheme.borderColor;
      // }
      $borderColor = context.elTheme.borderColor;
    } else {
      if ($data.plain == true) {
        $width = 1.0;
        $borderColor = _ButtonStyleUtil.plainStyle(
          context,
          type: $data.type,
          bgColor: $data.bgColor,
          disabled: false,
          isHover: false,
          isTap: false,
        ).borderColor!;
      } else {
        $width = 0.5;
        $borderColor = context.isDark
            ? context.lightTheme.bgColor
            : context.elTheme.borderColor;
      }
    }

    return ObsBuilder(
        watch: [hoverIndex],
        builder: (context) {
          Color color = $borderColor;
          int $hoverIndex = hoverIndex.value;

          Color hoverBorderColor = borderColor.value ?? $borderColor;
          if (length == 2) {
            color = $hoverIndex != -1 ? hoverBorderColor : $borderColor;
          } else if (length > 2) {
            if ($hoverIndex == 0) {
              if (index == $hoverIndex) color = hoverBorderColor;
            } else if ($hoverIndex == length - 1) {
              if (index == $hoverIndex - 1) color = hoverBorderColor;
            } else if ($hoverIndex != -1) {
              if (index == $hoverIndex - 1 || index == $hoverIndex) {
                color = hoverBorderColor;
              }
            }
          }

          return AnimatedColoredBox(
            duration: context.elDuration(_duration),
            color: color,
            child: SizedBox(
              width: $width,
              height: $height,
            ),
          );
        });
  }
}

class _ElButtonGroupInheritedWidget extends InheritedWidget {
  const _ElButtonGroupInheritedWidget({
    required this.modelValue,
    required this.axis,
    required this.hoverIndex,
    required this.borderColor,
    required this.onChanged,
    required super.child,
  });

  final dynamic modelValue;
  final Axis axis;
  final Obs<int> hoverIndex;
  final Obs<Color?> borderColor;
  final ValueChanged onChanged;

  static _ElButtonGroupInheritedWidget? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElButtonGroupInheritedWidget>();

  @override
  bool updateShouldNotify(_ElButtonGroupInheritedWidget oldWidget) => true;
}
