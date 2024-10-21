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

  /// 是否必须强制选择一个值，默认 false
  final bool mandatory;

  /// 更新事件
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    final $hoverIndex = useObs(-1);
    final $borderColor = Obs<Color?>(null);
    final $data = ElButtonTheme.of(context);
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
      modelValue: modelValue,
      axis: axis,
      hoverIndex: $hoverIndex,
      borderColor: $borderColor,
      onChanged: onChanged,
      child: result,
    );
  }
}

/// 按钮组分割线
class _GroupDivide extends StatelessWidget {
  const _GroupDivide({
    required this.length,
    required this.index,
    required this.hoverIndex,
    required this.borderColor,
  });

  final int length;
  final int index;
  final Obs<int> hoverIndex;
  final Obs<Color?> borderColor;

  @override
  Widget build(BuildContext context) {
    final $data = ElButtonTheme.of(context);
    late final Color $borderColor;
    late final double $width;
    final $height = $data.height ?? context.elConfig.size;

    if ($data.type == null && $data.bgColor == null) {
      $width = 1.0;
      $borderColor = context.elTheme.borderColor;
    } else {
      if ($data.plain == true) {
        $width = 1.0;
        $borderColor = _ButtonStyleUtil.plainStyle(
          context,
          type: $data.type,
          bgColor: $data.bgColor,
          disabled: false,
          triggerEvent: false,
        ).borderColor!;
      } else {
        $width = 0.5;
        $borderColor = context.isDark
            ? context.lightTheme.bgColor
            : context.elTheme.borderColor;
      }
    }

    return ObsBuilder(builder: (context) {
      Color color = $borderColor;
      Color hoverBorderColor = borderColor.value ?? $borderColor;
      if (length == 2) {
        color = hoverIndex.value != -1 ? hoverBorderColor : $borderColor;
      } else if (length > 2) {
        if (hoverIndex.value == 0) {
          if (index == hoverIndex.value) color = hoverBorderColor;
        } else if (hoverIndex.value == length - 1) {
          if (index == hoverIndex.value - 1) color = hoverBorderColor;
        } else if (hoverIndex.value != -1) {
          if (index == hoverIndex.value - 1 || index == hoverIndex.value) {
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
  final ValueChanged? onChanged;

  static _ElButtonGroupInheritedWidget? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElButtonGroupInheritedWidget>();

  @override
  bool updateShouldNotify(_ElButtonGroupInheritedWidget oldWidget) => true;
}
