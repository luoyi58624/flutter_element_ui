part of 'split.dart';

class ElSplitResizer extends ElSplitWidget {
  /// 分割条组件，它用于调整两个布局之间的尺寸
  const ElSplitResizer({
    super.key,
    this.size = 0,
    this.triggerSize = 6,
  });

  /// 控件占据页面的空间
  final double size;

  /// 可拖拽控件触发范围
  final double triggerSize;

  @override
  Widget build(BuildContext context) {
    return ElSplitPanel.isRow(context)
        ? SizedBox(width: size, height: double.infinity)
        : SizedBox(height: size, width: double.infinity);
  }
}

class _SizedBoxSplitWidget extends HookWidget {
  const _SizedBoxSplitWidget(this.child, this.layoutId);

  final ElSplitResizer child;
  final String layoutId;

  void update(_SizedBoxSplitData data, double value) {
    data.reversal ? data.size.value -= value : data.size.value += value;
  }

  @override
  Widget build(BuildContext context) {
    final isRow = ElSplitPanel.isRow(context);
    final $data = _SizedBoxSplitInheritedWidget.of(context);
    final splitData = $data.splitData[layoutId]!;
    final isActive = useObs(false);
    final triggerSize = child.triggerSize;
    final triggerOffsetSize = -(triggerSize / 2);

    final splitActiveWidget = ObsBuilder(builder: (context) {
      return Container(
        color: isActive.value ? Colors.cyan : null,
      );
    });

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: isRow ? 0 : triggerOffsetSize,
          bottom: isRow ? 0 : triggerOffsetSize,
          left: isRow ? triggerOffsetSize : 0,
          right: isRow ? triggerOffsetSize : 0,
          child: DeferPointer(
            paintOnTop: true,
            child: isRow
                ? GestureDetector(
                    onHorizontalDragStart: (e) {
                      isActive.value = true;
                    },
                    onHorizontalDragUpdate: (e) {
                      if (isActive.value) {
                        update(splitData, e.delta.dx);
                      }
                    },
                    onHorizontalDragEnd: (e) {
                      isActive.value = false;
                    },
                    onHorizontalDragCancel: () {
                      isActive.value = false;
                    },
                    child: HoverBuilder(
                      cursor: SystemMouseCursors.resizeColumn,
                      builder: (isHover) => splitActiveWidget,
                    ),
                  )
                : GestureDetector(
                    onVerticalDragStart: (e) {
                      isActive.value = true;
                    },
                    onVerticalDragUpdate: (e) {
                      if (isActive.value) {
                        update(splitData, e.delta.dy);
                      }
                    },
                    onVerticalDragEnd: (e) {
                      isActive.value = false;
                    },
                    onVerticalDragCancel: () {
                      isActive.value = false;
                    },
                    child: HoverBuilder(
                      cursor: SystemMouseCursors.resizeRow,
                      builder: (isHover) => splitActiveWidget,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

class _FlexSplitWidget extends HookWidget {
  const _FlexSplitWidget(this.child);

  final ElSplitResizer child;

  void updateSizedBoxLayout(_SizedBoxSplitData data, double value) {
    data.reversal ? data.size.value -= value : data.size.value += value;
  }

  @override
  Widget build(BuildContext context) {
    final isRow = ElSplitPanel.isRow(context);
    final $data = _FlexSplitInheritedWidget.of(context);
    final (data1, data2) = $data.splitData[hashCode]!;
    final isActive = useObs(false);
    final triggerSize = child.triggerSize;
    final triggerOffsetSize = -(triggerSize / 2);

    final splitActiveWidget = ObsBuilder(builder: (context) {
      return Container(
        color: isActive.value ? Colors.cyan : null,
      );
    });

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: isRow ? 0 : triggerOffsetSize,
          bottom: isRow ? 0 : triggerOffsetSize,
          left: isRow ? triggerOffsetSize : 0,
          right: isRow ? triggerOffsetSize : 0,
          child: DeferPointer(
            paintOnTop: true,
            child: isRow
                ? GestureDetector(
                    onHorizontalDragStart: (e) {
                      isActive.value = true;
                    },
                    onHorizontalDragUpdate: (e) {
                      if (isActive.value) {
                        final sumFlex = data1.flex.value + data2.flex.value;
                        var value = (e.delta.dx /
                            (sumFlex /
                                $data.sumFlex *
                                ElSplitPanel.splitPanelContext(context)
                                    .size!
                                    .width));
                        final flexValue = (sumFlex * value).floor();
                        data1.flex.value += flexValue;
                        data2.flex.value -= flexValue;
                      }
                    },
                    onHorizontalDragEnd: (e) {
                      isActive.value = false;
                    },
                    onHorizontalDragCancel: () {
                      isActive.value = false;
                    },
                    child: HoverBuilder(
                      cursor: SystemMouseCursors.resizeColumn,
                      builder: (isHover) => splitActiveWidget,
                    ),
                  )
                : GestureDetector(
                    onVerticalDragStart: (e) {
                      isActive.value = true;
                    },
                    onVerticalDragUpdate: (e) {
                      if (isActive.value) {}
                    },
                    onVerticalDragEnd: (e) {
                      isActive.value = false;
                    },
                    onVerticalDragCancel: () {
                      isActive.value = false;
                    },
                    child: HoverBuilder(
                      cursor: SystemMouseCursors.resizeRow,
                      builder: (isHover) => splitActiveWidget,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
