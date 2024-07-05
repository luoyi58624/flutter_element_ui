part of 'split.dart';

/// flex弹性比例放大因子，因为 flex 比例只能是 int 类型，所以我这里将其放大100万倍来保证拖拽的精度。
const int _flexSplitFactor = 1000000;

class ElSplitPanel extends ElSplitFlexPanel {
  /// 分割面板，内部基于 [Row]、[Column] 组件进行排版，它支持嵌套自身
  const ElSplitPanel({
    super.key,
    required this.children,
    this.axis = Axis.horizontal,
  });

  /// 分割面板子节点，只接受 [ElSplitWidget] 抽象类的子类作为子组件：
  /// * ElSplitLayoutWidget - 分割面板，需要继承
  /// * ElSplitResizer - 分割条
  ///
  /// 具体使用只需在布局类之间插入分割条组件即可完成分割，在使用的过程你可能会出现一些断言错误，
  /// 例如：
  /// * 分割条组件不能出现在首尾
  /// * 分割条组件不能重复
  /// * 弹性布局子组件是基于比例计算，但如果存在多个就不可以存在固定尺寸的子组件
  /// * 弹性盒子后面只能存在一个固定尺寸的分割面板
  final List<ElSplitWidget> children;

  /// 布局方向，默认水平布局
  final Axis axis;

  /// 判断当前排版方向是否是水平布局
  static bool isRow(BuildContext context) =>
      _SplitPanelInheritedWidget.of(context).isRow;

  /// 通过上下文拿到最近的分割面板context
  static BuildContext splitPanelContext(BuildContext context) =>
      _SplitPanelInheritedWidget.of(context).splitPanelContext;

  @override
  Widget build(BuildContext context) {
    _assertCheck();
    bool isRow = axis == Axis.horizontal;
    List<Widget> $children = List.from(children);
    // 如果没有分割条组件，则直接将结果进行简单地返回
    if (children.whereType<ElSplitResizer>().isEmpty) {
      $children = $children.map((e) => _splitPanel(e, isRow)).toList();
      return isRow ? Row(children: $children) : Column(children: $children);
    }

    late Widget currentWidget;
    // 如果弹性分割面板存在多个，则使用弹性分割布局计算，否则使用常规布局计算
    if (children.whereType<ElSplitFlexPanel>().length > 1) {
      currentWidget = _calcFlexSplitLayout(context, $children, isRow);
    } else {
      currentWidget = _calcSizeSplitLayout($children, isRow);
    }

    return _SplitPanelInheritedWidget(
      isRow: isRow,
      splitPanelContext: context,
      child: currentWidget,
    );
  }

