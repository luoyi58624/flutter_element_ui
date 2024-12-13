import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';

enum _ButtonGroupType {
  none,
  single,
  multi,
}

class _ElButtonGroupInheritedWidget extends InheritedWidget {
  const _ElButtonGroupInheritedWidget({
    required super.child,
    required this.groupType,
    required this.type,
    required this.axis,
    required this.onChanged,
  });

  final _ButtonGroupType groupType;
  final String type;
  final Axis axis;
  final ValueChanged onChanged;

  static _ElButtonGroupInheritedWidget of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElButtonGroupInheritedWidget>()!;

  @override
  bool updateShouldNotify(_ElButtonGroupInheritedWidget oldWidget) => false;
}

class ElButtonGroup2 extends ModelValue {
  /// Element UI 普通按钮组
  const ElButtonGroup2({
    super.key,
    required this.children,
    this.type = El.primary,
    this.axis = Axis.horizontal,
  })  : _type = _ButtonGroupType.none,
        mandatory = false,
        super(null, onChanged: null);

  /// Element UI 单选按钮组，[modelValue] 支持 [int]、[ValueNotifier] 类型
  ElButtonGroup2.single(
    super.modelValue, {
    super.key,
    required this.children,
    this.type = El.primary,
    this.axis = Axis.horizontal,
    this.mandatory = false,
    super.onChanged,
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
  ElButtonGroup2.multi(
    super.modelValue, {
    super.key,
    required this.children,
    this.type = El.primary,
    this.axis = Axis.horizontal,
    this.mandatory = false,
    super.onChanged,
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

  /// 按钮组子项集合
  final List<ElButtonGroupItem> children;

  /// 按钮组类型
  final String type;

  /// 按钮组方向
  final Axis axis;

  /// 当选中的值只剩一个时，是否固定它，默认 false
  final bool mandatory;

  @override
  State<ElButtonGroup2> createState() => _ElButtonGroupState();
}

class _ElButtonGroupState extends ModelValueState<ElButtonGroup2, dynamic> {
  /// 按钮组分割线颜色，它的颜色会和按钮边框同步
  final _divideColor = Obs<Color?>(null);

  /// 需要绘制分割线的按钮 key 列表，当构建完成按钮组后，会在下一帧通过这些 key 计算每个分割线的位置
  List<GlobalKey> _childrenKeyList = [];

  /// 按钮组分割线的偏移位置，分割线是通过 Stack 布局绘制上去的
  final _dividePositionList = Obs<List<double>>([]);

  bool get _hasSelected => modelValue is List
      ? (modelValue as List).isNotEmpty
      : modelValue != null &&
          modelValue is int &&
          modelValue >= 0 &&
          modelValue <= widget.children.length - 1;

  @override
  void initState() {
    super.initState();
    _setChildrenKeyList(widget.children.length);
  }

  @override
  void didUpdateWidget(covariant ElButtonGroup2 oldWidget) {
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
      if (isReactive) {
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
        final offset = _childrenKeyList[i].currentContext!.getPosition(context);
        $list.add(widget.axis == Axis.horizontal ? offset.dx : offset.dy);
      }
      if (_dividePositionList.value.eq($list) == false) {
        _dividePositionList.value = $list;
      }
    });
  }

  @override
  Widget builder(BuildContext context) {
    List<Widget> $children = [];

    int $length = widget.children.length;
    for (int i = 0; i < $length; i++) {
      Widget itemWidget = ElChildIndex(
        length: $length,
        index: i,
        child: widget.children[i],
      );

      $children.add(itemWidget);
    }

    if ($length > 1) {
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
        mainAxisSize: MainAxisSize.min,
        children: $children,
      );
    } else {
      result = IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: $children,
        ),
      );
    }

    return _ElButtonGroupInheritedWidget(
      groupType: widget._type,
      type: widget.type,
      axis: widget.axis,
      onChanged: _onChange,
      child: Stack(
        children: [
          result,
          // ..._childrenKeyList.mapIndexed(
          //   (i, e) => _GroupDivide(
          //     length: $length,
          //     index: i,
          //     hasSelected: _hasSelected,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ElButtonGroupItem extends ElButton2 {
  /// Element UI 按钮组子项，它必须放置于 [ElButtonGroup2] 中
  const ElButtonGroupItem({
    super.key,
    required super.child,
    super.autofocus,
    super.disabled,
    super.onPressed,
  });

  @override
  State<ElButtonGroupItem> createState() => _ElButtonGroupItemState();
}

class _ElButtonGroupItemState extends ElButton2State<ElButtonGroupItem> {
  late _ElButtonGroupInheritedWidget _groupWidget;
  late ElChildIndex _indexData;
  late bool isHorizontal;

  @override
  String? get type => _groupWidget.type;

  // @override
  // ElButtonColorRecord buildColorRecord(BuildContext context) {
  //   return (
  //     bgColor: themeBgColor,
  //     textColor: themeBgColor.elTextColor(context),
  //     borderColor: null,
  //   );
  // }

  @override
  BorderRadius? get borderRadius {
    final borderRadius = super.borderRadius!;

    if (_indexData.length == 1) return borderRadius;
    if (_indexData.index == 0) {
      return BorderRadius.only(
        topLeft: borderRadius.topLeft,
        topRight: !isHorizontal ? borderRadius.topLeft : Radius.zero,
        bottomLeft: isHorizontal ? borderRadius.bottomLeft : Radius.zero,
      );
    }
    if (_indexData.index == _indexData.length! - 1) {
      return BorderRadius.only(
        topRight: isHorizontal ? borderRadius.topRight : Radius.zero,
        bottomLeft: !isHorizontal ? borderRadius.topLeft : Radius.zero,
        bottomRight: borderRadius.bottomRight,
      );
    }

    return null;
  }

  @override
  Border? get border {
    if (_groupWidget.groupType == _ButtonGroupType.none) return null;
  }

  @override
  Widget build(BuildContext context) {
    _groupWidget = _ElButtonGroupInheritedWidget.of(context);
    _indexData = ElChildIndex.of(context);
    isHorizontal = _groupWidget.axis == Axis.horizontal;
    return super.build(context);
  }
}
