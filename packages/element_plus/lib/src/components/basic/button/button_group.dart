import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

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
    required this.modelValue,
    required this.type,
    required this.bgColor,
    required this.axis,
    required this.divideColor,
    required this.dividePositionList,
    required this.onChanged,
  });

  final _ButtonGroupType groupType;
  final dynamic modelValue;
  final String type;
  final Color? bgColor;
  final Axis axis;
  final Obs<Color?> divideColor;
  final Obs<List<double>> dividePositionList;
  final ValueChanged onChanged;

  static _ElButtonGroupInheritedWidget of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElButtonGroupInheritedWidget>()!;

  @override
  bool updateShouldNotify(_ElButtonGroupInheritedWidget oldWidget) => false;
}

class ElButtonGroup extends ModelValue {
  /// Element UI 普通按钮组
  const ElButtonGroup({
    super.key,
    required this.children,
    this.type = El.primary,
    this.bgColor,
    this.height,
    this.axis = Axis.horizontal,
  })  : _type = _ButtonGroupType.none,
        mandatory = false,
        super(null, onChanged: null);

  /// Element UI 单选按钮组，[modelValue] 支持 [int]、[ValueNotifier] 类型
  ElButtonGroup.single(
    super.modelValue, {
    super.key,
    required this.children,
    this.type = El.primary,
    this.bgColor,
    this.height,
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
  ElButtonGroup.multi(
    super.modelValue, {
    super.key,
    required this.children,
    this.type = El.primary,
    this.bgColor,
    this.height,
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

  /// 自定义按钮组颜色
  final Color? bgColor;

  /// 按钮组高度，它会强制内部所有按钮都应用此高度
  final double? height;

  /// 按钮组方向
  final Axis axis;

  /// 当选中的值只剩一个时，是否固定它，默认 false
  final bool mandatory;

  @override
  State<ElButtonGroup> createState() => _ElButtonGroupState();
}

class _ElButtonGroupState extends ModelValueState<ElButtonGroup, dynamic> {
  /// 按钮组分割线颜色，它的颜色会和按钮边框同步
  final _divideColor = Obs<Color?>(null);

  /// 需要绘制分割线的按钮 key 列表，当构建完成按钮组后，会在下一帧通过这些 key 计算每个分割线的位置
  List<GlobalKey> _childrenKeyList = [];

  /// 按钮组分割线的偏移位置，分割线是通过 Stack 布局绘制上去的
  final _dividePositionList = Obs<List<double>>([]);

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

  bool get _hasSelected => modelValue is List
      ? (modelValue as List).isNotEmpty
      : modelValue != null &&
          modelValue is int &&
          modelValue >= 0 &&
          modelValue <= widget.children.length - 1;

  void _setChildrenKeyList(int length) {
    if (length <= 1) {
      _childrenKeyList.clear();
    } else {
      _childrenKeyList =
          List.generate(widget.children.length - 1, (i) => GlobalKey())
              .toList();
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

  @override
  Widget builder(BuildContext context) {
    ElSize.of(context);
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
      result = Column(
        mainAxisSize: MainAxisSize.min,
        children: $children,
      );
    }

    return _ElButtonGroupInheritedWidget(
      groupType: widget._type,
      modelValue: modelValue,
      type: widget.type,
      bgColor: widget.bgColor,
      axis: widget.axis,
      divideColor: _divideColor,
      dividePositionList: _dividePositionList,
      onChanged: _onChange,
      child: Stack(
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
      ),
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
    final $groupData = _ElButtonGroupInheritedWidget.of(context);

    Color bgColor =
        $groupData.bgColor ?? context.elThemeColors[$groupData.type]!;
    final isHorizontal = $groupData.axis == Axis.horizontal;

    return ObsBuilder(builder: (context) {
      final $dividePositionList = $groupData.dividePositionList.value;
      if ($dividePositionList.length != length - 1) return const SizedBox();

      late double $borderSize;
      late Color $borderColor;
      final $modelValue = $groupData.modelValue;

      if ($groupData.groupType == _ButtonGroupType.none) {
        $borderSize = context.commonSizePreset.borderWidth!;
        $borderColor = bgColor.mix(Colors.white, 50);
      } else {
        // 判断多选主题类型按钮组 selected 是否相邻，需要在中间绘制比较显眼的分割线
        bool isUnionBorder = false;
        $borderSize = context.commonSizePreset.borderWidth!;
        $borderColor = context.elTheme.layoutTheme.borderColor!;

        if (hasSelected) {
          if ($groupData.groupType == _ButtonGroupType.single) {
            if (matchIndex($modelValue)) {
              $borderColor = bgColor;
            }
          } else {
            ($modelValue as List<int>).sort();
            for (int i in $modelValue) {
              if (i == index) {
                if ($modelValue.contains(i + 1)) {
                  isUnionBorder = true;
                }
                break;
              }
            }
            for (int i in $modelValue) {
              if (matchIndex(i)) {
                $borderColor = bgColor;
                break;
              }
            }

            if (isUnionBorder) {
              $borderColor = bgColor.mix(Colors.white, 50);
            }
          }
        }
      }

      Widget result = SizedBox(
        width: isHorizontal ? $borderSize : null,
        height: isHorizontal ? null : $borderSize,
      );

      result = AnimatedColoredBox(
        duration: context.elDuration(const Duration(milliseconds: 80)),
        color: $borderColor,
        child: result,
      );

      return Positioned(
        left: isHorizontal ? $dividePositionList[index] : 0,
        right: !isHorizontal ? 0 : null,
        top: !isHorizontal ? $dividePositionList[index] : 0,
        bottom: isHorizontal ? 0 : null,
        child: IgnorePointer(
          child: result,
        ),
      );
    });
  }
}

class ElButtonGroupItem extends ElButton {
  /// Element UI 按钮组子项，它必须放置于 [ElButtonGroup] 中
  const ElButtonGroupItem({
    super.key,
    required super.child,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  @override
  State<ElButtonGroupItem> createState() => _ElButtonGroupItemState();
}

class _ElButtonGroupItemState extends ElButtonState<ElButtonGroupItem> {
  late _ElButtonGroupInheritedWidget _groupWidget;
  late ElChildIndex _indexData;
  late bool _isHorizontal;
  late bool _hasStatus; // 是否为有状态按钮组
  bool _hasSelected = false; // 当前按钮是否被选中

  @override
  String? get type => _groupWidget.type;

  @override
  Color? get bgColor => _groupWidget.bgColor;

  @override
  EdgeInsets get padding => isIconChild ? EdgeInsets.zero : super.padding;

  @override
  ElButtonColorRecord buildColorRecord(BuildContext context) {
    if (_hasStatus) {
      return (
        bgColor: _hasSelected ? themeBgColor : context.currentBgColor,
        textColor: _hasSelected
            ? themeBgColor.elTextColor(context)
            : context.hasHover || context.hasTap
                ? themeBgColor
                : context.elTheme.textTheme.regularStyle.color,
        borderColor: null,
      );
    } else {
      return super.buildColorRecord(context);
    }
  }

  @override
  BorderRadius? get borderRadius {
    final borderRadius = super.borderRadius!;

    if (_indexData.length == 1) return borderRadius;
    if (_indexData.index == 0) {
      return BorderRadius.only(
        topLeft: borderRadius.topLeft,
        topRight: !_isHorizontal ? borderRadius.topLeft : Radius.zero,
        bottomLeft: _isHorizontal ? borderRadius.bottomLeft : Radius.zero,
      );
    }
    if (_indexData.index == _indexData.length! - 1) {
      return BorderRadius.only(
        topRight: _isHorizontal ? borderRadius.topRight : Radius.zero,
        bottomLeft: !_isHorizontal ? borderRadius.topLeft : Radius.zero,
        bottomRight: borderRadius.bottomRight,
      );
    }

    return null;
  }

  @override
  Border? get border {
    if (_hasStatus) {
      final borderColor = _hasSelected
          ? themeBgColor
          : context.elTheme.layoutTheme.borderColor!;
      final borderWidth = commonSizePreset.borderWidth!;
      final defaultBorder = Border.all(
        color: borderColor,
        width: borderWidth,
      );
      if (_indexData.length == 1) return defaultBorder;
      final borderSide = BorderSide(
        color: borderColor,
        width: borderWidth,
      );
      if (_indexData.index == 0) {
        return Border(
          top: borderSide,
          bottom: _isHorizontal ? borderSide : BorderSide.none,
          left: borderSide,
          right: !_isHorizontal ? borderSide : BorderSide.none,
        );
      }
      if (_indexData.index == _indexData.length! - 1) {
        return Border(
          top: _isHorizontal ? borderSide : BorderSide.none,
          bottom: borderSide,
          left: !_isHorizontal ? borderSide : BorderSide.none,
          right: borderSide,
        );
      }
      return Border(
        top: _isHorizontal ? borderSide : BorderSide.none,
        bottom: _isHorizontal ? borderSide : BorderSide.none,
        left: !_isHorizontal ? borderSide : BorderSide.none,
        right: !_isHorizontal ? borderSide : BorderSide.none,
      );
    }
    return null;
  }

  @override
  void onPressed() {
    _groupWidget.onChanged(_indexData.index);
    super.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    _groupWidget = _ElButtonGroupInheritedWidget.of(context);
    _indexData = ElChildIndex.of(context);
    _isHorizontal = _groupWidget.axis == Axis.horizontal;
    _hasStatus = _groupWidget.groupType != _ButtonGroupType.none;

    _hasSelected = false;
    if (_groupWidget.modelValue != null) {
      if (_groupWidget.modelValue is List) {
        if (_groupWidget.modelValue.contains(_indexData.index)) {
          _hasSelected = true;
        }
      } else if (_groupWidget.modelValue == _indexData.index) {
        _hasSelected = true;
      }
    }

    return super.build(context);
  }
}
