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
    final $borderColor = useObs<Color?>(null);
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