  Widget _calcSizeSplitLayout(List<Widget> children, bool isRow) {
    Map<String, _SizedBoxSplitData> splitData = {};
    // 处理边缘情况，当第一、第二节点之间不存在分割组件，第一个布局要进行转换
    if (children[1] is! ElSplitResizer) {
      children[0] = _splitPanel(children[0], isRow);
    }
    for (int i = 1; i < children.length - 1; i++) {
      final split = children[i];
      final previous = children[i - 1];
      if (split is ElSplitResizer) {
        assert(
            children[i - 1] is! ElSplitResizer &&
                children[i + 1] is! ElSplitResizer,
            '发现重复的分割条组件，请移除多余的ElSplitResizer');
        assert(previous is! ObsBuilder, '弹性盒子后面只能存在一个固定尺寸的分割面板');
        if (previous is ElSplitSizePanel) {
          final size = Obs(previous.size);
          splitData[previous.id] = _SizedBoxSplitData(
            size: size,
            minSize: previous.minSize,
            maxSize: previous.maxSize,
            reversal: false,
          );
          children[i - 1] = _obsBaseLayout(previous, isRow, size);
          children[i] = _SizeResizerWidget(split, previous.id);
          if (i == children.length - 2) {
            children[i + 1] = _splitPanel(children[i + 1], isRow);
          }
        } else if (previous is ElSplitFlexPanel) {
          // 上一个组件若是弹性盒子，那么这里需要处理两种情况：
          // 1. 下一个组件是指定宽高的面板，我们需要以下一个组件为基准进行分割，
          // 不过调整大小要反过来，这也导致了你不能在后面继续套分割器，这在逻辑上是不合理的行为
          final next = children[i + 1];
          if (next is ElSplitSizePanel) {
            final size = Obs(next.size);
            splitData[next.id] = _SizedBoxSplitData(
              size: size,
              minSize: next.minSize,
              maxSize: next.maxSize,
              reversal: true,
            );
            children[i - 1] = _splitPanel(previous, isRow);
            children[i + 1] = _obsBaseLayout(next, isRow, size);
            children[i] = _SizeResizerWidget(split, next.id);
          }
        }
      } else {
        if (children[i + 1] is! ElSplitResizer) {
          children[i] = _splitPanel(split, isRow);
        }
        if (i == children.length - 2) {
          children[i + 1] = _splitPanel(children[i + 1], isRow);
        }
      }
    }

    return _SizedBoxSplitInheritedWidget(
      splitData: splitData,
      child: DeferredPointerHandler(
        child: axis == Axis.horizontal
            ? Row(children: children)
            : Column(children: children),
      ),
    );
  }

  Widget _calcFlexSplitLayout(
      BuildContext context, List<Widget> children, bool isRow) {
    _FlexSplitDataType splitData = {};
    int sumFlex = 0;
    int? previousSplit;

    for (int i = 1; i < children.length - 1; i++) {
      final child = children[i];
      if (child is ElSplitResizer) {
        assert(
            children[i - 1] is! ElSplitResizer &&
                children[i + 1] is! ElSplitResizer,
            '发现重复的分割条组件，请移除多余的ElSplitResizer');
        final splitWidget = _FlexResizerWidget(child);
        final previous = _buildObsFlexWidget(children[i - 1]);
        final next = _buildObsFlexWidget(children[i + 1]);
        late _FlexSplitData data1;
        late _FlexSplitData data2;
        if (previous != null) {
          children[i - 1] = previous.$1;
          data1 = previous.$2;
          sumFlex += previous.$2.flex.value;
        } else {
          assert(previousSplit != null, elInternalError);
          data1 = splitData[previousSplit!]!.$2;
        }
        if (next != null) {
          children[i + 1] = next.$1;
          data2 = next.$2;
          sumFlex += next.$2.flex.value;
        } else {
          assert(previousSplit != null, elInternalError);
          data2 = splitData[previousSplit!]!.$2;
        }
        children[i] = splitWidget;
        splitData[splitWidget.hashCode] = (data1, data2);
        previousSplit = splitWidget.hashCode;
      }
    }

    return _FlexSplitInheritedWidget(
      splitData: splitData,
      sumFlex: sumFlex,
      child: DeferredPointerHandler(
        child: axis == Axis.horizontal
            ? Row(children: children)
            : Column(children: children),
      ),
    );
  }

  /// 构建响应式弹性分割布局小部件，并返回弹性分割布局配置数据
  (Widget, _FlexSplitData)? _buildObsFlexWidget(Widget child) {
    if (child is ElSplitFlexPanel) {
      final flex = child.flex * _flexSplitFactor;
      final obsFlex = Obs(flex);
      final minFlex = (child.minFlex ?? 0) * _flexSplitFactor;
      int? maxFlex;
      if (child.maxFlex != null) {
        maxFlex = child.maxFlex! * _flexSplitFactor;
      }
      final $child = ObsBuilder(builder: (context) {
        var $flex = max(obsFlex.value, minFlex);
        if (maxFlex != null) {
          $flex = min($flex, maxFlex);
        }
        return Expanded(
          flex: obsFlex.value,
          child: SizedBox.expand(child: child),
        );
      });
      return (
        $child,
        _FlexSplitData(
          flex: obsFlex,
          minFlex: minFlex,
          maxFlex: maxFlex,
        )
      );
    } else {
      return null;
    }
  }

