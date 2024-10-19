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

  /// 由于 Dart 不支持联合类型，所以在这里说明一下 [modelValue] 支持的类型：
  /// * null 按钮组无需选中状态
  /// * int || ValueNotifier<int> 选中的按钮索引，支持双向绑定
  /// * List<int> || ValueNotifier<List<int>> 选中多个按钮
  final dynamic modelValue;

  /// 按钮集合
  final List<ElButton> children;

  /// 按钮组方向
  final Axis axis;

  /// 是否必须强制选择一个值，默认 false
  final bool mandatory;

  /// 更新事件，建议使用双向绑定的方式更新数据
  final ValueChanged? onChanged;

  @override
  Widget build(BuildContext context) {
    final hoverIndex = useObs(-1);
    final isActive = useObs(false);
    final $data = ElButtonTheme.of(context);
    ElAssert.themeType($data.type, 'ElButtonGroup');
    final List<Widget> $children = [];
    int $length = children.length;
    for (int i = 0; i < $length; i++) {
      $children.add(
        ChildIndexData(
          length: $length,
          index: i,
          child: children[i],
        ),
      );
      if (i < $length - 1) {
        $children.add(_GroupBorder(
          length: $length,
          index: i,
          hoverIndex: hoverIndex,
          isActive: isActive,
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
      themeData: $data,
      axis: axis,
      hoverIndex: hoverIndex,
      isActive: isActive,
      onChanged: onChanged,
      child: result,
    );
  }
}

class _GroupBorder extends StatelessWidget {
  const _GroupBorder({
    required this.length,
    required this.index,
    required this.hoverIndex,
    required this.isActive,
  });

  final int length;
  final int index;
  final Obs<int> hoverIndex;
  final Obs<bool> isActive;

  @override
  Widget build(BuildContext context) {
    final $data = _ElButtonGroupInheritedWidget.maybeOf(context)!;

    return ObsBuilder(builder: (context) {
      Color borderColor = context.elTheme.borderColor;
      Color hoverBorderColor = isActive.value
          ? context.elTheme.primary
          : context.elTheme.primary.elLight6(context);

      Color $borderColor = borderColor;
      if (length == 2) {
        $borderColor = hoverIndex.value != -1 ? hoverBorderColor : borderColor;
      } else if (length > 2) {
        if (hoverIndex.value == 0) {
          if (index == hoverIndex.value) $borderColor = hoverBorderColor;
        } else if (hoverIndex.value == length - 1) {
          if (index == hoverIndex.value - 1) $borderColor = hoverBorderColor;
        } else if (hoverIndex.value != -1) {
          if (index == hoverIndex.value - 1 || index == hoverIndex.value) {
            $borderColor = hoverBorderColor;
          }
        }
      }

      return AnimatedColoredBox(
        duration: 100.ms,
        color: $borderColor,
        child: SizedBox(
          width: 1,
          height: $data.themeData.height ?? context.elConfig.size,
        ),
      );
    });
  }
}

class _ElButtonGroupInheritedWidget extends InheritedWidget {
  const _ElButtonGroupInheritedWidget({
    required this.modelValue,
    required this.themeData,
    required this.axis,
    required this.hoverIndex,
    required this.isActive,
    required this.onChanged,
    required super.child,
  });

  final dynamic modelValue;
  final ElButtonThemeData themeData;
  final Axis axis;
  final Obs<int> hoverIndex;
  final Obs<bool> isActive;
  final ValueChanged? onChanged;

  static _ElButtonGroupInheritedWidget? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElButtonGroupInheritedWidget>();

  @override
  bool updateShouldNotify(_ElButtonGroupInheritedWidget oldWidget) => true;
}
