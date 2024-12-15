import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';
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
    required this.modelValue,
    required this.type,
    required this.axis,
    required this.onChanged,
  });

  final _ButtonGroupType groupType;
  final dynamic modelValue;
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

  bool get _hasSelected => modelValue is List
      ? (modelValue as List).isNotEmpty
      : modelValue != null &&
          modelValue is int &&
          modelValue >= 0 &&
          modelValue <= widget.children.length - 1;

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
    List<Widget> $children = [];

    int $length = widget.children.length;
    for (int i = 0; i < $length; i++) {
      Widget itemWidget = ElChildIndex(
        length: $length,
        index: i,
        child: widget.children[i],
      );

      $children.add(itemWidget);
      if (i < $length - 1) {
        $children.add(
          _GroupDivideWidget(axis: widget.axis),
        );
      }
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
      axis: widget.axis,
      onChanged: _onChange,
      child: result,
    );
  }
}

class _GroupDivideWidget extends StatelessWidget {
  const _GroupDivideWidget({required this.axis});

  final Axis axis;

  @override
  Widget build(BuildContext context) {
    late Widget result;
    if (axis == Axis.horizontal) {
      result = const SizedBox(width: 0.1);
    } else {
      result = const SizedBox(height: 0.1);
    }
    return result;
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
  late bool _isHorizontal;
  late bool _hasStatus; // 是否为有状态按钮组
  bool _hasSelected = false; // 当前按钮是否被选中

  @override
  String? get type => _groupWidget.type;

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
      final defaultBorder = Border.all(
        color: borderColor,
        width: 1.0,
      );
      if (_indexData.length == 1) return defaultBorder;
      final borderSide = BorderSide(
        color: borderColor,
        width: 1.0,
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