  /// 包装原始小部件，填充内部所有空间
  Widget _splitPanel(Widget child, bool isRow) {
    if (child is ElSplitSizePanel) {
      return SizedBox(
        width: isRow ? child.size : double.infinity,
        height: isRow ? double.infinity : child.size,
        child: child,
      );
    } else if (child is ElSplitFlexPanel) {
      return Expanded(
        flex: child.flex,
        child: SizedBox.expand(child: child),
      );
    } else {
      return child;
    }
  }

  Widget _obsBaseLayout(ElSplitSizePanel child, bool isRow, Obs<double> size) {
    return ObsBuilder(builder: (context) {
      var $size = max(size.value, child.minSize);
      if (child.maxSize != null) $size = min($size, child.maxSize!);
      return SizedBox(
        width: isRow ? $size : double.infinity,
        height: isRow ? double.infinity : $size,
        child: child,
      );
    });
  }

  void _assertCheck() {
    assert(
        children.first is! ElSplitResizer && children.last is! ElSplitResizer,
        'ElSplitResizer分割面板组件必须在两个布局组件之间');
    assert(
        children.whereType<ElSplitSizePanel>().isEmpty ||
            (children.whereType<ElSplitFlexPanel>().length <= 1),
        '检测到当前布局容器中已存在 ElSplitSizePanel，但却存在多个 ElSplitFlexPanel，'
        '你必须使用 ElSplitPanel 包裹多余的 ElSplitFlexPanel');
  }
}

class _SplitPanelInheritedWidget extends InheritedWidget {
  const _SplitPanelInheritedWidget({
    required super.child,
    required this.isRow,
    required this.splitPanelContext,
  });

  final bool isRow;
  final BuildContext splitPanelContext;

  static _SplitPanelInheritedWidget of(BuildContext context) {
    final _SplitPanelInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_SplitPanelInheritedWidget>();
    assert(result != null, 'No _SplitPanelInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_SplitPanelInheritedWidget oldWidget) => false;
}

class _SizedBoxSplitInheritedWidget extends InheritedWidget {
  const _SizedBoxSplitInheritedWidget({
    required super.child,
    required this.splitData,
  });

  final Map<String, _SizedBoxSplitData> splitData;

  static _SizedBoxSplitInheritedWidget of(BuildContext context) {
    final _SizedBoxSplitInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_SizedBoxSplitInheritedWidget>();
    assert(result != null, 'No _SizedBoxSplitInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_SizedBoxSplitInheritedWidget oldWidget) => false;
}

class _FlexSplitInheritedWidget extends InheritedWidget {
  const _FlexSplitInheritedWidget({
    required super.child,
    required this.splitData,
    required this.sumFlex,
  });

  final _FlexSplitDataType splitData;
  final int sumFlex;

  static _FlexSplitInheritedWidget of(BuildContext context) {
    final _FlexSplitInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_FlexSplitInheritedWidget>();
    assert(result != null, 'No _FlexSplitInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_FlexSplitInheritedWidget oldWidget) => false;
}

class _SizedBoxSplitData {
  final Obs<double> size;
  final double minSize;
  final double? maxSize;
  final bool reversal;

  _SizedBoxSplitData({
    required this.size,
    required this.reversal,
    required this.minSize,
    required this.maxSize,
  });
}

typedef _FlexSplitDataType = Map<int, (_FlexSplitData, _FlexSplitData)>;

class _FlexSplitData {
  final Obs<int> flex;
  final int? minFlex;
  final int? maxFlex;

  _FlexSplitData({
    required this.flex,
    required this.minFlex,
    required this.maxFlex,
  });
}
